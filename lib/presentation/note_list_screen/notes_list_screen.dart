import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/note_card_widget.dart';
import './widgets/note_grid_item_widget.dart';
import './widgets/view_toggle_widget.dart';

/// Notes List Screen - Primary hub for browsing and managing notes
/// Features: List/Grid view toggle, swipe actions, pull-to-refresh, search
class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  bool _isGridView = false;
  bool _isRefreshing = false;
  final ScrollController _scrollController = ScrollController();

  // Mock notes data
  final List<Map<String, dynamic>> _notes = [
    {
      'id': 1,
      'title': 'Meeting Notes - Q1 Planning',
      'content':
          'Discussed quarterly goals, budget allocation, and team expansion plans. Key action items: finalize hiring timeline, review marketing strategy, and schedule follow-up meeting.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'category': 'Work',
    },
    {
      'id': 2,
      'title': 'Grocery Shopping List',
      'content':
          'Milk, eggs, bread, chicken breast, vegetables (broccoli, carrots, spinach), fruits (apples, bananas), pasta, olive oil, coffee beans.',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
      'category': 'Personal',
    },
    {
      'id': 3,
      'title': 'Book Ideas - Fiction Novel',
      'content':
          'Protagonist: A detective with a mysterious past. Setting: Futuristic city with noir atmosphere. Plot twist: The villain is actually trying to save the city.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'category': 'Creative',
    },
    {
      'id': 4,
      'title': 'Workout Routine',
      'content':
          'Monday: Chest and triceps. Tuesday: Back and biceps. Wednesday: Legs. Thursday: Shoulders. Friday: Full body. Weekend: Rest or light cardio.',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
      'category': 'Health',
    },
    {
      'id': 5,
      'title': 'Travel Plans - Summer Vacation',
      'content':
          'Destinations to consider: Japan (Tokyo, Kyoto), Italy (Rome, Florence), or Iceland. Budget: \$3000-\$4000. Duration: 10-14 days. Best time: June-August.',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'category': 'Travel',
    },
    {
      'id': 6,
      'title': 'Recipe - Homemade Pizza',
      'content':
          'Ingredients: Pizza dough, tomato sauce, mozzarella cheese, basil, olive oil. Instructions: Preheat oven to 475°F, roll dough, add toppings, bake for 12-15 minutes.',
      'timestamp': DateTime.now().subtract(const Duration(days: 4)),
      'category': 'Cooking',
    },
    {
      'id': 7,
      'title': 'Project Deadline Tracker',
      'content':
          'Website redesign: Due March 15. Mobile app launch: Due April 1. Marketing campaign: Due April 15. Client presentation: Due May 1.',
      'timestamp': DateTime.now().subtract(const Duration(days: 5)),
      'category': 'Work',
    },
    {
      'id': 8,
      'title': 'Gift Ideas for Birthday',
      'content':
          'Mom: Spa gift certificate, personalized jewelry. Dad: Golf accessories, tech gadget. Sister: Books, art supplies. Best friend: Concert tickets, subscription box.',
      'timestamp': DateTime.now().subtract(const Duration(days: 6)),
      'category': 'Personal',
    },
  ];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isRefreshing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Notes refreshed'),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  void _navigateToNoteDetail(Map<String, dynamic> note) {
    Navigator.pushNamed(context, '/note-detail-screen', arguments: note);
  }

  void _navigateToNoteEditor({Map<String, dynamic>? note}) {
    Navigator.pushNamed(context, '/note-editor-screen', arguments: note);
  }

  void _shareNote(Map<String, dynamic> note) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing: ${note['title']}'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _deleteNote(Map<String, dynamic> note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: Text('Are you sure you want to delete "${note['title']}"?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _notes.removeWhere((n) => n['id'] == note['id']);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Note deleted'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar.notesList(context),
      body: _notes.isEmpty
          ? EmptyStateWidget(onCreateNote: () => _navigateToNoteEditor())
          : Column(
              children: [
                ViewToggleWidget(
                  isGridView: _isGridView,
                  onToggle: (value) {
                    setState(() => _isGridView = value);
                  },
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    color: theme.colorScheme.secondary,
                    child: _isGridView ? _buildGridView() : _buildListView(),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _navigateToNoteEditor();
        },
        icon: CustomIconWidget(
          iconName: 'add',
          size: 24,
          color: theme.colorScheme.onSecondary,
        ),
        label: Text(
          'New Note',
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 4.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: CustomBottomBar.withNavigation(
        context,
        currentIndex: 0,
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 1.h, bottom: 10.h),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return NoteCardWidget(
          note: note,
          onTap: () => _navigateToNoteDetail(note),
          onEdit: () => _navigateToNoteEditor(note: note),
          onShare: () => _shareNote(note),
          onDelete: () => _deleteNote(note),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w,
        vertical: 1.h,
      ).copyWith(bottom: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 3.w,
        mainAxisSpacing: 2.h,
        childAspectRatio: 0.75,
      ),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return NoteGridItemWidget(
          note: note,
          onTap: () => _navigateToNoteDetail(note),
        );
      },
    );
  }
}
