import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class QuranReadScreen extends StatelessWidget {
  const QuranReadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Al-Fatihah verses for mockup
    final List<String> verses = [
      "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
      "ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ",
      "ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
      "مَٰلِكِ يَوْمِ ٱلدِّينِ",
      "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
      "ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ",
      "صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ"
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => context.go('/dashboard'),
        ),
        title: GestureDetector(
          onTap: () {
            // TODO: Open Surah Directory Dropdown
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Al-Fatihah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        itemCount: verses.length,
        itemBuilder: (context, index) {
          final isBismillah = index == 0;
          return Padding(
            padding: EdgeInsets.only(bottom: isBismillah ? 40.0 : 28.0),
            child: Text(
              verses[index],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isBismillah ? 32 : 28,
                height: 1.8,
                color: isBismillah ? AppTheme.accentGreen : Colors.white,
                fontWeight: isBismillah ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
