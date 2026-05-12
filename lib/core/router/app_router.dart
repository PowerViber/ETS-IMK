import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/dashboard.dart';
import '../../features/alquran/alquran.dart';
import '../../features/alquran/juz_document.dart';
import '../../features/alquran/juz_reader.dart';
import '../../features/home/home.dart';
import '../../features/latihan/latihan.dart';
import '../../features/target/target.dart';
import '../../shared/widgets/main_scaffold.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/alquran',
                builder: (context, state) => const AlQuranScreen(),
                routes: [
                  GoRoute(
                    path: 'juz/:number',
                    builder: (context, state) {
                      final juzNumber =
                          int.tryParse(state.pathParameters['number'] ?? '');
                      final document =
                          juzNumber == null ? null : findJuzDocument(juzNumber);

                      if (document == null) {
                        return const AlQuranScreen();
                      }

                      return JuzReaderScreen(document: document);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/latihan',
                builder: (context, state) => const LatihanScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/target',
                builder: (context, state) => const TargetScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
