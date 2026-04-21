import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../target/target_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  DateTime _normalize(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targets = ref.watch(targetProvider);
    final today = _normalize(DateTime.now());
    final todayTargets =
        targets.where((t) => _normalize(t.date) == today).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F4F6),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2F3A43)),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Color(0xFF2F3A43),
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF2F3A43)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assalamu Alaikum,',
              style: TextStyle(
                color: Color(0xFF66717C),
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'Ahmad',
              style: TextStyle(
                color: Color(0xFF1E2933),
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF0B8A63),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.local_fire_department,
                      color: Color(0xFFE3F7EF), size: 42),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'ayo mulai streakmu sekarang juga!',
                      style: TextStyle(
                        color: Color(0xFFE3F7EF),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Weekly Streak',
              style: TextStyle(
                color: Color(0xFF1E2933),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5EAEE)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StreakItem(day: 'M', done: true),
                  _StreakItem(day: 'T', done: true),
                  _StreakItem(day: 'W', done: true),
                  _StreakItem(day: 'T', done: true),
                  _StreakItem(day: 'F', done: false),
                  _StreakItem(day: 'S', done: false),
                  _StreakItem(day: 'S', done: false),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Target Hari ini',
              style: TextStyle(
                color: Color(0xFF1E2933),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            if (todayTargets.isEmpty)
              GestureDetector(
                onTap: () => context.go('/target'),
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border:
                        Border.all(color: const Color(0xFF66B8A0), width: 2),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add_circle_outline,
                            color: Color(0xFF169974), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Mulai Target Baru',
                          style: TextStyle(
                            color: Color(0xFF169974),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
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
                    color: const Color(0xFFF9FAFA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE5EAEE)),
                  ),
                  child: Text(
                    item.title,
                    style: const TextStyle(
                      color: Color(0xFF1E2933),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 14),
            const Text(
              'Progress',
              style: TextStyle(
                color: Color(0xFF1E2933),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 86,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFA),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE5EAEE)),
              ),
              child: const Center(
                child: Text(
                  'Belum ada progress',
                  style: TextStyle(
                    color: Color(0xFF87939D),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
            color: done ? const Color(0xFF1AAA7E) : const Color(0xFF6A7480),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
