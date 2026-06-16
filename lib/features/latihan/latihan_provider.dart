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

class VerseAttempt {
  final int surahNumber;
  final String surahName;
  final int verseNumber;
  final int juz;
  final bool isCorrect;
  final DateTime timestamp;

  VerseAttempt({
    required this.surahNumber,
    required this.surahName,
    required this.verseNumber,
    required this.juz,
    required this.isCorrect,
    required this.timestamp,
  });
}

class MurojaahRecommendation {
  final String type; // 'Surah' or 'Juz'
  final String name; // e.g. 'Al-Fatihah' or 'Juz 1'
  final double accuracy; // rate of correct answers (0.0 to 1.0)
  final int totalAttempts;

  MurojaahRecommendation({
    required this.type,
    required this.name,
    required this.accuracy,
    required this.totalAttempts,
  });
}

class LatihanHistoryState {
  final List<LatihanSession> sessions;
  final List<VerseAttempt> attempts;

  LatihanHistoryState({
    required this.sessions,
    required this.attempts,
  });
}

class LatihanHistoryNotifier extends StateNotifier<LatihanHistoryState> {
  LatihanHistoryNotifier()
      : super(LatihanHistoryState(sessions: [], attempts: []));

  void addSession(
    String type,
    int score,
    int totalQuestions,
    List<VerseAttempt> newAttempts,
  ) {
    final newSession = LatihanSession(
      id: DateTime.now().toIso8601String(),
      type: type,
      score: score,
      totalQuestions: totalQuestions,
      dateTime: DateTime.now(),
    );
    state = LatihanHistoryState(
      sessions: [newSession, ...state.sessions],
      attempts: [...newAttempts, ...state.attempts],
    );
  }

  // Calculate overall stats
  double getAverageAccuracy() {
    if (state.sessions.isEmpty) return 0;
    int totalScore = 0;
    int totalQ = 0;
    for (var session in state.sessions) {
      totalScore += session.score;
      totalQ += session.totalQuestions;
    }
    return (totalScore / totalQ) * 100;
  }

  int getTotalCorrectAnswers() {
    int total = 0;
    for (var session in state.sessions) {
      total += session.score;
    }
    return total;
  }

  // Get correct and incorrect counts for a specific verse
  Map<String, int> getVerseStats(String surahName, int verseNumber) {
    int correct = 0;
    int total = 0;
    for (var attempt in state.attempts) {
      if (attempt.surahName == surahName && attempt.verseNumber == verseNumber) {
        total++;
        if (attempt.isCorrect) correct++;
      }
    }
    return {'correct': correct, 'total': total};
  }

  // Get mastery rate for a specific verse (0.0 to 1.0)
  double getVerseMastery(String surahName, int verseNumber) {
    final stats = getVerseStats(surahName, verseNumber);
    if (stats['total'] == 0) return 0.0;
    return stats['correct']! / stats['total']!;
  }

  // Get selection weight for a specific verse (0.15 to 1.0)
  double getVerseWeight(String surahName, int verseNumber) {
    final stats = getVerseStats(surahName, verseNumber);
    final total = stats['total']!;
    if (total == 0) return 0.8; // Default weight for unattempted verses
    final correct = stats['correct']!;
    final mastery = correct / total;
    return (1.0 - mastery).clamp(0.15, 1.0);
  }

  // Get mastery rate for a specific Surah
  double getSurahMastery(String surahName) {
    int correct = 0;
    int total = 0;
    for (var attempt in state.attempts) {
      if (attempt.surahName == surahName) {
        total++;
        if (attempt.isCorrect) correct++;
      }
    }
    if (total == 0) return 0.0;
    return correct / total;
  }

  // Get mastery rate for a specific Juz
  double getJuzMastery(int juz) {
    int correct = 0;
    int total = 0;
    for (var attempt in state.attempts) {
      if (attempt.juz == juz) {
        total++;
        if (attempt.isCorrect) correct++;
      }
    }
    if (total == 0) return 0.0;
    return correct / total;
  }

  // Get list of review recommendations (Surah/Juz where mastery is below 85% and has been attempted)
  List<MurojaahRecommendation> getMurojaahRecommendations() {
    final Map<String, List<bool>> surahResults = {};
    final Map<int, List<bool>> juzResults = {};

    for (var attempt in state.attempts) {
      surahResults.putIfAbsent(attempt.surahName, () => []).add(attempt.isCorrect);
      juzResults.putIfAbsent(attempt.juz, () => []).add(attempt.isCorrect);
    }

    final List<MurojaahRecommendation> recommendations = [];

    // Check Surah recommendations
    surahResults.forEach((surahName, results) {
      final total = results.length;
      final correct = results.where((r) => r).length;
      final accuracy = correct / total;
      if (accuracy < 0.85) {
        recommendations.add(
          MurojaahRecommendation(
            type: 'Surah',
            name: surahName,
            accuracy: accuracy,
            totalAttempts: total,
          ),
        );
      }
    });

    // Check Juz recommendations
    juzResults.forEach((juz, results) {
      final total = results.length;
      final correct = results.where((r) => r).length;
      final accuracy = correct / total;
      if (accuracy < 0.85) {
        recommendations.add(
          MurojaahRecommendation(
            type: 'Juz',
            name: 'Juz $juz',
            accuracy: accuracy,
            totalAttempts: total,
          ),
        );
      }
    });

    // Sort by lowest accuracy first (worst performance needs review most)
    recommendations.sort((a, b) => a.accuracy.compareTo(b.accuracy));
    return recommendations;
  }
}

final latihanHistoryProvider =
    StateNotifierProvider<LatihanHistoryNotifier, LatihanHistoryState>((ref) {
  return LatihanHistoryNotifier();
});
