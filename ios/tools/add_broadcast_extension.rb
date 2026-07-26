#!/usr/bin/env ruby
# Adds the Fernwartung Broadcast Upload Extension target to Runner.xcodeproj so
# the GitHub macOS runner builds + embeds it automatically (no manual Xcode).
# Idempotent: safe to run on every CI build. Requires the `xcodeproj` gem
# (gem install xcodeproj). Run from the repo root or ios/:
#   ruby ios/tools/add_broadcast_extension.rb
require 'xcodeproj'

EXT       = 'BroadcastExtension'
EXT_BUNDLE = 'de.icd360s.icd360sevMitglied.Broadcast'
DEPLOY    = '14.0'
SRC_FILES = %w[SampleHandler.swift SocketConnection.swift SampleUploader.swift
               DarwinNotificationCenter.swift Atomic.swift]

here = File.dirname(__FILE__)
proj_path = File.expand_path(File.join(here, '..', 'Runner.xcodeproj'))
project = Xcodeproj::Project.open(proj_path)

existing = project.targets.find { |t| t.name == EXT }
if existing
  # Self-heal: an earlier run created the target without PRODUCT_NAME, which made
  # Xcode emit a nameless '.appex' ("Multiple commands produce"). Ensure it is set.
  changed = false
  existing.build_configurations.each do |c|
    if c.build_settings['PRODUCT_NAME'].to_s.empty?
      c.build_settings['PRODUCT_NAME'] = '$(TARGET_NAME)'
      changed = true
    end
  end
  if changed
    project.save
    puts "[add_broadcast_extension] Patched PRODUCT_NAME on existing '#{EXT}'."
  else
    puts "[add_broadcast_extension] '#{EXT}' already present + configured — nothing to do."
  end
  exit 0
end

runner = project.targets.find { |t| t.name == 'Runner' } or abort('Runner target not found')

ext = project.new_target(:app_extension, EXT, :ios, DEPLOY)

# Group + source files (paths relative to the ios/ project dir).
group = project.main_group.find_subpath(EXT, true)
group.set_source_tree('SOURCE_ROOT')
SRC_FILES.each do |f|
  ref = group.new_reference("#{EXT}/#{f}")
  ext.add_file_references([ref])
end

ext.build_configurations.each do |c|
  bs = c.build_settings
  bs['PRODUCT_NAME']             = '$(TARGET_NAME)'
  bs['PRODUCT_BUNDLE_IDENTIFIER'] = EXT_BUNDLE
  bs['INFOPLIST_FILE']           = "#{EXT}/Info.plist"
  bs['CODE_SIGN_ENTITLEMENTS']   = "#{EXT}/BroadcastExtension.entitlements"
  bs['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOY
  bs['SWIFT_VERSION']            = '5.0'
  bs['CODE_SIGN_STYLE']          = 'Automatic'
  bs['GENERATE_INFOPLIST_FILE']  = 'NO'
  bs['SKIP_INSTALL']             = 'YES'
  bs['CURRENT_PROJECT_VERSION']  = '$(FLUTTER_BUILD_NUMBER)'
  bs['MARKETING_VERSION']        = '$(FLUTTER_BUILD_NAME)'
  bs['TARGETED_DEVICE_FAMILY']   = '1,2'
end

# Runner depends on the extension and embeds it in PlugIns/.
runner.add_dependency(ext)
embed = runner.copy_files_build_phases.find { |p| p.symbol_dst_subfolder_spec == :plug_ins }
embed ||= runner.new_copy_files_build_phase('Embed App Extensions')
embed.symbol_dst_subfolder_spec = :plug_ins
bf = embed.add_file_reference(ext.product_reference, true)
bf.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }

project.save
puts "[add_broadcast_extension] Added '#{EXT}' target + embed phase."
