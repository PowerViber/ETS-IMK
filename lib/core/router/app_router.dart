import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/dashboard/dashboard.dart';
import '../../features/alquran/alquran.dart';
import '../../features/alquran/juz_document.dart';
import '../../features/alquran/juz_reader.dart';
import '../../features/home/home.dart';
import '../../features/latihan/latihan.dart';
import '../../features/latihan/tebak_surah_screen.dart';
import '../../features/latihan/sambung_ayat_screen.dart';
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
      GoRoute(
        path: '/alquran/juz/:number',
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
      GoRoute(
        path: '/latihan/tebak-surah',
        builder: (context, state) {
          final juz = int.tryParse(state.uri.queryParameters['juz'] ?? '');
          final startJuz = int.tryParse(state.uri.queryParameters['startJuz'] ?? '');
          final endJuz = int.tryParse(state.uri.queryParameters['endJuz'] ?? '');
          final surah = state.uri.queryParameters['surah'];
          final count = int.tryParse(state.uri.queryParameters['count'] ?? '') ?? 5;
          return TebakSurahScreen(
            juzFilter: juz,
            startJuzFilter: startJuz,
            endJuzFilter: endJuz,
            surahFilter: surah,
            questionCount: count,
          );
        },
      ),
      GoRoute(
        path: '/latihan/sambung-ayat',
        builder: (context, state) {
          final juz = int.tryParse(state.uri.queryParameters['juz'] ?? '');
          final startJuz = int.tryParse(state.uri.queryParameters['startJuz'] ?? '');
          final endJuz = int.tryParse(state.uri.queryParameters['endJuz'] ?? '');
          final surah = state.uri.queryParameters['surah'];
          final count = int.tryParse(state.uri.queryParameters['count'] ?? '') ?? 5;
          return SambungAyatScreen(
            juzFilter: juz,
            startJuzFilter: startJuz,
            endJuzFilter: endJuz,
            surahFilter: surah,
            questionCount: count,
          );
        },
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
