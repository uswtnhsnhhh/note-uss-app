import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/empty_search_state_widget.dart';
import './widgets/no_results_state_widget.dart';
import './widgets/recent_searches_widget.dart';
import './widgets/search_bar_widget.dart';
import './widgets/search_filters_widget.dart';
import './widgets/search_result_item_widget.dart';
import 'widgets/empty_search_state_widget.dart';
import 'widgets/no_results_state_widget.dart';
import 'widgets/recent_searches_widget.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/search_filters_widget.dart';
import 'widgets/search_result_item_widget.dart';

/// Search Screen for intelligent note discovery
/// Implements real-time search with filters, recent searches, and highlighted results
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> _recentSearches = [
    'meeting notes',
    'project ideas',
    'shopping list',
  ];

  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  String? _selectedDateRange;
  String? _selectedCategory;
  String? _selectedLength;

  final List<Map<String, dynamic>> _allNotes = [
    {
      'id': 1,
      'title': 'Team Meeting Notes',
      'content':
          'Discussed Q4 project timeline and resource allocation. Key decisions made regarding the new feature rollout. Action items assigned to team members.',
      'category': 'Work',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
    },
    {
      'id': 2,
      'title': 'Project Ideas for Mobile App',
      'content':
          'Brainstorming session for new mobile app features. Consider implementing dark mode, offline sync, and voice notes. Research competitor apps.',
      'category': 'Ideas',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
    },
    {
      'id': 3,
      'title': 'Shopping List',
      'content':
          'Groceries: milk, eggs, bread, vegetables. Hardware store: light bulbs, batteries. Pharmacy: vitamins, first aid supplies.',
      'category': 'Personal',
      'timestamp': DateTime.now().subtract(const Duration(hours: 5)),
    },
    {
      'id': 4,
      'title': 'Daily Journal Entry',
      'content':
          'Productive day at work. Completed three major tasks and helped a colleague with debugging. Evening walk in the park was refreshing.',
      'category': 'Personal',
      'timestamp': DateTime.now().subtract(const Duration(days: 2)),
    },
    {
      'id': 5,
      'title': 'Work Tasks for This Week',
      'content':
          'Monday: Code review. Tuesday: Client meeting. Wednesday: Sprint planning. Thursday: Feature development. Friday: Documentation.',
      'category': 'To-Do',
      'timestamp': DateTime.now().subtract(const Duration(hours: 12)),
    },
    {
      'id': 6,
      'title': 'Important Client Feedback',
      'content':
          'Client requested additional features: real-time notifications, data export functionality, and improved search. Priority: High. Deadline: End of month.',
      'category': 'Important',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 7,
      'title': 'Book Reading Notes',
      'content':
          'Chapter 5 insights: The importance of consistent habits. Key takeaway: Small daily improvements lead to remarkable results over time.',
      'category': 'Personal',
      'timestamp': DateTime.now().subtract(const Duration(days: 4)),
    },
    {
      'id': 8,
      'title': 'Meeting Action Items',
      'content':
          'Follow up with marketing team. Update project documentation. Schedule code review session. Prepare presentation for stakeholders.',
      'category': 'Work',
      'timestamp': DateTime.now().subtract(const Duration(hours: 8)),
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = true;
    });

    if (query.length < 2) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    List<Map<String, dynamic>> results = _allNotes.where((note) {
      final titleMatch = (note['title'] as String).toLowerCase().contains(
        lowerQuery,
      );
      final contentMatch = (note['content'] as String).toLowerCase().contains(
        lowerQuery,
      );
      return titleMatch || contentMatch;
    }).toList();

    results = _applyFilters(results);

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });

    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      setState(() {
        _recentSearches.insert(0, query);
        if (_recentSearches.length > 5) {
          _recentSearches = _recentSearches.sublist(0, 5);
        }
      });
    }
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> results) {
    if (_selectedDateRange != null) {
      final now = DateTime.now();
      results = results.where((note) {
        final timestamp = note['timestamp'] as DateTime;
        final difference = now.difference(timestamp);

        switch (_selectedDateRange) {
          case 'Today':
            return difference.inDays == 0;
          case 'Last 7 days':
            return difference.inDays <= 7;
          case 'Last 30 days':
            return difference.inDays <= 30;
          case 'Last 90 days':
            return difference.inDays <= 90;
          default:
            return true;
        }
      }).toList();
    }

    if (_selectedCategory != null) {
      results = results.where((note) {
        return note['category'] == _selectedCategory;
      }).toList();
    }

    if (_selectedLength != null) {
      results = results.where((note) {
        final contentLength = (note['content'] as String).length;
        switch (_selectedLength) {
          case 'Short':
            return contentLength < 100;
          case 'Medium':
            return contentLength >= 100 && contentLength < 300;
          case 'Long':
            return contentLength >= 300;
          default:
            return true;
        }
      }).toList();
    }

    return results;
  }

  void _showFilters() {
    HapticFeedback.lightImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SearchFiltersWidget(
        selectedDateRange: _selectedDateRange,
        selectedCategory: _selectedCategory,
        selectedLength: _selectedLength,
        onDateRangeChanged: (value) {
          setState(() => _selectedDateRange = value);
          _performSearch(_searchController.text);
        },
        onCategoryChanged: (value) {
          setState(() => _selectedCategory = value);
          _performSearch(_searchController.text);
        },
        onLengthChanged: (value) {
          setState(() => _selectedLength = value);
          _performSearch(_searchController.text);
        },
        onClearFilters: () {
          setState(() {
            _selectedDateRange = null;
            _selectedCategory = null;
            _selectedLength = null;
          });
          _performSearch(_searchController.text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppTheme.backgroundDark
          : AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            SearchBarWidget(
              searchController: _searchController,
              onSearchChanged: _performSearch,
              onCancel: () {
                HapticFeedback.lightImpact();
                Navigator.pop(context);
              },
              focusNode: _searchFocusNode,
            ),
            if (_searchController.text.isEmpty)
              RecentSearchesWidget(
                recentSearches: _recentSearches,
                onSearchTap: (search) {
                  _searchController.text = search;
                  _performSearch(search);
                },
                onDeleteSearch: (search) {
                  setState(() {
                    _recentSearches.remove(search);
                  });
                },
                onClearAll: () {
                  setState(() {
                    _recentSearches.clear();
                  });
                },
              ),
            if (_selectedDateRange != null ||
                _selectedCategory != null ||
                _selectedLength != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            if (_selectedDateRange != null)
                              _buildFilterChip(_selectedDateRange!, () {
                                setState(() => _selectedDateRange = null);
                                _performSearch(_searchController.text);
                              }, isDark),
                            if (_selectedCategory != null)
                              _buildFilterChip(_selectedCategory!, () {
                                setState(() => _selectedCategory = null);
                                _performSearch(_searchController.text);
                              }, isDark),
                            if (_selectedLength != null)
                              _buildFilterChip(_selectedLength!, () {
                                setState(() => _selectedLength = null);
                                _performSearch(_searchController.text);
                              }, isDark),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: CustomIconWidget(
                        iconName: 'filter_list',
                        color: isDark
                            ? AppTheme.accentDark
                            : AppTheme.accentLight,
                        size: 20,
                      ),
                      onPressed: _showFilters,
                    ),
                  ],
                ),
              )
            else if (_searchController.text.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_searchResults.length} results',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppTheme.secondaryDark
                            : AppTheme.secondaryLight,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _showFilters,
                      icon: CustomIconWidget(
                        iconName: 'filter_list',
                        color: isDark
                            ? AppTheme.accentDark
                            : AppTheme.accentLight,
                        size: 18,
                      ),
                      label: Text(
                        'Filters',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: isDark
                              ? AppTheme.accentDark
                              : AppTheme.accentLight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(child: _buildSearchContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onDelete, bool isDark) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(right: 2.w),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppTheme.accentDark.withValues(alpha: 0.2)
            : AppTheme.accentLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 1.w),
          InkWell(
            onTap: onDelete,
            child: CustomIconWidget(
              iconName: 'close',
              color: isDark ? AppTheme.accentDark : AppTheme.accentLight,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent() {
    if (_searchController.text.isEmpty) {
      return EmptySearchStateWidget(
        onSuggestionTap: (suggestion) {
          _searchController.text = suggestion;
          _performSearch(suggestion);
        },
      );
    }

    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty) {
      return NoResultsStateWidget(
        searchQuery: _searchController.text,
        onCreateNote: () {
          Navigator.pushNamed(
            context,
            '/note-editor-screen',
            arguments: {'title': _searchController.text},
          );
        },
      );
    }

    return ListView.builder(
      padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final note = _searchResults[index];
        return SearchResultItemWidget(
          note: note,
          searchQuery: _searchController.text,
          onTap: () {
            Navigator.pushNamed(
              context,
              '/note-detail-screen',
              arguments: note,
            );
          },
          onDelete: () {
            HapticFeedback.mediumImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Note "${note['title']}" deleted'),
                action: SnackBarAction(label: 'Undo', onPressed: () {}),
              ),
            );
            setState(() {
              _searchResults.removeAt(index);
            });
          },
          onShare: () {
            HapticFeedback.lightImpact();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Sharing "${note['title']}"')),
            );
          },
        );
      },
    );
  }
}