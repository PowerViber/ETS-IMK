import 'package:flutter_test/flutter_test.dart';
import 'package:modern_habit_app/features/latihan/latihan_provider.dart';
import 'package:modern_habit_app/features/latihan/latihan_data.dart';

void main() {
  group('Adaptive Review System Tests', () {
    test('Default/Unattempted Verse Weight', () {
      final notifier = LatihanHistoryNotifier();
      
      // Unattempted verse should have default weight 0.8
      final weight = notifier.getVerseWeight('Al-Fatihah', 1);
      expect(weight, 0.8);
      
      // Mastery of unattempted verse should be 0.0
      final mastery = notifier.getVerseMastery('Al-Fatihah', 1);
      expect(mastery, 0.0);
    });

    test('Mastery and Weight Calculation after attempts', () {
      final notifier = LatihanHistoryNotifier();

      // Add a session with attempts
      final now = DateTime.now();
      final attempts = [
        VerseAttempt(
          surahNumber: 1,
          surahName: 'Al-Fatihah',
          verseNumber: 1,
          juz: 1,
          isCorrect: true,
          timestamp: now,
        ),
        VerseAttempt(
          surahNumber: 1,
          surahName: 'Al-Fatihah',
          verseNumber: 1,
          juz: 1,
          isCorrect: false,
          timestamp: now,
        ),
        VerseAttempt(
          surahNumber: 1,
          surahName: 'Al-Fatihah',
          verseNumber: 2,
          juz: 1,
          isCorrect: false,
          timestamp: now,
        ),
      ];

      notifier.addSession('Sambung Ayat', 1, 3, attempts);

      // Verse 1 has 1 correct, 1 incorrect. Total = 2. Mastery = 0.5.
      expect(notifier.getVerseMastery('Al-Fatihah', 1), 0.5);
      // Weight should be (1.0 - 0.5).clamp(0.15, 1.0) = 0.5
      expect(notifier.getVerseWeight('Al-Fatihah', 1), 0.5);

      // Verse 2 has 0 correct, 1 incorrect. Total = 1. Mastery = 0.0.
      expect(notifier.getVerseMastery('Al-Fatihah', 2), 0.0);
      // Weight should be (1.0 - 0.0).clamp(0.15, 1.0) = 1.0
      expect(notifier.getVerseWeight('Al-Fatihah', 2), 1.0);
    });

    test('Surah and Juz Mastery Calculations', () {
      final notifier = LatihanHistoryNotifier();
      final now = DateTime.now();
      
      // Add attempts: 3 correct, 1 incorrect for Juz 1 / Al-Fatihah
      notifier.addSession(
        'Tebak Surah',
        3,
        4,
        [
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 2, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 3, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 4, juz: 1, isCorrect: false, timestamp: now),
        ],
      );

      // Al-Fatihah mastery should be 3/4 = 0.75
      expect(notifier.getSurahMastery('Al-Fatihah'), 0.75);
      
      // Juz 1 mastery should be 3/4 = 0.75
      expect(notifier.getJuzMastery(1), 0.75);
    });

    test('Murojaah Recommendations Logic', () {
      final notifier = LatihanHistoryNotifier();
      final now = DateTime.now();

      // Add a session where Al-Fatihah has low accuracy, and Al-Baqarah has high accuracy
      notifier.addSession(
        'Sambung Ayat',
        4,
        6,
        [
          // Al-Fatihah: 1 correct, 2 incorrect (accuracy 33.3%)
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 2, juz: 1, isCorrect: false, timestamp: now),
          VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 3, juz: 1, isCorrect: false, timestamp: now),
          
          // Al-Baqarah: 3 correct, 0 incorrect (accuracy 100%)
          VerseAttempt(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 1, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 2, juz: 1, isCorrect: true, timestamp: now),
          VerseAttempt(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 3, juz: 1, isCorrect: true, timestamp: now),
        ],
      );

      final recs = notifier.getMurojaahRecommendations();
      
      // Al-Fatihah should be in recommendations (< 85% accuracy)
      final alFatihahRec = recs.firstWhere((r) => r.name == 'Al-Fatihah');
      expect(alFatihahRec.type, 'Surah');
      expect(alFatihahRec.accuracy, closeTo(1/3, 0.01));
      
      // Al-Baqarah should NOT be in recommendations (100% accuracy >= 85%)
      expect(recs.any((r) => r.name == 'Al-Baqarah'), false);

      // Juz 1 has 4 correct out of 6. Accuracy = 66.6% (< 85%)
      // So Juz 1 should be recommended too!
      final juzRec = recs.firstWhere((r) => r.name == 'Juz 1');
      expect(juzRec.type, 'Juz');
      expect(juzRec.accuracy, closeTo(4/6, 0.01));
    });
   group('Weighted Random Selection Logic', () {
      test('Selecting verses picks items with higher weight (lower mastery)', () {
        final notifier = LatihanHistoryNotifier();
        final now = DateTime.now();

        // Let's seed history to make verse 1 very weak (weight = 1.0) and verse 2 very strong (weight = 0.15)
        notifier.addSession(
          'Tebak Surah',
          2,
          7,
          [
            // Verse 1: 0 correct, 5 incorrect -> weight = 1.0
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: false, timestamp: now),
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: false, timestamp: now),
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: false, timestamp: now),
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: false, timestamp: now),
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, juz: 1, isCorrect: false, timestamp: now),
            
            // Verse 2: 2 correct, 0 incorrect -> weight = 0.15
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 2, juz: 1, isCorrect: true, timestamp: now),
            VerseAttempt(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 2, juz: 1, isCorrect: true, timestamp: now),
          ],
        );

        // Verify the weights
        expect(notifier.getVerseWeight('Al-Fatihah', 1), 1.0);
        expect(notifier.getVerseWeight('Al-Fatihah', 2), 0.15);
      });
    });
  });
}
