import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:sizer/sizer.dart';

import '../../widgets/custom_app_bar.dart';
import './widgets/auto_save_indicator_widget.dart';
import './widgets/note_options_bottom_sheet_widget.dart';
import './widgets/rich_text_toolbar_widget.dart';

/// Note Editor Screen - Distraction-free writing environment
/// Provides rich text editing with auto-save functionality
class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  final TextEditingController _titleController = TextEditingController();
  final quill.QuillController _quillController = quill.QuillController.basic();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _editorFocusNode = FocusNode();

  bool _hasUnsavedChanges = false;
  bool _isAutoSaving = false;
  DateTime _lastSaveTime = DateTime.now();
  String _selectedCategory = 'Personal';
  DateTime? _reminderTime;
  double _textSize = 16.0;

  // Auto-save timer
  DateTime _lastChangeTime = DateTime.now();
  bool _autoSaveScheduled = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onContentChanged);
    _quillController.addListener(_onContentChanged);
    _editorFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _quillController.dispose();
    _titleFocusNode.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  /// Handle content changes for auto-save
  void _onContentChanged() {
    setState(() {
      _hasUnsavedChanges = true;
      _lastChangeTime = DateTime.now();
    });

    if (!_autoSaveScheduled) {
      _autoSaveScheduled = true;
      Future.delayed(const Duration(seconds: 3), () {
        if (_hasUnsavedChanges &&
            DateTime.now().difference(_lastChangeTime).inSeconds >= 3) {
          _autoSaveNote();
        }
        _autoSaveScheduled = false;
      });
    }
  }

  /// Handle focus changes for auto-save
  void _onFocusChanged() {
    if (!_editorFocusNode.hasFocus && _hasUnsavedChanges) {
      _autoSaveNote();
    }
  }

  /// Auto-save note with visual feedback
  Future<void> _autoSaveNote() async {
    if (!_hasUnsavedChanges) return;

    setState(() => _isAutoSaving = true);

    // Simulate save operation
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _hasUnsavedChanges = false;
      _isAutoSaving = false;
      _lastSaveTime = DateTime.now();
    });

    HapticFeedback.lightImpact();
  }

  /// Save note and navigate back
  Future<void> _saveAndExit() async {
    if (_hasUnsavedChanges) {
      await _autoSaveNote();
    }

    if (mounted) {
      HapticFeedback.mediumImpact();
      Navigator.pop(context);
    }
  }

  /// Show save confirmation dialog
  Future<bool> _showSaveConfirmation() async {
    if (!_hasUnsavedChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Unsaved Changes',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'Do you want to save your changes before leaving?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Discard'),
          ),
          TextButton(
            onPressed: () async {
              await _autoSaveNote();
              if (mounted) Navigator.pop(context, true);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// Show note options bottom sheet
  void _showNoteOptions() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => NoteOptionsBottomSheetWidget(
        selectedCategory: _selectedCategory,
        reminderTime: _reminderTime,
        textSize: _textSize,
        onCategoryChanged: (category) {
          setState(() {
            _selectedCategory = category;
            _hasUnsavedChanges = true;
          });
        },
        onReminderChanged: (time) {
          setState(() {
            _reminderTime = time;
            _hasUnsavedChanges = true;
          });
        },
        onTextSizeChanged: (size) {
          setState(() => _textSize = size);
        },
      ),
    );
  }

  /// Get character count
  int _getCharacterCount() {
    final plainText = _quillController.document.toPlainText();
    return plainText.length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _showSaveConfirmation();
        if (shouldPop && mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar.noteEditor(
          context,
          onSave: _saveAndExit,
          onShare: () {
            HapticFeedback.lightImpact();
            // Share functionality would be implemented here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Share functionality coming soon',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Auto-save indicator
              AutoSaveIndicatorWidget(
                isAutoSaving: _isAutoSaving,
                lastSaveTime: _lastSaveTime,
                hasUnsavedChanges: _hasUnsavedChanges,
              ),

              // Title field
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  border: Border(
                    bottom: BorderSide(color: theme.dividerColor, width: 0.5),
                  ),
                ),
                child: TextField(
                  controller: _titleController,
                  focusNode: _titleFocusNode,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Note Title',
                    hintStyle: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                      fontWeight: FontWeight.w600,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  maxLines: 2,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),

              // Editor area
              Expanded(
                child: Container(
                  color: theme.colorScheme.surface,
                  child: Column(
                    children: [
                      // Quill editor
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.h,
                          ),
                          child: quill.QuillEditor.basic(
                            controller: _quillController,
                            focusNode: _editorFocusNode,
                          ),
                        ),
                      ),

                      // Character count
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${_getCharacterCount()} characters',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.6),
                          ),
                        ),
                      ),

                      // Rich text toolbar
                      RichTextToolbarWidget(
                        controller: _quillController,
                        onOptionsPressed: _showNoteOptions,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
