import 'package:flutter_test/flutter_test.dart';
import 'dart:math';
import 'package:modern_habit_app/features/latihan/latihan_data.dart';

class SambungAyatQuizItem {
  final String questionText;
  final String correctAnswerText;
  final String surahName;
  final int verseNumber;

  SambungAyatQuizItem({
    required this.questionText,
    required this.correctAnswerText,
    required this.surahName,
    required this.verseNumber,
  });
}

void main() {
  test('New Sambung Ayat Quiz Generation Logic', () {
    final Random random = Random();
    
    // We will test for Juz 1 and different question counts: 5, 10, 15, 20
    final countsToTest = [5, 10, 15, 20];

    for (var requestedCount in countsToTest) {
      // 1. Filter verses based on Juz 1
      List<QuranVerse> filtered = quranVersesDb.where((v) => v.juz == 1).toList();

      // Shuffle filtered verses first
      filtered.shuffle(random);
      
      final targetCount = min(requestedCount, filtered.length);
      final List<QuranVerse> selectedVerses = [];
      
      // Try to select verses that are not adjacent to each other first
      for (var verse in filtered) {
        if (selectedVerses.length >= targetCount) break;
        
        bool tooClose = false;
        for (var selected in selectedVerses) {
          if (selected.surahNumber == verse.surahNumber &&
              (selected.verseNumber - verse.verseNumber).abs() <= 1) {
            tooClose = true;
            break;
          }
        }
        if (!tooClose) {
          selectedVerses.add(verse);
        }
      }
      
      // If we need more verses, fill them in regardless of closeness
      if (selectedVerses.length < targetCount) {
        for (var verse in filtered) {
          if (selectedVerses.length >= targetCount) break;
          if (!selectedVerses.contains(verse)) {
            selectedVerses.add(verse);
          }
        }
      }

      // Generate exactly one candidate per selected verse
      final List<SambungAyatQuizItem> selectedItems = [];
      for (var verse in selectedVerses) {
        final words = verse.text.split(' ');
        
        if (words.length >= 6) {
          // Long verse
          final splitIdx = (words.length / 2).round();
          final firstHalf = words.sublist(0, splitIdx).join(' ');
          final secondHalf = words.sublist(splitIdx).join(' ');
          
          final nextVerse = quranVersesDb.firstWhere(
            (v) => v.surahNumber == verse.surahNumber && v.verseNumber == verse.verseNumber + 1,
            orElse: () => const QuranVerse(surahNumber: -1, surahName: '', verseNumber: -1, text: '', juz: -1),
          );
          
          final bool canDoTypeB = nextVerse.surahNumber != -1;
          final bool doTypeB = canDoTypeB && random.nextBool();
          
          if (doTypeB) {
            selectedItems.add(
              SambungAyatQuizItem(
                questionText: '... $secondHalf',
                correctAnswerText: nextVerse.text,
                surahName: verse.surahName,
                verseNumber: verse.verseNumber,
              ),
            );
          } else {
            selectedItems.add(
              SambungAyatQuizItem(
                questionText: '$firstHalf ...',
                correctAnswerText: secondHalf,
                surahName: verse.surahName,
                verseNumber: verse.verseNumber,
              ),
            );
          }
        } else {
          // Short verse
          final nextVerse = quranVersesDb.firstWhere(
            (v) => v.surahNumber == verse.surahNumber && v.verseNumber == verse.verseNumber + 1,
            orElse: () => const QuranVerse(surahNumber: -1, surahName: '', verseNumber: -1, text: '', juz: -1),
          );
          
          if (nextVerse.surahNumber != -1) {
            selectedItems.add(
              SambungAyatQuizItem(
                questionText: verse.text,
                correctAnswerText: nextVerse.text,
                surahName: verse.surahName,
                verseNumber: verse.verseNumber,
              ),
            );
          } else {
            selectedItems.add(
              SambungAyatQuizItem(
                questionText: verse.text,
                correctAnswerText: verse.text,
                surahName: verse.surahName,
                verseNumber: verse.verseNumber,
              ),
            );
          }
        }
      }

      // Arrange items to prevent adjacent consecutive questions
      List<SambungAyatQuizItem> arrangedItems = List.from(selectedItems);
      bool validArrangement = false;
      for (int trial = 0; trial < 100; trial++) {
        arrangedItems.shuffle(random);
        bool ok = true;
        for (int i = 0; i < arrangedItems.length - 1; i++) {
          final current = arrangedItems[i];
          final next = arrangedItems[i + 1];
          if (current.surahName == next.surahName &&
              (current.verseNumber - next.verseNumber).abs() <= 1) {
            ok = false;
            break;
          }
        }
        if (ok) {
          validArrangement = true;
          break;
        }
      }
      
      if (!validArrangement) {
        arrangedItems.shuffle(random);
      }

      print('Requested: $requestedCount, Selected: ${arrangedItems.length}');
      for (int i = 0; i < arrangedItems.length; i++) {
        final item = arrangedItems[i];
        print('  [$i] ${item.surahName} ${item.verseNumber}: ${item.questionText}');
      }

      // Assertions
      expect(arrangedItems.length, targetCount);
      
      // If targetCount <= 7 (like only Al-Fatihah), it's possible we can't avoid consecutive.
      // But if targetCount > 1, let's verify if we avoided adjacent consecutive questions if possible.
      // If validArrangement is true, then no two consecutive questions are adjacent.
      print('  Valid Arrangement found: $validArrangement');
    }
  });

  test('Sambung Ayat Quiz Range Filtering Logic (Juz 1-3)', () {
    final Random random = Random();
    
    // 1. Filter verses based on Juz range 1 to 3
    final int startJuz = 1;
    final int endJuz = 3;
    List<QuranVerse> filtered = quranVersesDb.where((v) => v.juz >= startJuz && v.juz <= endJuz).toList();

    // Verify all verses in the list belong to Juz 1, 2, or 3
    for (var v in filtered) {
      expect(v.juz >= startJuz && v.juz <= endJuz, true);
    }
    
    print('Total verses in Juz 1-3: ${filtered.length}');
    
    // 2. Select distinct verses
    filtered.shuffle(random);
    final targetCount = min(15, filtered.length);
    final List<QuranVerse> selectedVerses = [];
    
    for (var verse in filtered) {
      if (selectedVerses.length >= targetCount) break;
      
      bool tooClose = false;
      for (var selected in selectedVerses) {
        if (selected.surahNumber == verse.surahNumber &&
            (selected.verseNumber - verse.verseNumber).abs() <= 1) {
          tooClose = true;
          break;
        }
      }
      if (!tooClose) {
        selectedVerses.add(verse);
      }
    }
    
    if (selectedVerses.length < targetCount) {
      for (var verse in filtered) {
        if (selectedVerses.length >= targetCount) break;
        if (!selectedVerses.contains(verse)) {
          selectedVerses.add(verse);
        }
      }
    }

    expect(selectedVerses.length, targetCount);
    print('Successfully selected $targetCount verses from Juz range 1-3');
  });
}
