import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'latihan_data.dart';
import 'latihan_provider.dart';

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

class SambungAyatScreen extends ConsumerStatefulWidget {
  const SambungAyatScreen({
    super.key,
    this.juzFilter,
    this.startJuzFilter,
    this.endJuzFilter,
    this.surahFilter,
    this.questionCount = 5,
  });

  final int? juzFilter;
  final int? startJuzFilter;
  final int? endJuzFilter;
  final String? surahFilter;
  final int questionCount;

  @override
  ConsumerState<SambungAyatScreen> createState() => _SambungAyatScreenState();
}

class _SambungAyatScreenState extends ConsumerState<SambungAyatScreen> {
  final List<String> _questions = [];
  final List<String> _nextVerses = [];
  final List<String> _surahNames = [];
  final List<int> _verseNumbers = [];
  final List<List<String>> _options = [];
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswerIndex;
  bool _answered = false;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateQuiz();
  }

  void _generateQuiz() {
    // 1. Filter verses based on settings
    List<QuranVerse> filtered = List<QuranVerse>.from(quranVersesDb);

    if (widget.surahFilter != null && widget.surahFilter != 'Semua Surah') {
      filtered = filtered.where((v) => v.surahName == widget.surahFilter).toList();
    } else if (widget.startJuzFilter != null && widget.endJuzFilter != null) {
      filtered = filtered.where((v) => v.juz >= widget.startJuzFilter! && v.juz <= widget.endJuzFilter!).toList();
    } else if (widget.juzFilter != null && widget.juzFilter != 0) {
      filtered = filtered.where((v) => v.juz == widget.juzFilter).toList();
    }

    if (filtered.isEmpty) {
      filtered = List<QuranVerse>.from(quranVersesDb);
    }

    // 2. Select distinct verses
    // Shuffle the filtered verses first
    filtered.shuffle(_random);

    final targetCount = min(widget.questionCount, filtered.length);
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

    // 3. Generate exactly one SambungAyatQuizItem for each selected verse
    final List<SambungAyatQuizItem> selectedItems = [];
    for (var verse in selectedVerses) {
      final words = verse.text.split(' ');

      if (words.length >= 6) {
        // Long verse: randomly choose Type A (split verse) or Type B (split to next)
        final splitIdx = (words.length / 2).round();
        final firstHalf = words.sublist(0, splitIdx).join(' ');
        final secondHalf = words.sublist(splitIdx).join(' ');

        final nextVerse = quranVersesDb.firstWhere(
          (v) => v.surahNumber == verse.surahNumber && v.verseNumber == verse.verseNumber + 1,
          orElse: () => const QuranVerse(surahNumber: -1, surahName: '', verseNumber: -1, text: '', juz: -1),
        );

        final bool canDoTypeB = nextVerse.surahNumber != -1;
        final bool doTypeB = canDoTypeB && _random.nextBool();

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
        // Short verse: Type C (entire verse to next)
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

    // 4. Arrange the selectedItems such that no two adjacent questions in the quiz list
    // are consecutive verses of the same Surah.
    List<SambungAyatQuizItem> arrangedItems = List.from(selectedItems);
    bool validArrangement = false;
    for (int trial = 0; trial < 100; trial++) {
      arrangedItems.shuffle(_random);
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
      arrangedItems.shuffle(_random);
    }

    // 5. Generate option lists for each selected item
    setState(() {
      _questions.clear();
      _nextVerses.clear();
      _surahNames.clear();
      _verseNumbers.clear();
      _options.clear();

      for (var item in arrangedItems) {
        _questions.add(item.questionText);
        _nextVerses.add(item.correctAnswerText);
        _surahNames.add(item.surahName);
        _verseNumbers.add(item.verseNumber);

        final correctText = item.correctAnswerText;

        // Collect distractor candidates from filtered verses
        final List<String> distractorPool = [];
        for (var other in filtered) {
          if (other.text != correctText && other.text != item.questionText) {
            distractorPool.add(other.text);
          }
        }
        if (distractorPool.length < 5) {
          for (var other in quranVersesDb) {
            if (other.text != correctText && other.text != item.questionText) {
              distractorPool.add(other.text);
            }
          }
        }

        final distractors = distractorPool.toSet().toList();
        distractors.shuffle(_random);

        final list = [correctText, ...distractors.take(3)];
        list.shuffle(_random);
        _options.add(list);
      }

      _currentIndex = 0;
      _score = 0;
      _selectedAnswerIndex = null;
      _answered = false;
    });
  }

  void _handleAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswerIndex = index;
      _answered = true;
      final selectedText = _options[_currentIndex][index];
      final correctText = _nextVerses[_currentIndex];
      if (selectedText == correctText) {
        _score++;
      }
    });
  }

  void _handleNext() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedAnswerIndex = null;
        _answered = false;
      });
    } else {
      // Save result to provider
      ref.read(latihanHistoryProvider.notifier).addSession(
            'Sambung Ayat',
            _score,
            _questions.length,
          );
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    final totalQ = _questions.length;
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: context.appSurface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: Color(0xFFE7F7F1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.emoji_events_rounded,
                  color: Color(0xFF1AAA7E),
                  size: 40,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Latihan Selesai!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: context.appTextPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Skor Anda dalam Sambung Ayat:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.appTextSecondary,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: context.appSoftSurface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  '$_score / $totalQ',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF166D56),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _score == totalQ
                    ? 'Luar biasa! Hafalan Anda sangat lancar!'
                    : _score >= (totalQ / 2)
                        ? 'Bagus sekali! Terus sambung hafalan Anda.'
                        : 'Belajar lagi! Ulangi hafalan agar semakin mantap.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.appTextSecondary,
                ),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                context.go('/latihan'); // Go back to latihan dashboard
              },
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF166D56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Selesai',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: context.appBackground,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final currentVerseText = _questions[_currentIndex];
    final correctNextText = _nextVerses[_currentIndex];
    final currentOpts = _options[_currentIndex];
    final totalQ = _questions.length;

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appBackground,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: context.appTextPrimary),
          onPressed: () => context.go('/latihan'),
        ),
        title: const Text(
          'Sambung Ayat',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pertanyaan ${_currentIndex + 1} dari $totalQ',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: context.appTextSecondary,
                    ),
                  ),
                  Text(
                    'Skor: $_score',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF166D56),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 8,
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / totalQ,
                    backgroundColor: context.appSoftSurface,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF166D56)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Question Box
              Container(
                constraints: const BoxConstraints(minHeight: 180),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.appSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: context.appBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 18,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sambung ayat berikut:',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: context.appTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        currentVerseText,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: context.appTextPrimary,
                          height: 1.8,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: context.appSoftSurface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${_surahNames[_currentIndex]} : Ayat ${_verseNumbers[_currentIndex]}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF166D56),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Multiple Choices
              Column(
                children: List.generate(4, (index) {
                  final optText = currentOpts[index];
                  final isSelected = _selectedAnswerIndex == index;
                  final isCorrect = optText == correctNextText;

                  Color cardColor = context.appSurface;
                  Color borderColor = context.appBorder;
                  Color textColor = context.appTextPrimary;
                  Widget? suffixIcon;

                  if (_answered) {
                    if (isCorrect) {
                      cardColor = const Color(0xFFE7F7F1);
                      borderColor = const Color(0xFF1AAA7E);
                      textColor = const Color(0xFF11624B);
                      suffixIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF1AAA7E), size: 18);
                    } else if (isSelected) {
                      cardColor = const Color(0xFFFDF2F2);
                      borderColor = const Color(0xFFE05252);
                      textColor = const Color(0xFF9E1F1F);
                      suffixIcon = const Icon(Icons.cancel_rounded, color: Color(0xFFE05252), size: 18);
                    } else {
                      textColor = context.appTextSecondary;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => _handleAnswer(index),
                      borderRadius: BorderRadius.circular(14),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: borderColor, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF166D56)
                                    : context.appSoftSurface,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                String.fromCharCode(65 + index), // A, B, C, D
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  color: isSelected ? Colors.white : context.appTextSecondary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                optText,
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                            if (suffixIcon != null) ...[
                              const SizedBox(width: 10),
                              suffixIcon,
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 14),

              // Next Button
              if (_answered)
                ElevatedButton(
                  onPressed: _handleNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF166D56),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentIndex < totalQ - 1 ? 'Berikutnya' : 'Lihat Hasil',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                )
              else
                const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
