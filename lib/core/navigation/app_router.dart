import 'package:go_router/go_router.dart';

import '../../features/editing/presentation/metadata_editor_screen_root.dart';
import '../../features/importing/presentation/import_screen_root.dart';
import '../../features/insights/presentation/listening_insights_screen_root.dart';
import '../../features/library/presentation/library_screen_root.dart';
import '../../features/player/presentation/player_screen_root.dart';
import '../../features/settings/presentation/settings_screen_root.dart';
import '../../features/storage/presentation/storage_assistant_screen_root.dart';
import '../../features/player/presentation/now_playing_shell.dart';

abstract final class AppRoutes {
  static const library = 'library';
  static const import = 'import';
  static const player = 'player';
  static const settings = 'settings';
  static const editBook = 'editBook';
  static const insights = 'insights';
  static const storage = 'storage';
}

GoRouter createAppRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (_, state, child) => NowPlayingShell(
          showMiniPlayer: shouldShowMiniPlayer(state.uri),
          child: child,
        ),
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
                  fromFinderTransfer:
                      state.extra == ImportSource.finderTransfer,
                ),
              ),
              GoRoute(
                path: 'player/:bookId',
                name: AppRoutes.player,
                builder: (_, state) =>
                    PlayerScreenRoot(bookId: state.pathParameters['bookId']!),
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
                path: 'storage',
                name: AppRoutes.storage,
                builder: (_, _) => const StorageAssistantScreenRoot(),
              ),
              GoRoute(
                path: 'book/:bookId/edit',
                name: AppRoutes.editBook,
                builder: (_, state) => MetadataEditorScreenRoot(
                  bookId: state.pathParameters['bookId']!,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

bool shouldShowMiniPlayer(Uri location) =>
    !location.path.startsWith('/player/');

enum ImportSource { files, finderTransfer }
