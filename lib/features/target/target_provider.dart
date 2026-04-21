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

  // Delete
  void deleteTarget(String id) {
    state = state.where((item) => item.id != id).toList();
  }

  // Helper mapping rule to strip timestamps so day grouping is smooth
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}

final targetProvider = StateNotifierProvider<TargetNotifier, List<TargetItem>>((ref) {
  return TargetNotifier();
});
