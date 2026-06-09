import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'target_model.dart';

class TargetNotifier extends StateNotifier<List<TargetItem>> {
  TargetNotifier() : super([]);

  // Create
  void addTarget(String title, String description, DateTime date) {
    final newItem = TargetItem(
      title: title,
      description: description,
      date: _normalizeDate(date),
    );
    state = [...state, newItem];
  }

  // Read: Filter by Day
  List<TargetItem> getTargetsForDate(DateTime date) {
    final normalizedDate = _normalizeDate(date);
    return state.where((item) => item.date == normalizedDate).toList();
  }

  // Update: Toggle Status
  void toggleCompletion(String id) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(isCompleted: !item.isCompleted);
      }
      return item;
    }).toList();
  }

  void updateTarget(
    String id,
    String title,
    String description,
    DateTime date,
  ) {
    state = state.map((item) {
      if (item.id == id) {
        return item.copyWith(
          title: title,
          description: description,
          date: _normalizeDate(date),
        );
      }
      return item;
    }).toList();
  }

  // Delete
  void deleteTarget(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  // Calculate the current consecutive daily streak
  int calculateCurrentStreak() {
    if (state.isEmpty) return 0;
    
    // Filter completed targets and extract their normalized dates
    final completedDates = state
        .where((item) => item.isCompleted)
        .map((item) => _normalizeDate(item.date))
        .toSet()
        .toList();
        
    if (completedDates.isEmpty) return 0;

    // Sort in descending order (most recent first)
    completedDates.sort((a, b) => b.compareTo(a));

    final today = _normalizeDate(DateTime.now());
    final yesterday = today.subtract(const Duration(days: 1));

    // If today and yesterday are not completed, the streak is broken (0)
    if (!completedDates.contains(today) && !completedDates.contains(yesterday)) {
      return 0;
    }

    int streak = 0;
    DateTime checkDate = completedDates.contains(today) ? today : yesterday;

    while (completedDates.contains(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  // Check if at least one target is completed on a specific date
  bool isDateCompleted(DateTime date) {
    final normalized = _normalizeDate(date);
    return state.any((item) => item.isCompleted && _normalizeDate(item.date) == normalized);
  }

  // Helper mapping rule to strip timestamps so day grouping is smooth
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

final targetProvider =
    StateNotifierProvider<TargetNotifier, List<TargetItem>>((ref) {
  return TargetNotifier();
});
