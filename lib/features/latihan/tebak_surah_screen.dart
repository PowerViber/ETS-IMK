import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import 'latihan_data.dart';
import 'latihan_provider.dart';

class TebakSurahScreen extends ConsumerStatefulWidget {
  const TebakSurahScreen({
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
  ConsumerState<TebakSurahScreen> createState() => _TebakSurahScreenState();
}

class _TebakSurahScreenState extends ConsumerState<TebakSurahScreen> {
  final List<QuranVerse> _questions = [];
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
    // Filter verses based on settings
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

    filtered.shuffle(_random);
    final numQuestions = min(widget.questionCount, filtered.length);
    final List<QuranVerse> selectedVerses = [];

    for (var verse in filtered) {
      if (selectedVerses.length >= numQuestions) break;

      // Check if this verse is too close (consecutive) to any already selected verse
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

    // Fill remaining if we couldn't meet count without closeness
    if (selectedVerses.length < numQuestions) {
      for (var verse in filtered) {
        if (selectedVerses.length >= numQuestions) break;
        if (!selectedVerses.contains(verse)) {
          selectedVerses.add(verse);
        }
      }
    }

    // Arrange selectedVerses to prevent adjacent consecutive questions
    List<QuranVerse> arrangedVerses = List.from(selectedVerses);
    bool validArrangement = false;
    for (int trial = 0; trial < 100; trial++) {
      arrangedVerses.shuffle(_random);
      bool ok = true;
      for (int i = 0; i < arrangedVerses.length - 1; i++) {
        final current = arrangedVerses[i];
        final next = arrangedVerses[i + 1];
        if (current.surahNumber == next.surahNumber &&
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
      arrangedVerses.shuffle(_random);
    }

    final surahNames = getSurahNamesList();

    setState(() {
      _questions.clear();
      _options.clear();
      _questions.addAll(arrangedVerses);

      for (var verse in arrangedVerses) {
        final correct = verse.surahName;
        final distractors = surahNames.where((name) => name != correct).toList();
        distractors.shuffle(_random);
        
        final list = [correct, ...distractors.take(3)];
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
      final selectedName = _options[_currentIndex][index];
      final correctName = _questions[_currentIndex].surahName;
      if (selectedName == correctName) {
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
            'Tebak Surah',
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
                'Skor Anda dalam Tebak Surah:',
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
                    ? 'Sempurna! Hafalan Anda luar biasa!'
                    : _score >= (totalQ / 2)
                        ? 'Kerja bagus! Teruskan latihan Anda.'
                        : 'Tetap semangat! Coba lagi untuk melatih ingatan.',
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

    final currentVerse = _questions[_currentIndex];
    final currentOpts = _options[_currentIndex];
    final correctName = currentVerse.surahName;
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
          'Tebak Surah',
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
              const SizedBox(height: 24),

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
                        currentVerse.text,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: context.appTextPrimary,
                          height: 1.8,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: context.appSoftSurface,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Ayat ${currentVerse.verseNumber}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: context.appTextSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Multiple Choices
              Column(
                children: List.generate(4, (index) {
                  final optName = currentOpts[index];
                  final isSelected = _selectedAnswerIndex == index;
                  final isCorrect = optName == correctName;

                  Color cardColor = context.appSurface;
                  Color borderColor = context.appBorder;
                  Color textColor = context.appTextPrimary;
                  Widget? suffixIcon;

                  if (_answered) {
                    if (isCorrect) {
                      cardColor = const Color(0xFFE7F7F1);
                      borderColor = const Color(0xFF1AAA7E);
                      textColor = const Color(0xFF11624B);
                      suffixIcon = const Icon(Icons.check_circle_rounded, color: Color(0xFF1AAA7E), size: 20);
                    } else if (isSelected) {
                      cardColor = const Color(0xFFFDF2F2);
                      borderColor = const Color(0xFFE05252);
                      textColor = const Color(0xFF9E1F1F);
                      suffixIcon = const Icon(Icons.cancel_rounded, color: Color(0xFFE05252), size: 20);
                    } else {
                      textColor = context.appTextSecondary;
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () => _handleAnswer(index),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: borderColor, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 28,
                              height: 28,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: isSelected ? Colors.white : context.appTextSecondary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  optName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              if (suffixIcon != null) suffixIcon,
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
