import 'package:flutter_riverpod/flutter_riverpod.dart';

class LatihanSession {
  final String id;
  final String type; // 'Tebak Surah' or 'Sambung Ayat'
  final int score;
  final int totalQuestions;
  final DateTime dateTime;

  LatihanSession({
    required this.id,
    required this.type,
    required this.score,
    required this.totalQuestions,
    required this.dateTime,
  });
}

class LatihanHistoryNotifier extends StateNotifier<List<LatihanSession>> {
  LatihanHistoryNotifier() : super([]);

  void addSession(String type, int score, int totalQuestions) {
    final newSession = LatihanSession(
      id: DateTime.now().toIso8601String(),
      type: type,
      score: score,
      totalQuestions: totalQuestions,
      dateTime: DateTime.now(),
    );
    state = [newSession, ...state];
  }

  // Calculate stats
  double getAverageAccuracy() {
    if (state.isEmpty) return 0;
    int totalScore = 0;
    int totalQ = 0;
    for (var session in state) {
      totalScore += session.score;
      totalQ += session.totalQuestions;
    }
    return (totalScore / totalQ) * 100;
  }

  int getTotalCorrectAnswers() {
    int total = 0;
    for (var session in state) {
      total += session.score;
    }
    return total;
  }
}

final latihanHistoryProvider =
    StateNotifierProvider<LatihanHistoryNotifier, List<LatihanSession>>((ref) {
  return LatihanHistoryNotifier();
});
