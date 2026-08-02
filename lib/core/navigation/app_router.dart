import 'package:go_router/go_router.dart';

import '../../features/editing/presentation/metadata_editor_screen_root.dart';
import '../../features/importing/presentation/import_screen_root.dart';
import '../../features/library/presentation/library_screen_root.dart';
import '../../features/player/presentation/player_screen_root.dart';
import '../../features/settings/presentation/settings_screen_root.dart';

abstract final class AppRoutes {
  static const library = 'library';
  static const import = 'import';
  static const player = 'player';
  static const settings = 'settings';
  static const editBook = 'editBook';
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
                PlayerScreenRoot(bookId: state.pathParameters['bookId']!),
          ),
          GoRoute(
            path: 'settings',
            name: AppRoutes.settings,
            builder: (_, _) => const SettingsScreenRoot(),
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
  );
}

enum ImportSource { files, finderTransfer }
