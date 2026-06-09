import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../target/target_provider.dart';
import '../latihan/latihan_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetProvider);
    final streak = ref.watch(targetProvider.notifier).calculateCurrentStreak();
    
    final totalTargets = targets.length;
    final completedTargetsCount = targets.where((t) => t.isCompleted).length;
    final completionRate = totalTargets > 0 ? (completedTargetsCount * 100 ~/ totalTargets) : 0;
    
    final history = ref.watch(latihanHistoryProvider);
    final totalSessions = history.length;
    final avgAccuracy = ref.watch(latihanHistoryProvider.notifier).getAverageAccuracy();

    return Scaffold(
      backgroundColor: context.appBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const _HomeTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 116),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assalamu'alaikum,",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: context.appTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Satoru Gojo',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: context.appTextPrimary,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: context.appSurface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: context.appBorder),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Pencarian belum tersedia',
                                  style: TextStyle(
                                    color: context.appTextSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.search_off,
                                  color: context.appTextSecondary, size: 18),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF166D56),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x240B5A45),
                                blurRadius: 18,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              _StreakBadge(streak: streak),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      streak == 0
                                          ? 'Bangun streak pertamamu'
                                          : 'Lanjutkan streak hebatmu!',
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                        height: 1.15,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      streak == 0
                                          ? 'Mulai satu target kecil hari ini.'
                                          : 'Kamu telah konsisten selama $streak hari berturut-turut!',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFDCEEE8),
                                        height: 1.25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const _SectionHeader(
                          title: 'Target Hari Ini',
                          subtitle:
                              'Rencana kecil untuk menjaga ritme belajar.',
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () => context.go('/target'),
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            decoration: BoxDecoration(
                              color: const Color(0xFF63B295),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x2463B295),
                                  blurRadius: 14,
                                  offset: Offset(0, 7),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  'Mulai Target Baru',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const _SectionHeader(
                          title: 'Progress',
                          subtitle: 'Ringkasan awal aktivitas belajarmu.',
                        ),
                        const SizedBox(height: 12),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.55,
                          children: [
                            _ProgressCard(
                              icon: Icons.auto_awesome_motion,
                              title: 'Penamatan',
                              value: '$completionRate%',
                            ),
                            _ProgressCard(
                              icon: Icons.check_circle_outline,
                              title: 'Target Selesai',
                              value: '$completedTargetsCount',
                            ),
                            _ProgressCard(
                              icon: Icons.insights_outlined,
                              title: 'Akurasi Kuis',
                              value: '${avgAccuracy.toStringAsFixed(0)}%',
                            ),
                            _ProgressCard(
                              icon: Icons.quiz_rounded,
                              title: 'Latihan Sesi',
                              value: '$totalSessions Sesi',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Positioned(
              left: 20,
              right: 20,
              bottom: 18,
              child: _HomeFloatingDock(),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTopBar extends StatelessWidget {
  const _HomeTopBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFF66B89F),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.go('/home'),
            child: const Text(
              "IQRA'",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.go('/dashboard'),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(
              Icons.account_circle,
              color: Color(0xFF2F594E),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeFloatingDock extends StatefulWidget {
  const _HomeFloatingDock();

  @override
  State<_HomeFloatingDock> createState() => _HomeFloatingDockState();
}

class _HomeFloatingDockState extends State<_HomeFloatingDock> {
  bool _focused = false;
  String? _activeTooltip;

  void _setFocus(String label, bool value) {
    setState(() {
      _focused = value;
      _activeTooltip = value ? label : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        AnimatedOpacity(
          opacity: _focused ? 1 : 0.78,
          duration: const Duration(milliseconds: 180),
          child: Container(
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: _focused
                  ? context.appDockSurfaceFocused
                  : context.appDockSurface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: _focused
                    ? context.appDockBorderFocused
                    : context.appDockBorder,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _HomeDockIconButton(
                  tooltip: 'Home',
                  icon: Icons.home_rounded,
                  selected: true,
                  onPressed: () => context.go('/home'),
                  onLongPressStart: () => _setFocus('Home', true),
                  onLongPressEnd: () => _setFocus('Home', false),
                ),
                _HomeDockIconButton(
                  tooltip: 'Al-Quran',
                  icon: Icons.menu_book_rounded,
                  selected: false,
                  onPressed: () => context.go('/alquran'),
                  onLongPressStart: () => _setFocus('Al-Quran', true),
                  onLongPressEnd: () => _setFocus('Al-Quran', false),
                ),
                _HomeDockIconButton(
                  tooltip: 'Latihan',
                  icon: Icons.quiz_rounded,
                  selected: false,
                  onPressed: () => context.go('/latihan'),
                  onLongPressStart: () => _setFocus('Latihan', true),
                  onLongPressEnd: () => _setFocus('Latihan', false),
                ),
                _HomeDockIconButton(
                  tooltip: 'Target',
                  icon: Icons.flag_rounded,
                  selected: false,
                  onPressed: () => context.go('/target'),
                  onLongPressStart: () => _setFocus('Target', true),
                  onLongPressEnd: () => _setFocus('Target', false),
                ),
              ],
            ),
          ),
        ),
        if (_activeTooltip != null)
          Positioned(
            bottom: 82,
            child: AnimatedOpacity(
              opacity: _focused ? 1 : 0,
              duration: const Duration(milliseconds: 160),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                  color: const Color(0xF7166D56),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _activeTooltip!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _HomeDockIconButton extends StatelessWidget {
  const _HomeDockIconButton({
    required this.tooltip,
    required this.icon,
    required this.selected,
    required this.onPressed,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  final String tooltip;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;
  final VoidCallback onLongPressStart;
  final VoidCallback onLongPressEnd;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: tooltip,
      button: true,
      child: GestureDetector(
        onTap: onPressed,
        onLongPressStart: (_) => onLongPressStart(),
        onLongPressEnd: (_) => onLongPressEnd(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF166D56) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: selected ? Colors.white : context.appNavIcon,
            size: 23,
          ),
        ),
      ),
    );
  }
}

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.streak});

  final int streak;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0x47FFFFFF)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.local_fire_department, color: Color(0xFFFFD166), size: 24),
          const SizedBox(height: 1),
          Text(
            '$streak Hari',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w800,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: context.appTextPrimary,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: context.appTextSecondary,
            height: 1.25,
          ),
        ),
      ],
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.appBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: context.appSoftSurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF166D56), size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: context.appTextSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    color: context.appTextPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
