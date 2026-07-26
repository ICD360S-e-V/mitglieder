#!/usr/bin/env ruby
# Adds the Fernwartung Broadcast Upload Extension target to Runner.xcodeproj so
# the GitHub macOS runner builds + embeds it automatically (no manual Xcode).
# Idempotent + self-healing: safe to run on every CI build. Requires the
# `xcodeproj` gem (gem install xcodeproj). Run from repo root or ios/:
#   ruby ios/tools/add_broadcast_extension.rb
require 'xcodeproj'

EXT        = 'BroadcastExtension'
EXT_BUNDLE = 'de.icd360s.icd360sevMitglied.Broadcast'
DEPLOY     = '14.0'
SRC_FILES  = %w[SampleHandler.swift SocketConnection.swift SampleUploader.swift
                DarwinNotificationCenter.swift Atomic.swift]

# The "Embed App Extensions" copy phase MUST run BEFORE Flutter's "Thin Binary"
# script phase, otherwise the new build system reports "Cycle inside Runner".
def move_embed_before_thin(runner)
  embed = runner.copy_files_build_phases.find { |p| p.symbol_dst_subfolder_spec == :plug_ins }
  return false unless embed
  thin_idx = runner.build_phases.index { |ph| ph.respond_to?(:name) && ph.name == 'Thin Binary' }
  return false unless thin_idx
  cur = runner.build_phases.index(embed)
  return false if cur && cur < thin_idx
  runner.build_phases.delete(embed)
  thin_idx = runner.build_phases.index { |ph| ph.respond_to?(:name) && ph.name == 'Thin Binary' }
  runner.build_phases.insert(thin_idx, embed)
  true
end

def apply_settings(target)
  target.build_configurations.each do |c|
    bs = c.build_settings
    bs['PRODUCT_NAME']              = '$(TARGET_NAME)'
    bs['PRODUCT_BUNDLE_IDENTIFIER'] = EXT_BUNDLE
    bs['INFOPLIST_FILE']            = "#{EXT}/Info.plist"
    bs['CODE_SIGN_ENTITLEMENTS']    = "#{EXT}/BroadcastExtension.entitlements"
    bs['IPHONEOS_DEPLOYMENT_TARGET'] = DEPLOY
    bs['SWIFT_VERSION']             = '5.0'
    bs['CODE_SIGN_STYLE']           = 'Automatic'
    bs['GENERATE_INFOPLIST_FILE']   = 'NO'
    bs['SKIP_INSTALL']              = 'YES'
    bs['CURRENT_PROJECT_VERSION']   = '$(FLUTTER_BUILD_NUMBER)'
    bs['MARKETING_VERSION']         = '$(FLUTTER_BUILD_NAME)'
    bs['TARGETED_DEVICE_FAMILY']    = '1,2'
  end
end

here = File.dirname(__FILE__)
proj_path = File.expand_path(File.join(here, '..', 'Runner.xcodeproj'))
project = Xcodeproj::Project.open(proj_path)
runner = project.targets.find { |t| t.name == 'Runner' } or abort('Runner target not found')

existing = project.targets.find { |t| t.name == EXT }
if existing
  # Self-heal: earlier runs left the target without PRODUCT_NAME (nameless .appex →
  # "Multiple commands produce") and the embed phase after "Thin Binary" ("Cycle
  # inside Runner"). Fix both without recreating the target.
  apply_settings(existing)
  moved = move_embed_before_thin(runner)
  project.save
  puts "[add_broadcast_extension] Healed '#{EXT}' (settings + embed order moved=#{moved})."
  exit 0
end

ext = project.new_target(:app_extension, EXT, :ios, DEPLOY)

group = project.main_group.find_subpath(EXT, true)
group.set_source_tree('SOURCE_ROOT')
SRC_FILES.each do |f|
  ref = group.new_reference("#{EXT}/#{f}")
  ext.add_file_references([ref])
end

apply_settings(ext)

runner.add_dependency(ext)
embed = runner.copy_files_build_phases.find { |p| p.symbol_dst_subfolder_spec == :plug_ins }
embed ||= runner.new_copy_files_build_phase('Embed App Extensions')
embed.symbol_dst_subfolder_spec = :plug_ins
bf = embed.add_file_reference(ext.product_reference, true)
bf.settings = { 'ATTRIBUTES' => ['RemoveHeadersOnCopy'] }
move_embed_before_thin(runner)

project.save
puts "[add_broadcast_extension] Added '#{EXT}' target + embed phase (before Thin Binary)."
