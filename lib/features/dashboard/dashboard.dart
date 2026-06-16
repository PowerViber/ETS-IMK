import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_mode_provider.dart';
import '../target/target_provider.dart';
import '../latihan/latihan_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  DateTime _getStartOfWeek() {
    final now = DateTime.now();
    final daysToSubtract = now.weekday - 1;
    return DateTime(now.year, now.month, now.day).subtract(Duration(days: daysToSubtract));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetProvider);
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    final today = _normalize(DateTime.now());
    final todayTargets =
        targets.where((t) => _normalize(t.date) == today).toList();

    final streak = ref.watch(targetProvider.notifier).calculateCurrentStreak();
    
    // Calculate weekly calendar status
    final startOfWeek = _getStartOfWeek();
    final daysOfWeek = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
    final weekDayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final completedStatus = daysOfWeek.map((d) => ref.read(targetProvider.notifier).isDateCompleted(d)).toList();

    final history = ref.watch(latihanHistoryProvider);
    final totalSessions = history.sessions.length;
    final avgAccuracy = ref.read(latihanHistoryProvider.notifier).getAverageAccuracy();
    final totalTargets = targets.length;
    final completedTargetsCount = targets.where((t) => t.isCompleted).length;
    final hasProgress = totalTargets > 0 || totalSessions > 0;

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.appTextPrimary),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          'Dashboard',
          style: TextStyle(
            color: context.appTextPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        actions: const [
          IconButton(
            tooltip: 'Pencarian belum tersedia',
            icon: Icon(Icons.search_off),
            onPressed: null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Assalamu Alaikum,',
              style: TextStyle(
                color: context.appTextSecondary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Ahmad',
              style: TextStyle(
                color: context.appTextPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w800,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.local_fire_department,
                          color: Color(0xFFFFD166), size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Weekly Focus',
                        style: TextStyle(
                          color: Color(0xFFDCEEE8),
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    streak == 0 ? 'Jaga ritme belajarmu.' : '$streak Hari Streak!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    streak == 0
                        ? 'Selesaikan target hari ini agar streak terasa nyata.'
                        : 'Pertahankan kebiasaan belajarmu setiap hari!',
                    style: const TextStyle(
                      color: Color(0xFFDCEEE8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            _ThemeModePanel(
              enabled: isDarkMode,
              onChanged: (value) {
                ref.read(themeModeProvider.notifier).state =
                    value ? ThemeMode.dark : ThemeMode.light;
              },
            ),
            const SizedBox(height: 18),
            const _DashboardSectionHeader(
              title: 'Weekly Streak',
              subtitle: 'Snapshot kebiasaan selama tujuh hari.',
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.appBorder),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  return _StreakItem(
                    day: weekDayLabels[index],
                    done: completedStatus[index],
                  );
                }),
              ),
            ),
            const SizedBox(height: 18),
            const _DashboardSectionHeader(
              title: 'Target Hari Ini',
              subtitle: 'Prioritas yang sedang aktif pada tanggal ini.',
            ),
            const SizedBox(height: 10),
            if (todayTargets.isEmpty)
              GestureDetector(
                onTap: () => context.go('/target'),
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF63B295)),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: Color(0xFF166D56), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Mulai Target Baru',
                          style: TextStyle(
                            color: Color(0xFF166D56),
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              ...todayTargets.map(
                (item) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.appSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.isCompleted
                            ? Icons.check_circle
                            : Icons.check_circle_outline,
                        color: const Color(0xFF166D56),
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          item.title,
                          style: TextStyle(
                            color: context.appTextPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            decoration:
                                item.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 18),
            const _DashboardSectionHeader(
              title: 'Progress',
              subtitle: 'Ringkasan akan muncul ketika aktivitas bertambah.',
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: context.appSurface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.appBorder),
              ),
              child: hasProgress
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (totalTargets > 0) ...[
                          Row(
                            children: [
                              const Icon(Icons.flag_rounded, color: Color(0xFF166D56), size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Target: $completedTargetsCount dari $totalTargets selesai (${(completedTargetsCount * 100 ~/ totalTargets)}%)',
                                  style: TextStyle(
                                    color: context.appTextPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (totalSessions > 0) const SizedBox(height: 12),
                        ],
                        if (totalSessions > 0) ...[
                          Row(
                            children: [
                              const Icon(Icons.quiz_rounded, color: Color(0xFF166D56), size: 20),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Latihan: $totalSessions sesi diselesaikan (Akurasi: ${avgAccuracy.toStringAsFixed(0)}%)',
                                  style: TextStyle(
                                    color: context.appTextPrimary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    )
                  : Row(
                      children: [
                        const Icon(Icons.insights_outlined,
                            color: Color(0xFF166D56), size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Belum ada progress terukur.',
                            style: TextStyle(
                              color: context.appTextSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModePanel extends StatelessWidget {
  const _ThemeModePanel({
    required this.enabled,
    required this.onChanged,
  });

  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.appSoftSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              enabled ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              color: const Color(0xFF166D56),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mode Gelap',
                  style: TextStyle(
                    color: context.appTextPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  enabled
                      ? 'Tampilan redup aktif untuk sesi malam.'
                      : 'Aktifkan tampilan redup untuk sesi malam.',
                  style: TextStyle(
                    color: context.appTextSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: enabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _DashboardSectionHeader extends StatelessWidget {
  const _DashboardSectionHeader({
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
            color: context.appTextPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: context.appTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _StreakItem extends StatelessWidget {
  const _StreakItem({required this.day, required this.done});

  final String day;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: done ? const Color(0xFF1AAA7E) : const Color(0xFFD9E0E5),
              width: 1.5,
            ),
            color: done ? const Color(0xFFE7F7F1) : Colors.transparent,
          ),
          child: done
              ? const Icon(Icons.check, size: 14, color: Color(0xFF1AAA7E))
              : null,
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
            color: done ? const Color(0xFF1AAA7E) : context.appTextSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
