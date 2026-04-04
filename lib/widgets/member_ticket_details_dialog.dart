import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../services/ticket_service.dart';

/// Mobile-optimized Ticket Details Dialog for Members
class MemberTicketDetailsDialog extends StatefulWidget {
  final Ticket ticket;
  final String mitgliedernummer;

  const MemberTicketDetailsDialog({
    super.key,
    required this.ticket,
    required this.mitgliedernummer,
  });

  @override
  State<MemberTicketDetailsDialog> createState() =>
      _MemberTicketDetailsDialogState();
}

class _MemberTicketDetailsDialogState extends State<MemberTicketDetailsDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _ticketService = TicketService();
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();

  List<TicketComment> _comments = [];
  List<TicketAttachment> _attachments = [];
  TicketTranslation? _ticketTranslation;
  bool _isLoadingComments = true;
  bool _isSubmittingComment = false;
  // Translation toggle state
  bool _showOriginalMessage = false;
  final Set<int> _showOriginalCommentIds = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadComments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadComments() async {
    setState(() => _isLoadingComments = true);
    final result = await _ticketService.getComments(
      mitgliedernummer: widget.mitgliedernummer,
      ticketId: widget.ticket.id,
    );

    if (mounted && result != null) {
      setState(() {
        _comments = result.comments;
        _attachments = result.attachments;
        _ticketTranslation = result.ticketTranslation;
        _isLoadingComments = false;
      });

      // Auto-scroll to bottom după load
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSubmittingComment = true);

    final comment = await _ticketService.addComment(
      mitgliedernummer: widget.mitgliedernummer,
      ticketId: widget.ticket.id,
      comment: text,
      isInternal: false,
    );

    if (mounted) {
      setState(() => _isSubmittingComment = false);

      if (comment != null) {
        setState(() {
          _comments.add(comment);
          _commentController.clear();
        });

        // Auto-scroll to bottom
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.replySent)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.sendError),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _pickAndUploadFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf', 'txt', 'zip'],
    );

    if (result != null && result.files.single.path != null) {
      final filePath = result.files.single.path!;

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(AppLocalizations.of(ctx)?.uploading ?? '...'),
                ],
              ),
            ),
          ),
        ),
      );

      final attachment = await _ticketService.uploadAttachment(
        mitgliedernummer: widget.mitgliedernummer,
        ticketId: widget.ticket.id,
        filePath: filePath,
      );

      if (mounted) {
        Navigator.pop(context);

        if (attachment != null) {
          setState(() => _attachments.add(attachment));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!.fileUploaded(attachment.originalFilename))),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.uploadFailed),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  // Color helpers (IDENTIC cu Windows)
  Color _getStatusColor(String status) {
    switch (status) {
      case 'open':
        return Colors.orange;
      case 'in_progress':
        return Colors.purple;
      case 'waiting_member':
        return Colors.blue;
      case 'waiting_staff':
        return Colors.teal;
      case 'waiting_authority':
        return Colors.indigo;
      case 'done':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final l = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return l.justNow;
    if (diff.inMinutes < 60) return l.minutesAgo(diff.inMinutes);
    if (diff.inHours < 24) return l.hoursAgo(diff.inHours);
    if (diff.inDays < 7) return l.daysAgo(diff.inDays);

    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _getStatusDisplay(String status) {
    final l = AppLocalizations.of(context)!;
    switch (status) {
      case 'open': return l.ticketStatusOpen;
      case 'in_progress': return l.ticketStatusInProgress;
      case 'waiting_member': return l.ticketStatusWaitingMember;
      case 'waiting_staff': return l.ticketStatusWaitingStaff;
      case 'waiting_authority': return l.ticketStatusWaitingAuthority;
      case 'done': return l.ticketStatusDone;
      default: return status;
    }
  }

  String _getPriorityDisplay(String priority) {
    final l = AppLocalizations.of(context)!;
    switch (priority) {
      case 'high': return l.ticketPriorityHigh;
      case 'medium': return l.ticketPriorityMedium;
      case 'low': return l.ticketPriorityLow;
      default: return priority;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ← FOLOSEȘTE Scaffold pentru fullscreen pe mobile
      appBar: AppBar(
        backgroundColor: _getStatusColor(widget.ticket.status).withAlpha(50),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ticket #${widget.ticket.id}',
                style: const TextStyle(fontSize: 16)),
            Text(
              _getStatusDisplay(widget.ticket.status),
              style: TextStyle(
                fontSize: 12,
                color: _getStatusColor(widget.ticket.status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.blue.shade700,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue.shade700,
          tabs: [
            Tab(
                icon: const Icon(Icons.chat_bubble_outline, size: 20),
                text: AppLocalizations.of(context)!.comments),
            Tab(
                icon: const Icon(Icons.folder_outlined, size: 20),
                text: AppLocalizations.of(context)!.documents),
            Tab(icon: const Icon(Icons.info_outline, size: 20), text: AppLocalizations.of(context)!.details),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCommentsTab(),
          _buildDokumenteTab(),
          _buildDetailsTab(),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subject
          Row(
            children: [
              Expanded(
                child: Text(
                  _ticketTranslation?.subject ?? widget.ticket.subject,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (_ticketTranslation?.subjectIsTranslated == true)
                Tooltip(
                  message: _ticketTranslation!.originalSubject ?? '',
                  child: const Icon(Icons.translate, size: 16, color: Colors.blueGrey),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Priority & Category badges
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getPriorityColor(widget.ticket.priority).withAlpha(30),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${AppLocalizations.of(context)!.priorityLabel}${_getPriorityDisplay(widget.ticket.priority)}',
                  style: TextStyle(
                    color: _getPriorityColor(widget.ticket.priority),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              if (widget.ticket.categoryName != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.category,
                          size: 14, color: Colors.blue.shade700),
                      const SizedBox(width: 4),
                      Text(
                        widget.ticket.categoryName!,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Original message
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.yourMessage,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (_ticketTranslation?.messageIsTranslated == true) ...[
                const Spacer(),
                GestureDetector(
                  onTap: () => setState(() => _showOriginalMessage = !_showOriginalMessage),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.translate, size: 14, color: Colors.blueGrey.shade400),
                      const SizedBox(width: 4),
                      Text(
                        _showOriginalMessage ? AppLocalizations.of(context)!.translation : AppLocalizations.of(context)!.original,
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade400),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _showOriginalMessage
                      ? (_ticketTranslation?.originalMessage ?? widget.ticket.message)
                      : (_ticketTranslation?.message ?? widget.ticket.message),
                ),
                if (_ticketTranslation?.messageIsTranslated == true)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _showOriginalMessage ? AppLocalizations.of(context)!.originalText : AppLocalizations.of(context)!.autoTranslated,
                      style: TextStyle(fontSize: 11, color: Colors.blueGrey.shade300, fontStyle: FontStyle.italic),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Info rows
          _buildInfoRow(Icons.calendar_today, AppLocalizations.of(context)!.createdLabel,
              _formatDate(widget.ticket.createdAt)),
          if (widget.ticket.updatedAt != null)
            _buildInfoRow(Icons.update, AppLocalizations.of(context)!.updatedLabel,
                _formatDate(widget.ticket.updatedAt!)),
          if (widget.ticket.adminName != null)
            _buildInfoRow(
                Icons.support_agent, AppLocalizations.of(context)!.handlerLabel, widget.ticket.adminName!),
          if (widget.ticket.closedAt != null)
            _buildInfoRow(Icons.check_circle, AppLocalizations.of(context)!.doneLabel,
                _formatDate(widget.ticket.closedAt!)),
        ],
      ),
    );
  }

  Widget _buildCommentsTab() {
    return Column(
      children: [
        // Comments list
        Expanded(
          child: _isLoadingComments
              ? const Center(child: CircularProgressIndicator())
              : _comments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.chat_bubble_outline,
                              size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.noRepliesYet,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.waitingForSupport,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(
                          12), // ← Padding mai mic pentru mobile
                      itemCount: _comments.length,
                      itemBuilder: (context, index) =>
                          _buildCommentBubble(_comments[index]),
                    ),
        ),

        // Comment input (ADAPTAT pentru mobile keyboard)
        SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    maxLines: null, // ← Auto-expand pe mobile
                    minLines: 1,
                    maxLength: 500,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.writeReply,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      counterText: '', // Hide character counter
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.attach_file),
                        onPressed: _pickAndUploadFile,
                        tooltip: AppLocalizations.of(context)!.attachFile,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FloatingActionButton.small(
                  onPressed: _isSubmittingComment ? null : _submitComment,
                  backgroundColor: Colors.blue,
                  child: _isSubmittingComment
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  IconData _getFileIcon(String filename) {
    final ext = filename.toLowerCase().split('.').last;
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
        return Icons.image;
      case 'txt':
        return Icons.description;
      case 'zip':
        return Icons.folder_zip;
      default:
        return Icons.insert_drive_file;
    }
  }

  Color _getFileIconColor(String filename) {
    final ext = filename.toLowerCase().split('.').last;
    switch (ext) {
      case 'pdf':
        return Colors.red;
      case 'jpg':
      case 'jpeg':
        return Colors.blue;
      case 'txt':
        return Colors.grey;
      case 'zip':
        return Colors.amber.shade700;
      default:
        return Colors.grey.shade600;
    }
  }

  Widget _buildDokumenteTab() {
    return Column(
      children: [
        // Header with count and upload button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.documentsCount(_attachments.length),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _pickAndUploadFile,
                icon: const Icon(Icons.upload_file, size: 18),
                label: Text(AppLocalizations.of(context)!.upload),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
            ],
          ),
        ),
        // Content
        Expanded(
          child: _isLoadingComments
              ? const Center(child: CircularProgressIndicator())
              : _attachments.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.folder_open,
                              size: 64, color: Colors.grey.shade400),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.noDocuments,
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppLocalizations.of(context)!.allowedFormats,
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 13),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: _attachments.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final attachment = _attachments[index];
                        final ext = attachment.originalFilename
                            .split('.')
                            .last
                            .toUpperCase();
                        final dateStr =
                            '${attachment.uploadedAt.day.toString().padLeft(2, '0')}.${attachment.uploadedAt.month.toString().padLeft(2, '0')}.${attachment.uploadedAt.year} ${attachment.uploadedAt.hour.toString().padLeft(2, '0')}:${attachment.uploadedAt.minute.toString().padLeft(2, '0')}';

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: _getFileIconColor(
                                    attachment.originalFilename)
                                .withAlpha(30),
                            child: Icon(
                              _getFileIcon(attachment.originalFilename),
                              color: _getFileIconColor(
                                  attachment.originalFilename),
                            ),
                          ),
                          title: Text(
                            attachment.originalFilename,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            '$ext · ${attachment.filesizeDisplay} · $dateStr',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600),
                          ),
                          trailing: Icon(Icons.download,
                              color: Colors.blue.shade700),
                          onTap: () async {
                            final messenger =
                                ScaffoldMessenger.of(context);
                            final errorText = AppLocalizations.of(context)!.openError;
                            final downloadUrl =
                                _ticketService.getAttachmentDownloadUrl(
                              widget.mitgliedernummer,
                              attachment.id,
                            );
                            final uri = Uri.parse(downloadUrl);
                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              if (mounted) {
                                messenger.showSnackBar(
                                  SnackBar(
                                      content: Text(errorText)),
                                );
                              }
                            }
                          },
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildCommentBubble(TicketComment comment) {
    final isAdmin = [
      'vorsitzer',
      'schatzmeister',
      'kassierer',
      'mitgliedergrunder'
    ].contains(comment.userRole);
    final alignment = isAdmin ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final bubbleColor = isAdmin ? Colors.blue.shade50 : Colors.green.shade50;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Row(
            mainAxisAlignment:
                isAdmin ? MainAxisAlignment.start : MainAxisAlignment.end,
            children: [
              if (!isAdmin) const Spacer(flex: 2),
              CircleAvatar(
                backgroundColor:
                    isAdmin ? Colors.blue.shade100 : Colors.green.shade100,
                radius: 14,
                child: Icon(
                  isAdmin ? Icons.support_agent : Icons.person,
                  size: 16,
                  color: isAdmin ? Colors.blue.shade700 : Colors.green.shade700,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment.userName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(width: 8),
              Text(
                _formatDate(comment.createdAt),
                style: TextStyle(color: Colors.grey.shade500, fontSize: 10),
              ),
              if (isAdmin) const Spacer(flex: 2),
            ],
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: comment.isTranslated
                ? () {
                    setState(() {
                      if (_showOriginalCommentIds.contains(comment.id)) {
                        _showOriginalCommentIds.remove(comment.id);
                      } else {
                        _showOriginalCommentIds.add(comment.id);
                      }
                    });
                  }
                : null,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width *
                    0.75, // ← Max 75% width
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _showOriginalCommentIds.contains(comment.id)
                        ? (comment.originalComment ?? comment.comment)
                        : comment.comment,
                    style: const TextStyle(fontSize: 13),
                  ),
                  if (comment.isTranslated)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.translate, size: 12, color: Colors.blueGrey.shade300),
                          const SizedBox(width: 4),
                          Text(
                            _showOriginalCommentIds.contains(comment.id)
                                ? AppLocalizations.of(context)!.originalTapTranslation
                                : AppLocalizations.of(context)!.translatedTapOriginal,
                            style: TextStyle(fontSize: 10, color: Colors.blueGrey.shade300, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
