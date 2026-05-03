import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/note_content_widget.dart';
import './widgets/note_header_widget.dart';
import './widgets/note_timestamps_widget.dart';

/// Note Detail Screen - Provides focused reading experience with quick access to editing and sharing
class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({super.key});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  // Mock note data
  final Map<String, dynamic> _noteData = {
    "id": 1,
    "title": "Flutter Development Best Practices",
    "content":
        """Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.

Key Principles:
• Widget composition over inheritance
• Immutable widgets for better performance
• State management with Provider or Riverpod
• Responsive design using MediaQuery and LayoutBuilder

Performance Tips:
1. Use const constructors wherever possible
2. Avoid rebuilding entire widget trees
3. Implement proper list virtualization
4. Optimize image loading and caching

Remember: Flutter's hot reload feature makes development incredibly fast and productive. Always test on real devices for accurate performance metrics.""",
    "categories": ["Development", "Flutter", "Mobile"],
    "createdAt": DateTime.now().subtract(const Duration(days: 5)),
    "modifiedAt": DateTime.now().subtract(const Duration(hours: 3)),
  };

  bool _isMarkdownView = false;
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    super.dispose();
  }

  void _saveScrollPosition() {
    _scrollPosition = _scrollController.position.pixels;
  }

  void _restoreScrollPosition() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollPosition);
    }
  }

  void _handleEdit() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(
      context,
      '/note-editor-screen',
      arguments: _noteData,
    ).then((_) => _restoreScrollPosition());
  }

  void _handleDelete() {
    HapticFeedback.lightImpact();
    showDialog(context: context, builder: (context) => _buildDeleteDialog());
  }

  void _handleDuplicate() {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Note duplicated successfully'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  Future<void> _handleShare() async {
    HapticFeedback.lightImpact();

    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildShareBottomSheet(),
    );

    if (result != null && mounted) {
      switch (result) {
        case 'text':
          await _shareAsText();
          break;
        case 'markdown':
          await _shareAsMarkdown();
          break;
        case 'pdf':
          await _shareAsPdf();
          break;
      }
    }
  }

  Future<void> _shareAsText() async {
    final text = '${_noteData["title"]}\n\n${_noteData["content"]}';
    await Share.share(text, subject: _noteData["title"]);
  }

  Future<void> _shareAsMarkdown() async {
    final markdown = '# ${_noteData["title"]}\n\n${_noteData["content"]}';
    await Share.share(markdown, subject: _noteData["title"]);
  }

  Future<void> _shareAsPdf() async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  _noteData["title"],
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  _noteData["content"],
                  style: const pw.TextStyle(fontSize: 12),
                ),
              ],
            );
          },
        ),
      );

      await Printing.sharePdf(
        bytes: await pdf.save(),
        filename: '${_noteData["title"]}.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to generate PDF'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.all(4.w),
          ),
        );
      }
    }
  }

  void _handleCategoryTap() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/search-screen');
  }

  void _showActionMenu() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildActionMenu(),
    );
  }

  Widget _buildActionMenu() {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildActionMenuItem(
              icon: 'edit',
              label: 'Edit',
              onTap: () {
                Navigator.pop(context);
                _handleEdit();
              },
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            _buildActionMenuItem(
              icon: 'share',
              label: 'Share',
              onTap: () {
                Navigator.pop(context);
                _handleShare();
              },
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            _buildActionMenuItem(
              icon: 'content_copy',
              label: 'Duplicate',
              onTap: () {
                Navigator.pop(context);
                _handleDuplicate();
              },
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            _buildActionMenuItem(
              icon: 'delete',
              label: 'Delete',
              onTap: () {
                Navigator.pop(context);
                _handleDelete();
              },
              isDestructive: true,
            ),
            SizedBox(height: 2.h),
            _buildActionMenuItem(
              icon: 'close',
              label: 'Cancel',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionMenuItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 24,
              color: isDestructive
                  ? theme.colorScheme.error
                  : theme.colorScheme.onSurface,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: isDestructive
                    ? theme.colorScheme.error
                    : theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareBottomSheet() {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'Share as',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
            _buildShareOption(
              icon: 'text_fields',
              label: 'Plain Text',
              onTap: () => Navigator.pop(context, 'text'),
            ),
            _buildShareOption(
              icon: 'code',
              label: 'Markdown',
              onTap: () => Navigator.pop(context, 'markdown'),
            ),
            _buildShareOption(
              icon: 'picture_as_pdf',
              label: 'PDF',
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
            SizedBox(height: 2.h),
            _buildShareOption(
              icon: 'close',
              label: 'Cancel',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: icon,
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteDialog() {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Delete Note',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this note? This action cannot be undone.',
        style: theme.textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Note deleted'),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: EdgeInsets.all(4.w),
              ),
            );
          },
          child: Text(
            'Delete',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'Note Details',
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            size: 24,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'edit',
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: _handleEdit,
            tooltip: 'Edit',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: _showActionMenu,
            tooltip: 'More options',
          ),
        ],
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          } else if (details.primaryVelocity != null &&
              details.primaryVelocity! < 0) {
            HapticFeedback.lightImpact();
            _handleEdit();
          }
        },
        child: SafeArea(
          child: OrientationBuilder(
            builder: (context, orientation) {
              return SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: orientation == Orientation.portrait ? 4.w : 8.w,
                  vertical: 2.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Note header with title and categories
                    NoteHeaderWidget(
                      title: _noteData["title"],
                      categories: (_noteData["categories"] as List)
                          .cast<String>(),
                      onCategoryTap: _handleCategoryTap,
                    ),
                    SizedBox(height: 3.h),

                    // View mode toggle
                    Row(
                      children: [
                        Text(
                          'View Mode:',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(
                              value: false,
                              label: Text('Plain'),
                              icon: Icon(Icons.text_fields),
                            ),
                            ButtonSegment(
                              value: true,
                              label: Text('Markdown'),
                              icon: Icon(Icons.code),
                            ),
                          ],
                          selected: {_isMarkdownView},
                          onSelectionChanged: (Set<bool> newSelection) {
                            HapticFeedback.selectionClick();
                            setState(() {
                              _isMarkdownView = newSelection.first;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),

                    // Note content
                    Container(
                      constraints: BoxConstraints(minHeight: 30.h),
                      child: _isMarkdownView
                          ? Markdown(
                              data: _noteData["content"],
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              styleSheet: MarkdownStyleSheet(
                                p: theme.textTheme.bodyLarge,
                                h1: theme.textTheme.headlineMedium,
                                h2: theme.textTheme.headlineSmall,
                                h3: theme.textTheme.titleLarge,
                                listBullet: theme.textTheme.bodyLarge,
                              ),
                            )
                          : NoteContentWidget(content: _noteData["content"]),
                    ),
                    SizedBox(height: 3.h),

                    // Timestamps
                    NoteTimestampsWidget(
                      createdAt: _noteData["createdAt"],
                      modifiedAt: _noteData["modifiedAt"],
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
