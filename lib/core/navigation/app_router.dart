import 'package:go_router/go_router.dart';

import '../../features/editing/metadata_editor_screen_root.dart';
import '../../features/importing/import_screen_root.dart';
import '../../features/insights/listening_insights_screen_root.dart';
import '../../features/library/library_screen_root.dart';
import '../../features/notes/note_gallery_screen_root.dart';
import '../../features/player/player_screen_root.dart';
import '../../features/settings/settings_screen_root.dart';
import '../../features/storage/storage_assistant_screen_root.dart';
import 'import_source.dart';

abstract final class AppRoutes {
  static const library = 'library';
  static const import = 'import';
  static const player = 'player';
  static const settings = 'settings';
  static const editBook = 'editBook';
  static const insights = 'insights';
  static const storage = 'storage';
  static const notes = 'notes';
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: AppRoutes.library,
        builder: (_, _) => const LibraryScreenRoot(),
        routes: [
          GoRoute(
            path: 'import',
            name: AppRoutes.import,
            builder: (_, state) => ImportScreenRoot(
              fromFinderTransfer: state.extra == ImportSource.finderTransfer,
            ),
          ),
          GoRoute(
            path: 'player/:bookId',
            name: AppRoutes.player,
            builder: (_, state) =>
                PlayerScreenRoot(bookId: _readPathParameter(state, 'bookId')),
          ),
          GoRoute(
            path: 'settings',
            name: AppRoutes.settings,
            builder: (_, _) => const SettingsScreenRoot(),
          ),
          GoRoute(
            path: 'insights',
            name: AppRoutes.insights,
            builder: (_, _) => const ListeningInsightsScreenRoot(),
          ),
          GoRoute(
            path: 'notes',
            name: AppRoutes.notes,
            builder: (_, _) => const NoteGalleryScreenRoot(),
          ),
          GoRoute(
            path: 'storage',
            name: AppRoutes.storage,
            builder: (_, _) => const StorageAssistantScreenRoot(),
          ),
          GoRoute(
            path: 'book/:bookId/edit',
            name: AppRoutes.editBook,
            builder: (_, state) => MetadataEditorScreenRoot(
              bookId: _readPathParameter(state, 'bookId'),
            ),
          ),
        ],
      ),
    ],
  );
}

String _readPathParameter(GoRouterState state, String name) {
  final value = state.pathParameters[name];
  if (value == null || value.isEmpty) {
    throw StateError('Missing required route parameter: $name');
  }
  return value;
}
