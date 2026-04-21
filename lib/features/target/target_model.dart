import 'package:uuid/uuid.dart';

class TargetItem {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final bool isCompleted;

  TargetItem({
    String? id,
    required this.title,
    required this.description,
    required this.date,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v4();

  TargetItem copyWith({
    String? title,
    String? description,
    DateTime? date,
    bool? isCompleted,
  }) {
    return TargetItem(
      id: this.id, // ID explicitly remains the same
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
