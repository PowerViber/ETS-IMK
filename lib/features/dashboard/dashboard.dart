import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../target/target_provider.dart';

class CustomColors {
  static const Color darkBackground = Color(0xFFF9FAFB);
  static const Color cardSurface = Colors.white;
  static const Color neonGreen = Color(0xFF10B981);
  static const Color electricBlue = Color(0xFF3B82F6);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTargets = ref.watch(targetProvider);
    final today = DateTime.now();
    final todayTargets = allTargets.where((t) => 
      t.date.year == today.year && 
      t.date.month == today.month && 
      t.date.day == today.day
    ).toList();
    
    return Scaffold(
      backgroundColor: CustomColors.darkBackground,
      appBar: AppBar(
        backgroundColor: CustomColors.darkBackground,
        elevation: 0,
        leading: const BackButton(color: CustomColors.textPrimary),
        title: const Text('Dashboard', style: TextStyle(color: CustomColors.textPrimary)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: CustomColors.textPrimary),
            onPressed: () {
              showSearch(context: context, delegate: _SurahSearchDelegate());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Welcome Header 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Assalamu`alaikum,',
                        style: TextStyle(color: CustomColors.textSecondary, fontSize: 14),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Saturo Gojo!',
                        style: TextStyle(
                            color: CustomColors.textPrimary,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 2. Streak Start Banner 
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [CustomColors.neonGreen, Color(0xFF059669)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.neonGreen.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: Colors.white, size: 40),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "ayo mulai streakmu sekarang juga!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 3. Weekly Streak Graph
              const Text(
                'Weekly Streak',
                style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                decoration: BoxDecoration(
                  color: CustomColors.cardSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                      .asMap()
                      .entries
                      .map((entry) {
                    final isActive = entry.key < 4;
                    return Column(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isActive
                                ? CustomColors.neonGreen.withOpacity(0.1)
                                : Colors.transparent,
                            border: Border.all(
                                color: isActive
                                    ? CustomColors.neonGreen
                                    : Colors.grey.withOpacity(0.2)),
                          ),
                          child: isActive
                              ? const Icon(Icons.check,
                                  size: 16, color: CustomColors.neonGreen)
                              : null,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          entry.value,
                          style: TextStyle(
                            color: isActive ? CustomColors.neonGreen : CustomColors.textSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // 4. Target Hari Ini
              const Text(
                'Target Hari ini',
                style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (todayTargets.isNotEmpty)
                ...todayTargets.map((target) => Card(
                      color: Colors.white,
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: target.isCompleted ? AppTheme.accentGreen : Colors.grey[200],
                          child: Icon(
                            Icons.check,
                            color: target.isCompleted ? Colors.white : Colors.grey[400],
                          ),
                        ),
                        title: Text(
                          target.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: target.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                        subtitle: target.description.isNotEmpty ? Text(target.description) : null,
                      ),
                    )),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  context.go('/target');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: CustomColors.cardSurface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: CustomColors.neonGreen.withOpacity(0.5), width: 1.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add_circle_outline, color: CustomColors.neonGreen),
                      SizedBox(width: 8),
                      Text(
                        'Mulai Target Baru',
                        style: TextStyle(
                          color: CustomColors.neonGreen,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 5. Progress Section 
              const Text(
                'Progress',
                style: TextStyle(
                    color: CustomColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: CustomColors.cardSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.withOpacity(0.1)),
                ),
                child: const Center(
                  child: Text(
                    'Belum ada progress',
                    style: TextStyle(color: CustomColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 40), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Search Delegate for Surah/Ayat Search
class _SurahSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Cari surah atau ayat';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Hasil pencarian untuk "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Empty suggestions for now
    return ListView();
  }
}
