import 'package:flutter/material.dart';
import 'package:note_uss/presentation/note_list_screen/notes_list_screen.dart';
import '../presentation/note_editor_screen/note_editor_screen.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/settings_screen/settings_screen.dart';
import '../presentation/note_detail_screen/note_detail_screen.dart';
import '../presentation/search_screen/search_screen.dart';
import '../presentation/notes_list_screen/notes_list_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String noteEditor = '/note-editor-screen';
  static const String splash = '/splash-screen';
  static const String settings = '/settings-screen';
  static const String noteDetail = '/note-detail-screen';
  static const String search = '/search-screen';
  static const String notesList = '/notes-list-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    noteEditor: (context) => const NoteEditorScreen(),
    splash: (context) => const SplashScreen(),
    settings: (context) => const SettingsScreen(),
    noteDetail: (context) => const NoteDetailScreen(),
    search: (context) => const SearchScreen(),
    notesList: (context) => const NotesListScreen(),
    // TODO: Add your other routes here
  };
}
