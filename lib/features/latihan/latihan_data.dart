class QuranVerse {
  final int surahNumber;
  final String surahName;
  final int verseNumber;
  final String text;
  final int juz;

  const QuranVerse({
    required this.surahNumber,
    required this.surahName,
    required this.verseNumber,
    required this.text,
    required this.juz,
  });
}

const List<QuranVerse> quranVersesDb = [
  // === JUZ 1 ===
  // Al-Fatihah
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 1, text: 'بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 2, text: 'ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 3, text: 'ٱلرَّحْمَٰنِ ٱلرَّحِيمِ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 4, text: 'مَٰلِكِ يَوْمِ ٱلدِّينِ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 5, text: 'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 6, text: 'ٱهْدِنَا ٱلصِّرَٰطَ ٱلْمُسْتَقِيمَ', juz: 1),
  QuranVerse(surahNumber: 1, surahName: 'Al-Fatihah', verseNumber: 7, text: 'صِرَٰطَ ٱلَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ ٱلْمَغْضُوبِ عَلَيْهِمْ وَلَا ٱلضَّآلِّينَ', juz: 1),
  // Al-Baqarah (Juz 1 part)
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 1, text: 'الم', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 2, text: 'ذَٰلِكَ ٱلْكِتَٰبُ لَا رَيْبَ ۛ فِيهِ ۛ هُدًى لِّلْمُتَّقِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 3, text: 'ٱلَّذِينَ يُؤْمِنُونَ بِٱلْغَيْبِ وَيُقِيمُونَ ٱلصَّلَوٰةَ وَمِمَّا رَزَقْنَٰهُمْ يُنفِقُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 4, text: 'وَٱلَّذِينَ يُؤْمِنُونَ بِمَآ أُنزِلَ إِلَيْكَ وَمَآ أُنزِلَ مِن قَبْلِكَ وَبِٱلْءَاخِرَةِ هُمْ يُوقِنُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 5, text: 'أُو۟لَٰٓئِكَ عَلَىٰ هُدًى مِّن رَّبِّهِمْ ۖ وَأُو۟لَٰٓئِكَ هُمُ ٱلْمُفْلِحُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 6, text: 'إِنَّ ٱلَّذِينَ كَفَرُوا۟ سَوَآءٌ عَلَيْهِمْ ءَأَنذَرْتَهُمْ أَمْ لَمْ تُنذِرْهُمْ لَا يُؤْمِنُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 7, text: 'خَتَمَ ٱللَّهُ عَلَىٰ قُلُوبِهِمْ وَعَلَىٰ سَمْعِهِمْ ۖ وَعَلَىٰٓ أَبْصَٰرِهِمْ غِشَٰوَةٌ ۖ وَلَهُمْ عَذَابٌ عَظِيمٌ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 8, text: 'وَمِنَ ٱلنَّاسِ مَن يَقُولُ ءَامَنَّا بِٱللَّهِ وَبِٱلْيَوْمِ ٱلْءَاخِرِ وَمَا هُم بِمُؤْمِنِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 9, text: 'يُخَٰدِعُونَ ٱللَّهَ وَٱلَّذِينَ ءَامَنُوا۟ وَمَا يَخْدَعُونَ إِلَّآ أَنفُسَهُمْ وَمَا يَشْعُرُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 10, text: 'فِى قُلُوبِهِم مَّرَضٌ فَزَادَهُمُ ٱللَّهُ مَرَضًا ۖ وَلَهُمْ عَذَابٌ أَلِيمٌۢ بِمَا كَانُوا۟ يَكْذِبُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 11, text: 'وَإِذَا قِيلَ لَهُمْ لَا تُفْسِدُوا۟ فِى ٱلْأَرْضِ قَالُوٓا۟ إِنَّمَا نَحْنُ مُصْلِحُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 12, text: 'أَلَآ إِنَّهُمْ هُمُ ٱلْمُفْسِدُونَ وَلَـٰكِن لَّا يَشْعُرُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 13, text: 'وَإِذَا قِيلَ لَهُمْ ءَامِنُوا۟ كَمَآ ءَامَنَ ٱلنَّاسُ قَالُوٓا۟ أَنُؤْمِنُ كَمَآ ءَامَنَ ٱلسُّفَهَآءُ ۗ أَلَآ إِنَّهُمْ هُمُ ٱلسُّفَهَآءُ وَلَـٰكِن لَّا يَعْلَمُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 14, text: 'وَإِذَا لَقُوا۟ ٱلَّذِينَ ءَامَنُوا۟ قَالُوٓا۟ ءَامَنَّا وَإِذَا خَلَوْا۟ إِلَىٰ شَيَٰطِينِهِمْ قَالُوٓا۟ إِنَّا مَعَكُمْ إِنَّمَا نَحْنُ مُسْتَهْزِءُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 15, text: 'ٱللَّهُ يَسْتَهْزِئُ بِهِمْ وَيَمُدُّهُمْ فِى طُغْيَٰنِهِمْ يَعْمَهُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 16, text: 'أُو۟لَٰٓئِكَ ٱلَّذِينَ ٱشْتَرَوُا۟ ٱلضَّلَٰلَةَ بِٱلْهُدَىٰ فَمَا رَبِحَت تِّجَٰرَتُهُمْ وَمَا كَانُوا۟ مُهْتَدِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 17, text: 'مَثَلُهُمْ كَمَثَلِ ٱلَّذِى ٱسْتَوْقَدَ نَارًا فَلَمَّآ أَضَآءَتْ مَا حَوْلَهُۥ ذَهَبَ ٱللَّهُ بِنُورِهِمْ وَتَرَكَهُمْ فِى ظُلُمَٰتٍ لَّا يُبْصِرُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 18, text: 'صُمٌّۢ بُكْمٌ عُمْىٌ فَهُمْ لَا يَرْجِعُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 19, text: 'أَوْ كَصَيِّبٍ مِّنَ ٱلسَّمَآءِ فِيهِ ظُلُمَٰتٌ وَرَعْدٌ وَبَرْقٌ يَجْعَلُونَ أَصَٰبِعَهُمْ فِىٓ ءَاذَانِهِم مِّنَ ٱلصَّوَٰعِقِ حَذَرَ ٱلْمَوْتِ ۚ وَٱللَّهُ مُحِيطٌۢ بِٱلْكَٰفِرِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 20, text: 'يَكَادُ ٱلْبَرْقُ يَخْطَفُ أَبْصَٰرَهُمْ ۖ كُلَّمَآ أَضَآءَ لَهُم مَّشَوْا۟ فِيهِ وَإِذَآ أَظْلَمَ عَلَيْهِمْ قَامُوا۟ ۚ وَلَوْ شَآءَ ٱللَّهُ لَذَهَبَ بِسَمْعِهِمْ وَأَبْصَٰرِهِمْ ۚ إِنَّ ٱللَّهَ عَلَىٰ كُلِّ شَىْءٍ قَدِيرٌ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 21, text: 'يَٰٓأَيُّهَا ٱلنَّاسُ ٱعْبُدُوا۟ رَبَّكُمُ ٱلَّذِى خَلَقَكُمْ وَٱلَّذِينَ مِن قَبْلِكُمْ لَعَلَّكُمْ تَتَّقُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 22, text: 'ٱلَّذِى جَعَلَ لَكُمُ ٱلْأَرْضَ فِرَٰشًا وَٱلسَّمَآءَ بِنَآءً وَأَنزَلَ مِنَ ٱلسَّمَآءِ مَآءً فَأَخْرَجَ بِهِۦ مِنَ ٱلثَّمَرَٰتِ رِزْقًا لَّكُمْ ۖ فَلَا تَجْعَلُوا۟ لِلَّهِ أَندَادًا وَأَنتُمْ تَعْلَمُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 23, text: 'وَإِن كُنتُمْ فِى رَيْبٍ مِّمَّا نَزَّلْنَا عَلَىٰ عَبْدِنَا فَأْتُوا۟ بِسُورَةٍ مِّن مِّثْلِهِۦ وَٱدْعُوا۟ شُهَدَآءَكُم مِّن دُونِ ٱللَّهِ إِن كُنتُمْ صَٰدِقِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 24, text: 'فَإِن لَّمْ تَفْعَلُوا۟ وَلَن تَفْعَلُوا۟ فَٱتَّقُوا۟ ٱلنَّارَ ٱلَّتِى وَقُودُهَا ٱلنَّاسُ وَٱلْحِجَارَةُ ۖ أُعِدَّتْ لِلْكَٰفِرِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 25, text: 'وَبَشِّرِ ٱلَّذِينَ ءَامَنُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ أَنَّ لَهُمْ جَنَّٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ ۖ كُلَّمَا رُزِقُوا۟ مِنْهَا مِن ثَمَرَةٍ رِّزْقًا ۙ قَالُوا۟ هَٰذَا ٱلَّذِى رُزِقْنَا مِن قَبْلُ ۖ وَأُتُوا۟ بِهِۦ مُتَشَٰبِهًا ۖ وَلَهُمْ فِيهَآ أَزْوَٰجٌ مُّطَهَّرَةٌ ۖ وَهُمْ فِيهَا خَٰلِدُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 26, text: 'إِذْ إِنَّ ٱللَّهَ لَا يَسْتَحْىِۦٓ أَن يَضْرِبَ مَثَلًا مَّا بَعُوضَةً فَمَا فَوْقَهَا ۚ فَأَمَّا ٱلَّذِينَ ءَامَنُوا۟ فَيَعْلَمُونَ أَنَّهُ ٱلْحَقُّ مِن رَّبِّهِمْ ۖ وَأَمَّا ٱلَّذِينَ كَفَرُوا۟ فَيَقُولُونَ مَاذَآ أَرَادَ ٱللَّهُ بِهَٰذَا مَثَلًا ۘ يُضِلُّ بِهِۦ كَثِيرًا وَيَهْدِى بِهِۦ كَثِيرًا ۚ وَمَا يُضِلُّ بِهِۦٓ إِلَّا ٱلْفَٰسِقِينَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 27, text: 'ٱلَّذِينَ يَنقُضُونَ عَهْدَ ٱللَّهِ مِنۢ بَعْدِ مِيثَٰقِهِۦ وَيَقْطَعُونَ مَآ أَمَرَ ٱللَّهُ بِهِۦٓ أَن يُوصَلَ وَيُفْسِدُونَ فِى ٱلْأَرْضِ ۚ أُو۟لَٰٓئِكَ هُمُ ٱلْخَٰسِرُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 28, text: 'كَيْفَ تَكْفُرُونَ بِٱللَّهِ وَكُنتُمْ أَمْوَٰتًا فَأَحْيَٰكُمْ ۖ ثُمَّ يُمِيتُكُمْ ثُمَّ يُحْيِيكُمْ ثُمَّ إِلَيْهِ تُرْجَعُونَ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 29, text: 'هُوَ ٱلَّذِى خَلَقَ لَكُم مَّا فِى ٱلْأَرْضِ جَمِيعًا ثُمَّ ٱسْتَوَىٰٓ إِلَى ٱالسَّمَآءِ فَسَوَّىٰهُنَّ سَبْعَ سَمَٰوَٰتٍ ۚ وَهُوَ بِكُلِّ شَىْءٍ عَلِيمٌ', juz: 1),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 30, text: 'وَإِذْ قَالَ رَبُّكَ لِلْمَلَٰٓئِكَةِ إِنِّى جَاعِلٌ فِى ٱلْأَرْضِ خَلِيفَةً ۖ قَالُوٓا۟ أَتَجْعَلُ فِيهَا مَن يُفْسِدُ فِيهَا وَيَسْفِكُ ٱلدِّمَآءَ وَنَحْنُ نُسَبِّحُ بِحَمْدِكَ وَنُقَدِّسُ لَكَ ۖ قَالَ إِنِّىٓ أَعْلَمُ مَا لَا تَعْلَمُونَ', juz: 1),

  // === JUZ 2 ===
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 142, text: 'سَيَقُولُ ٱالسُّفَهَآءُ مِنَ ٱلنَّاسِ مَا وَلَّىٰهُمْ عَن قِبْلَتِهِمُ ٱلَّتِى كَانُوا۟ عَلَيْهَا', juz: 2),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 143, text: 'وَكَذَٰلِكَ جَعَلْنَٰكُمْ أُمَّةً وَسَطًا لِّتَكُونُوا۟ شُهَدَآءَ عَلَى ٱلنَّاسِ', juz: 2),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 144, text: 'قَدْ نَرَىٰ تَقَلُّبَ وَجْهِكَ فِى ٱلسَّمَآءِ فَلَنُوَلِّيَنَّكَ قِبْلَةً تَرْضَىٰهَا فَوَلِّ وَجْهَكَ شَطْرَ ٱلْمَسْجِدِ ٱلْحَرَامِ', juz: 2),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 145, text: 'وَلَئِنْ أَتَيْتَ ٱلَّذِينَ أُوتُوا۟ ٱلْكِتَٰبَ بِكُلِّ ءَايَةٍ مَّا تَبِعُوا۟ قِبْلَتَكَ', juz: 2),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 146, text: 'ٱلَّذِينَ ءَاتَيْنَٰهُمُ ٱلْكِتَٰبَ يَعْرِفُونَهُۥ كَمَا يَعْرِفُونَ أَبْنَآءَهُمْ', juz: 2),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 147, text: 'ٱلْحَقُّ مِن رَّبِّكَ فَلَا تَكُونَنَّ مِنَ ٱلْمُمْتَرِينَ', juz: 2),

  // === JUZ 3 ===
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 255, text: 'ٱللَّهُ لَآ إِلَٰهَ إِلَّا هُوَ ٱلْحَىُّ ٱلْقَيُّومُ لَا تَأْخُذُهُۥ سِنَةٌ وَلَا نَوْمٌ', juz: 3),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 256, text: 'لَآ إِكْرَاهَ فِى ٱلدِّينِ قَد تَّبَيَّنَ ٱلرُّشْدُ مِنَ ٱلْغَىِّ', juz: 3),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 257, text: 'ٱللَّهُ وَلِىُّ ٱلَّذِينَ ءَامَنُوا۟ يُخْرِجُهُم مِّنَ ٱلظُّلُمَٰتِ إِلَى ٱلنُّورِ', juz: 3),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 258, text: 'أَلَمْ تَرَ إِلَى ٱلَّذِى حَآجَّ إِبْرَٰهِيمَ فِى رَبِّهِۦٓ أَنْ ءَاتَىٰهُ ٱللَّهُ ٱلْمُلْكَ', juz: 3),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 259, text: 'أَوْ كَالَّذِى مَرَّ عَلَىٰ قَرْيَةٍ وَهِىَ خَاوِيَةٌ عَلَىٰ عُرُوشِهَا', juz: 3),
  QuranVerse(surahNumber: 2, surahName: 'Al-Baqarah', verseNumber: 260, text: 'وَإِذْ قَالَ إِبْرَٰهِيمُ رَبِّ أَرِنِى كَيْفَ تُحْىِ ٱلْمَوْتَىٰ', juz: 3),

  // === JUZ 4 ===
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 92, text: 'لَن تَنَالُوا۟ ٱلْبِرَّ حَتَّىٰ تُنفِقُوا۟ مِمَّا تُحِبُّونَ', juz: 4),
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 93, text: 'كُلُّ ٱلطَّعَامِ كَانَ حِلًّا لِّبَنِىٓ إِسْرَٰٓءِيلَ إِلَّا مَا حَرَّمَ إِسْرَٰٓءِيلُ', juz: 4),
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 94, text: 'فَمَنِ ٱفْتَرَىٰ عَلَى ٱللَّهِ ٱلْكَذِبَ مِنۢ بَعْدِ ذَٰلِكَ فَأُو۟لَٰٓئِكَ هُمُ ٱلظَّٰلِمُونَ', juz: 4),
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 95, text: 'قُلْ صَدَقَ ٱللَّهُ فَٱتَّبِعُوا۟ مِلَّةَ إِبْرَٰهِيمَ حَنِيفًا وَمَا كَانَ مِنَ ٱلْمُشْرِكِينَ', juz: 4),
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 96, text: 'إِنَّ أَوَّلَ بَيْتٍ وُضِعَ لِلنَّاسِ لَلَّذِى بِبَكَّةَ مُبَارَكًا وَهُدًى لِّلْعَٰلَمِينَ', juz: 4),
  QuranVerse(surahNumber: 3, surahName: 'Ali \'Imran', verseNumber: 97, text: 'فِيهِ ءَايَٰتٌۢ بَيِّنَٰتٌ مَّقَامُ إِبْرَٰهِيمَ ۖ وَمَن دَخَلَهُۥ كَانَ ءَامِنًا', juz: 4),

  // === JUZ 5 ===
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 24, text: 'وَٱلْمُحْصَنَٰتُ مِنَ ٱلنِّسَآءِ إِلَّا مَا مَلَكَتْ أَيْمَٰنُكُمْ كِتَٰبَ ٱللَّهِ عَلَيْكُمْ', juz: 5),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 25, text: 'وَمَن لَّمْ يَسْتَطِعْ مِنكُمْ طَوْلًا أَن يَنكِحَ ٱلْمُحْصَنَٰتِ ٱلْمُؤْمِنَٰتِ', juz: 5),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 26, text: 'يُرِيدُ ٱللَّهُ لِيُبَيِّنَ لَكُمْ وَيَهْدِيَكُمْ سُنَنَ ٱلَّذِينَ مِن قَبْلِكُمْ', juz: 5),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 27, text: 'وَٱللَّهُ يُرِيدُ أَن يَتُوبَ عَلَيْكُمْ وَيُرِيدُ ٱلَّذِينَ يَتَّبِعُونَ ٱلشَّهَوَٰتِ أَن تَمِيلُوا۟ مَيْلًا عَظِيمًا', juz: 5),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 28, text: 'يُرِيدُ ٱللَّهُ أَن يُخَفِّفَ عَنكُمْ ۚ وَخُلِقَ ٱلْإِنسَٰنُ ضَعِيفًا', juz: 5),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 29, text: 'يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ لَا تَأْكُلُوٓا۟ أَمْوَٰلَكُم بَيْنَكُم بِٱلْبَٰطِلِ', juz: 5),

  // === JUZ 6 ===
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 148, text: 'لَا يُحِبُّ ٱللَّهُ ٱلْجَهْرَ بِٱلسُّوٓءِ مِنَ ٱلْقَوْلِ إِلَّا مَن ظُلِمَ', juz: 6),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 149, text: 'إِن تُبْدُوا۟ خَيْرًا أَوْ تُخْفُوهُ أَوْ تَعْفُوا۟ عَن سُووٓءٍ فَإِنَّ ٱللَّهَ كَانَ عَفُوًّا قَدِيرًا', juz: 6),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 150, text: 'إِنَّ ٱلَّذِينَ يَكْفُرُونَ بِٱللَّهِ وَرُسُلِهِۦ وَيُرِيدُونَ أَن يُفَرِّقُوا۟ بَيْنَ ٱللَّهِ وَرُسُلِهِۦ', juz: 6),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 151, text: 'أُو۟لَٰٓئِكَ هُمُ ٱلْكَٰفِرُونَ حَقًّا وَأَعْتَدْنَا لِلْكَٰفِرِينَ عَذَابًا مُّهِينًا', juz: 6),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 152, text: 'وَٱلَّذِينَ ءَامَنُوا۟ بِٱللَّهِ وَرُسُلِهِۦ وَلَمْ يُفَرِّقُوا۟ بَيْنَ أَحَدٍ مِّنْهُمْ', juz: 6),
  QuranVerse(surahNumber: 4, surahName: 'An-Nisa\'', verseNumber: 153, text: 'يَسْـَٔلُكَ أَهْلُ ٱلْكِتَٰبِ أَن تُنَزِّلَ عَلَيْهِمْ كِتَٰبًا مِّنَ ٱلسَّمَآءِ', juz: 6),

  // === JUZ 7 ===
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 82, text: 'لَتَجِدَنَّ أَشَدَّ ٱلنَّاسِ عَدَٰوَةً لِّلَّذِينَ ءَامَنُوا۟ ٱلْيَهُودَ وَٱلَّذِينَ أَشْرَكُوا۟', juz: 7),
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 83, text: 'وَإِذَا سَمِعُوا۟ مَآ أُنزِلَ إِلَى ٱلرَّسُولِ تَرَىٰٓ أَعْيُنَهُمْ تَفِيضُ مِنَ ٱلدَّمْعِ', juz: 7),
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 84, text: 'وَمَا لَنَا لَا نُؤْمِنُ بِٱللَّهِ وَمَا جَآءَنَا مِنَ ٱلْحَقِّ وَنَطْمَعُ أَن يُدْخِلَنَا رَبُّنَا مَعَ ٱلْقَوْمِ ٱلصَّٰلِحِينَ', juz: 7),
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 85, text: 'فَأَثَٰبَهُمُ ٱللَّهُ بِمَا قَالُوا۟ جَنَّٰتٍ تَجْرِى مِن تَحْتِهَا ٱلْأَنْهَٰرُ خَٰلِدِينَ فِيهَا', juz: 7),
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 86, text: 'وَٱلَّذِينَ كَفَرُوا۟ وَكَذَّبُوا۟ بِـَٔايَٰتِنَآ أُو۟لَٰٓئِكَ أَصْحَٰبُ ٱلْجَحِيمِ', juz: 7),
  QuranVerse(surahNumber: 5, surahName: 'Al-Ma\'idah', verseNumber: 87, text: 'يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوا۟ لَا تُحرِّمُوا۟ طَيِّبَٰتِ مَآ أَحَلَّ ٱللَّهُ لَكُمْ', juz: 7),

  // === JUZ 8 ===
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 111, text: 'وَلَوْ أَنَّنَا نَزَّلْنَآ إِلَيْهِمُ ٱلْمَلَٰٓئِكَةَ وَكَلَّمَهُمُ ٱلْمَوْتَىٰ', juz: 8),
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 112, text: 'وَكَذَٰلِكَ جَعَلْنَا لِكُلِّ نَبِىٍّ عَدُوًّا شَيَٰطِينَ ٱلْإِنسِ وَٱلْجِنِّ', juz: 8),
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 113, text: 'وَلِتَصْغَىٰٓ إِلَيْهِ أَفْـِٔدَةُ ٱلَّذِينَ لَا يُؤْمِنُونَ بِٱلْءَاخِرَةِ وَلِيَرْضَوْهُ', juz: 8),
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 114, text: 'أَفَغَيْرَ ٱللَّهِ أَبْتَغِى حَكَمًا وَهُوَ ٱلَّذِىٓ أَنزَلَ إِلَيْكُمُ ٱلْكِتَٰبَ مُفَصَّلًا', juz: 8),
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 115, text: 'وَتَمَّتْ كَلِمَتُ رَبِّكَ صِدْقًا وَعَدْلًا ۚ لَّا مُبَدِّلَ لِكَلِمَٰتِهِۦ', juz: 8),
  QuranVerse(surahNumber: 6, surahName: 'Al-An\'am', verseNumber: 116, text: 'وَإِن تُطِعْ أَكْثَرَ مَن فِى ٱلْأَرْضِ يُضِلُّوكَ عَن سَبِيلِ ٱللَّهِ', juz: 8),

  // === JUZ 9 ===
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 88, text: 'قَالَ ٱلْمَلَأُ ٱلَّذِينَ ٱسْتَكْبَرُوا۟ مِن قَوْمِهِۦ Lَنُخْرِجَنَّكَ يَٰشُعَيْبُ', juz: 9),
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 89, text: 'قَدِ ٱفْتَرَيْنَا عَلَى ٱللَّهِ كَذِبًا إِنْ عُدْنَا فِى مِلَّتِكُم بَعْدَ إِذْ نَجَّىٰنَا ٱللَّهُ', juz: 9),
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 90, text: 'وَقَالَ ٱلْمَلَأُ ٱلَّذِينَ كَفَرُوا۟ مِن قَوْمِهِۦ لَئِنِ ٱتَّبَعْتُمْ شُعَيْبًا إِنَّكُمْ إِذًا لَّخَٰسِرُونَ', juz: 9),
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 91, text: 'فَأَخَذَتْهُمُ ٱلرَّجْفَةُ فَأَصْبَحُوا۟ فِى دَارِهِمْ جَٰثِمِينَ', juz: 9),
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 92, text: 'ٱلَّذِينَ كَذَّبُوا۟ شُعَيْبًا كَأَن لَّمْ يَغْنَوْا۟ فِيهَا ۚ ٱلَّذِينَ كَذَّبُوا۟ شُعَيْبًا كَانُوا۟ هُمُ ٱلْخَٰسِرِينَ', juz: 9),
  QuranVerse(surahNumber: 7, surahName: 'Al-A\'raf', verseNumber: 93, text: 'فَتَوَلَّىٰ عَنْهُمْ وَقَالَ يَٰقَوْمِ Lَقَدْ أَبْلَغْتُكُمْ رِسَٰلَٰتِ رَبِّى', juz: 9),

  // === JUZ 10 ===
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 41, text: 'وَٱعْلَمُوٓا۟ أَنَّمَا غَنِمْتُم مِّن شَىْءٍ فَأَنَّ لِلَّهِ خُمُسَهُۥ وَلِلرَّسُولِ', juz: 10),
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 42, text: 'إِذْ أَنتُم بِٱلْعُدْوَةِ ٱلدُّنْيَا وَهُم بِٱلْعُدْوَةِ ٱلْqُصْوَىٰ وَٱلرَّكْبُ أَسْفَلَ مِنكُمْ', juz: 10),
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 43, text: 'إِذْ يُرِيكَهُمُ ٱللَّهُ فِى مَنَامِكَ قَلِيلًا وَلَوْ أَرَىٰكُمْ كَثِيرًا لَّفَشِلْتُمْ', juz: 10),
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 44, text: 'وَإِذْ يُرِيكُمُوهُمْ إِذِ ٱلْتَقَيْتُمْ فِىٓ أَعْيُنِكُمْ قَلِيلًا وَيُقَلِّلُكُمْ فِىٓ أَعْيُنِهِمْ', juz: 10),
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 45, text: 'يَٰٓأَيُّهَا ٱلَّذِينَ ءَامَنُوٓa إِذَا لَقِيتُمْ فِئَةً فَٱثْبُتُوا۟ وَٱذْكُرُوا۟ ٱللَّهَ كَثِيرًا', juz: 10),
  QuranVerse(surahNumber: 8, surahName: 'Al-Anfal', verseNumber: 46, text: 'وَأَطِيعُوا۟ ٱللَّهَ وَرَسُولَهُۥ وَلَا تَنَٰزَعُوا۟ فَتَفْشَلُوا۟', juz: 10),

  // === JUZ 11 ===
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 93, text: 'إِنَّمَا ٱلسَّبِيلُ عَلَى ٱلَّذِينَ يَسْتَـْٔذِنُونَكَ وَهُمْ أَغْنِيَآءُ', juz: 11),
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 94, text: 'يَعْتَذِرُونَ إِلَيْكُمْ إِذَا رَجَعْتُمْ إِلَيْهِمْ قُل لَّا تَعْتَذِرُوا۟', juz: 11),
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 95, text: 'سَيَحْلِفُونَ بِٱللَّهِ لَكُمْ إِذَا ٱنقَلَبْتُمْ إِلَيْهِمْ Lِتُعْرِضُوا۟ عَنْهُمْ فَأَعْرِضُوا۟ عَنْهُمْ', juz: 11),
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 96, text: 'يَحْلِفُونَ لَكُمْ Lِتَرْضَوْا۟ عَنْهُمْ فَإِن تَرْضَوْa عَنْهُمْ فَإِنَّ ٱللَّهَ Lَا يَرْضَىٰ عَنِ ٱلْqَوْمِ ٱلْفَٰسِقِينَ', juz: 11),
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 97, text: 'ٱلْأَعْرَابُ أَشَدُّ كُفْرًا وَنِفَاقًا وَأَجْدَرُ أَلَّا يَعْلَمُوا۟ حُدُودَ مَآ أَنزَلَ ٱللَّهَ', juz: 11),
  QuranVerse(surahNumber: 9, surahName: 'At-Tawbah', verseNumber: 98, text: 'وَمِنَ ٱلْأَعْرَابِ مَن يَتَّخِذُ مَا يُنفِقُ مَغْرَمًا وَيَتَرَبَّصُ بِكُمُ ٱلدَّوَآئِرَ', juz: 11),

  // === JUZ 12 ===
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 6, text: 'وَما مِن دَابَّةٍ فِى ٱلْأَرْضِ إِلَّا عَلَى ٱللَّهِ رِزْقُهَا', juz: 12),
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 7, text: 'وَهُdoubleُ ٱلَّذِى خَلَقَ ٱالسَّمَٰوَٰتِ وَٱلْأَرْضَ فِى سِتَّةِ أَيَّامٍ', juz: 12),
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 8, text: 'وَلَئِنْ أَخَّرْنَا عَنْهُمُ ٱلْعَذَابَ إِلَىٰٓ أُمَّةٍ مَّعْدُودَةٍ لَّيَقُولُنَّ مَا يَحْبِسُهُۥ', juz: 12),
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 9, text: 'وَلَئِنْ أَذَقْنَا ٱلْإِنسَٰنَ مِنَّا رَحْمَةً ثُمَّ نَزَعْنَٰهَا مِنْهُ إِنَّهُۥ لَيَـُٔوسٌ كَفُورٌ', juz: 12),
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 10, text: 'وَلَئِنْ أَذَقْنَٰهُ نَعْمَآءَ بَعْدَ ضَرَّآءَ مَسَّتْهُ لَيَقُولَنَّ ذَهَبَ ٱلسَّيِّـَٔاتُ', juz: 12),
  QuranVerse(surahNumber: 11, surahName: 'Hud', verseNumber: 11, text: 'إِلَّا ٱلَّذِينَ صَبَرُوا۟ وَعَمِلُوا۟ ٱلصَّٰلِحَٰتِ أُو۟لَٰٓئِكَ لَهُم مَّغْفِرَةٌ', juz: 12),

  // === JUZ 13 ===
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 53, text: 'وَمَآ أُبَرِّئُ نَفْسِىٓ إِنَّ ٱلنَّفْسَ Lأَمَّارَةٌۢ بِٱلسُّوءِ إِلَّا مَا رَحِمَ رَبِّى', juz: 13),
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 54, text: 'وَqَالَ ٱلْمَلِكُ ٱئْتُونِى بِهِۦٓ أَسْتَخْلِصْهُ لِنَفْسِى', juz: 13),
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 55, text: 'قَالَ ٱجْعَلْنِى عَلَىٰ خَزَآئِنِ ٱلْأَرْضِ إِنِّى حَفِيظٌ عَلِيمٌ', juz: 13),
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 56, text: 'وَكَذَٰلِكَ مَكَّنَّا لِيُوسُفَ فِى ٱلْأَرْضِ يَتَبَّوَّأُ مِنْهَا حَيْثُ يَشَآءُ', juz: 13),
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 57, text: 'وَلَأَجْرُ ٱلْءَاخِرَةِ خَيْرٌ Lِّلَّذِينَ ءَامَنُوا۟ وَكَانُوا۟ يَتَّقُونَ', juz: 13),
  QuranVerse(surahNumber: 12, surahName: 'Yusuf', verseNumber: 58, text: 'وَجَآءَ إِخْوَةُ يُوسُفَ فَدَخَلُوا۟ عَلَيْهِ فَعَرَفَهُمْ وَهُمْ لَهُۥ مُنكِرُونَ', juz: 13),

  // === JUZ 14 ===
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 1, text: 'الر تِلْكَ ءَايَٰتُ ٱلْكِتَٰبِ وَقُرْءَانٍ مُّبِينٍ', juz: 14),
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 2, text: 'رُّبَمَا يَوَدُّ ٱلَّذِينَ كَفَرُوا۟ لَوْ كَانُوا۟ مُسْلِمِينَ', juz: 14),
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 3, text: 'ذَرْهُمْ يَأْكُلُوا۟ وَيَتَمَتَّعُوا۟ وَيُلْهِهِمُ ٱلْأَمَلُ فَسَوْفَ يَعْلَمُونَ', juz: 14),
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 4, text: 'وَمَآ أَهْلَكْنَا مِن قَرْيَةٍ إِلَّا وَلَهَا كِتَابٌ مَّعْلُومٌ', juz: 14),
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 5, text: 'مَّا تَسْبِقُ مِنْ أُمَّةٍ أَجَلَهَا وَمَا يَسْتَـْٔخِرُونَ', juz: 14),
  QuranVerse(surahNumber: 15, surahName: 'Al-Hijr', verseNumber: 6, text: 'وَقَالُوا۟ يَٰٓأَيُّهَا ٱلَّذِى نُزِّلَ عَلَيْهِ ٱلذِّكْرُ إِنَّكَ لَمَجْنُونٌ', juz: 14),

  // === JUZ 15 ===
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 1, text: 'سُبْحَٰنَ ٱلَّذِىٓ أَسْرَىٰ بِعَبْدِهِۦ لَيْلًا مِّنَ ٱلْمَسْجِدِ ٱلْحَرَامِ إِلَى ٱلْمَسْجِدِ ٱلْأَقْصَا', juz: 15),
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 2, text: 'وَءَاتَيْنَا مُوسَى ٱلْكِتَٰبَ وَجَعَلْنَٰهُ هُدًى لِّبَنِىٓ إِسْرَٰٓءِيلَ', juz: 15),
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 3, text: 'ذُرِّيَّةَ مَنْ حَمَلْنَا مَعَ نُوحٍ إِنَّهُۥ كَانَ عَبْدًا شَكُورًا', juz: 15),
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 4, text: 'وَقَضَيْنَآ إِلَىٰ بَنِىٓ إِسْرَٰٓءِيلَ فِى ٱلْكِtَٰبِ لَتُفْسِدُنَّ فِى ٱلْأَرْضِ مَرَّتَيْنِ', juz: 15),
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 5, text: 'فَإِذَا جَآءَ وَعْدُ أُولَىٰهُمَا بَعَثْنَا عَلَيْكُمْ عِبَادًا لَّنَآ أُو۟لِى بَأْسٍ شَدِيدٍ', juz: 15),
  QuranVerse(surahNumber: 17, surahName: 'Al-Isra\'', verseNumber: 6, text: 'ثُمَّ رَدَدْنَا لَكُمُ ٱلْكَرَّةَ عَلَيْهِمْ وَأَمْدَدْنَٰكُم بِأَمْوَٰلٍ وَبَنِينَ', juz: 15),

  // === JUZ 16 ===
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 75, text: 'قَالَ أَلَمْ أَقُل لَّكَ إِنَّكَ لَن تَسْتَطِيعَ مَعِىَ صَبْرًا', juz: 16),
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 76, text: 'قَالَ إِن سَأَلْتُكَ عَن شَىْءٍۭ بَعْدَهَا فَلَا تُصَٰحِبْنِى', juz: 16),
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 77, text: 'فَٱنتَلَقَا حَتَّىٰٓ إِذَآ أَتَيَآ أَهْلَ قَرْيَةٍ ٱسْتَطْعَمَآ أَهْلَهَا فَأَبَوْا۟ أَن يُضَيِّفُوهُمَا', juz: 16),
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 78, text: 'قَالَ هَٰذَا فِرَاقُ بَيْنِى وَبَيْنِكَ سَأُنَبِّئُكَ بِتَأْوِيلِ مَا لَمْ تَسْتَطِع عَّلَيْهِ صَبْرًا', juz: 16),
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 79, text: 'أَمَّا ٱلسَّفِينَةُ فَكَانَتْ لِمَسَٰكِينَ يَعْمَلُونَ فِى ٱلْبَحْرِ', juz: 16),
  QuranVerse(surahNumber: 18, surahName: 'Al-Kahf', verseNumber: 80, text: 'وَأَمَّا ٱلْغُلَٰمُ فَكَانَ أَبَوَاهُ مُؤْمِنَيْنِ فَخَشِينَآ أَن يُرْهِقَهُمَا طُغْيَٰنًا', juz: 16),

  // === JUZ 17 ===
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 1, text: 'ٱقْتَرَبَ لِلنَّاسِ حِسَابُهُمْ وَهُمْ فِى غَفْلَةٍ مُّعْرِضُونَ', juz: 17),
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 2, text: 'مَا يَأْتِيهِم مِّن ذِكْرٍ مِّن رَّبِّهِم مُّحْدَثٍ إِلَّا ٱسْتَمَعُوهُ وَهُمْ يَلْعَبُونَ', juz: 17),
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 3, text: 'لَاهِيَةً قُلُوبُهُمْ وَأَسَرُّوا۟ ٱلنَّجْوَى ٱلَّذِينَ ظَلَمُوا۟ هَلْ هَٰذَآ إِلَّا بَشَرٌ مِّثْلُكُمْ', juz: 17),
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 4, text: 'قَالَ رَبِّى يَعْلَمُ ٱلْقَوْلَ فِى ٱالسَّمَآءِ وَٱلْأَرْضِ وَهُوَ ٱلسَّمِيعُ ٱلْعَلِيمُ', juz: 17),
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 5, text: 'بَلْ قَالُوٓا۟ أَضْغَٰثُ أَحْلَٰمٍ بَلِ ٱفْتَرَىٰهُ بَلْ هُوَ شَاعِرٌ', juz: 17),
  QuranVerse(surahNumber: 21, surahName: 'Al-Anbiya\'', verseNumber: 6, text: 'مَآ ءَامَنَتْ qَبْلَهُم مِّن qَرْيَةٍ أَهْلَكْنَٰهَآ ۖ أَفَهُمْ يُؤْمِنُونَ', juz: 17),

  // === JUZ 18 ===
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 1, text: 'قَدْ أَفْلَحَ ٱلْمُؤْمِنُونَ', juz: 18),
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 2, text: 'ٱلَّذِينَ هُمْ فِى صَلَاتِهِمْ خَٰشِعُونَ', juz: 18),
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 3, text: 'وَٱلَّذِينَ هُمْ عَنِ ٱللَّغْوِ مُعْرِضُونَ', juz: 18),
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 4, text: 'وَٱلَّذِينَ هُمْ لِلزَّكَٰوةِ فَٰعِلُونَ', juz: 18),
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 5, text: 'وَٱلَّذِينَ هُمْ لِفُرُوجِهِمْ حَٰفِظُونَ', juz: 18),
  QuranVerse(surahNumber: 23, surahName: 'Al-Mu\'minun', verseNumber: 6, text: 'إِلَّا عَلَىٰٓ أَزْوَٰجِهِمْ أَوْ مَا مَلَكَتْ أَيْمَٰنُهُمْ فَإِنَّهُمْ غَيْرُ مَلُومِينَ', juz: 18),

  // === JUZ 19 ===
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 21, text: 'وَقَالَ ٱلَّذِينَ لَا يَرْجُونَ لِقَآءَنَا لَوْلَآ أُنزِلَ عَلَيْنَا ٱلْمَلَٰٓئِكَةُ أَوْ نَرَىٰ رَبَّنَا', juz: 19),
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 22, text: 'يَوْمَ يَرَوْنَ ٱلْمَلَٰٓئِكَةَ لَا بُشْرَىٰ يَوْمَئِذٍ لِّلْمُجْرِمِينَ', juz: 19),
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 23, text: 'وَقَدِمْنَآ إِلَىٰ مَا عَمِلُوا۟ مِنْ عَمَلٍ فَجَعَلْنَٰهُ هَبَآءً مَّنثُورًا', juz: 19),
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 24, text: 'أَصْحَٰبُ ٱلْجَنَّةِ يَوْمَئِذٍ خَيْرٌ مُّسْتَقَرًّا وَأَحْسَنُ مَقِيلًا', juz: 19),
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 25, text: 'وَيَوْمَ تَشَقَّقُ ٱلسَّمَآءُ بِٱلْغَمَٰمِ وَنُزِّلَ ٱلْمَلَٰٓئِكَةُ تَنزِيلًا', juz: 19),
  QuranVerse(surahNumber: 25, surahName: 'Al-Furqan', verseNumber: 26, text: 'ٱلْمُلْكُ يَوْمَئِذٍ ٱلْحَقُّ لِلرَّحْمَٰنِ ۚ وَكَانَ يَوْمًا عَلَى ٱلْكَٰفِرِينَ عَسِيرًا', juz: 19),

  // === JUZ 20 ===
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 56, text: 'فَمَا كَانَ جَوَابَ قَوْمِهِۦٓ إِلَّآ أَن قَالُوٓا۟ أَخْرِجُوٓا۟ ءَالَ لُوطٍ مِّن قَرْيَتِكُمْ', juz: 20),
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 57, text: 'فَأَنجَيْنَٰهُ وَأَهْلَهُۥٓ إِلَّا ٱمْرَأَتَهُۥ قَدَّرْنَٰهَا مِنَ ٱلْغَٰبِرِينَ', juz: 20),
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 58, text: 'وَأَمْطَرْنَا عَلَيْهِم مَّطَرًا فَسَآءَ مَطَرُ ٱلْمُنذَرِينَ', juz: 20),
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 59, text: 'قُلِ ٱلْحَمْدُ لِلَّهِ وَسَلَٰمٌ عَلَىٰ عِبَادِهِ ٱلَّذِينَ ٱصْطَفَىٰ', juz: 20),
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 60, text: 'أَمَّنْ خَلَقَ ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ وَأَنزَلَ لَكُم مِّنَ ٱلسَّمَآءِ مَآءً', juz: 20),
  QuranVerse(surahNumber: 27, surahName: 'An-Naml', verseNumber: 61, text: 'أَمَّن جَعَلَ ٱلْأَرْضَ قَرَارًا وَجَعَلَ خِلَٰلَهَآ أَنْهَٰرًا', juz: 20),

  // === JUZ 21 ===
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 46, text: 'وَلَا تُجَٰدِلُوٓا۟ أَهْلَ ٱلْكِتَٰبِ إِلَّا بِٱلَّتِى هِىَ أَحْسَنُ إِلَّا ٱلَّذِينَ ظَلَمُوا۟ مِنْهُمْ', juz: 21),
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 47, text: 'وَكَذَٰلِكَ أَنزَلْنَآ إِلَيْكَ ٱلْكِتَٰبَ فَٱلَّذِينَ ءَاتَيْنَٰهُمُ ٱلْكِتَٰبَ يُؤْمِنُونَ بِهِۦ', juz: 21),
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 48, text: 'وَمَا كُنتَ تَتْلُوا۟ مِن قَبْلِهِۦ مِن كِتَٰبٍ وَلَا تَخُطُّهُۥ بِيَمِينِكَ', juz: 21),
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 49, text: 'بَلْ هُوَ ءَايَٰتٌۢ بَيِّنَٰتٌ فِى صُدُورِ ٱلَّذِينَ أُوتُوا۟ ٱلْعِلْمَ', juz: 21),
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 50, text: 'وَقَالُوا۟ لَوْلَآ أُنزِلَ عَلَيْهِ ءَايَٰتٌ مِّن رَّبِّهِۦ ۖ قُلْ إِنَّمَا ٱلْءَايَٰتُ عِندَ ٱللَّهِ', juz: 21),
  QuranVerse(surahNumber: 29, surahName: 'Al-\'Ankabut', verseNumber: 51, text: 'أَوَلَمْ يَكْفِهِمْ أَنَّآ أَنزَلْنَا عَلَيْكَ ٱلْكِتَٰبَ يُتْلَىٰ عَلَيْهِمْ', juz: 21),

  // === JUZ 22 ===
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 31, text: 'وَمَن يَقْنُتْ مِنكُنَّ لِلَّهِ وَرَسُولِهِۦ وَتَعْمَلْ صَٰلِحًا نُّؤْتِهَآ أَجْرَهَا مَرَّتَيْنِ', juz: 22),
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 32, text: 'يَٰنِسَآءَ ٱلنَّبِىِّ لَسْتُنَّ كَأَحَدٍ مِّنَ ٱلنِّسَآءِ إِنِ ٱتَّقَيْتُنَّ', juz: 22),
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 33, text: 'وَقَرْنَ فِى بُيُوتِكُنَّ وَلَا تَبَرَّجْنَ تَبَرُّجَ ٱلْجَٰهِلِيَّةِ ٱلْأُولَىٰ', juz: 22),
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 34, text: 'وَٱذْكُرْنَ مَا يُtْلَىٰ فِى بُيُوتِكُنَّ مِنْ ءَايَٰتِ ٱللَّهِ وَٱلْحِكْمَةِ', juz: 22),
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 35, text: 'إِنَّ ٱلْمُسْلِمِينَ وَٱلْمُسْلِمَٰتِ وَٱلْمُؤْمِنِينَ وَٱلْمُؤْمِنَٰتِ وَٱلْقَٰنِتِينَ', juz: 22),
  QuranVerse(surahNumber: 33, surahName: 'Al-Ahzab', verseNumber: 36, text: 'وَمَا كَانَ لِمُؤْمِنٍ وَلَا مُؤْمِنَةٍ إِذَا قَضَى ٱللَّهُ وَرَسُولُهُۥٓ أَمْرًا', juz: 22),

  // === JUZ 23 ===
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 28, text: 'وَمَآ أَنزَلْنَا عَلَىٰ قَوْمِهِۦ مِنۢ بَعْدِهِۦ مِن جُندٍ مِّنَ ٱلسَّمَآءِ', juz: 23),
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 29, text: 'إِن كَانَتْ إِلَّا صَيْحَةً وَٰحِدَةً فَإِذَا هُمْ خَٰمِدُونَ', juz: 23),
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 30, text: 'يَٰحَسْرَةً عَلَى ٱلْعِبَادِ مَا يَأْتِيهِم مِّن رَّسُولٍ إِلَّا كَانُوا۟ بِهِۦ يَسْتَهْزِءُونَ', juz: 23),
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 31, text: 'أَلَمْ يَرَوْا۟ كَمْ أَهْلَكْنَا قَبْلَهُم مِّنَ ٱلْقُرُونِ أَنَّهُمْ إِلَيْهِمْ لَا يَرْجِعُونَ', juz: 23),
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 32, text: 'وَإِن كُلٌّ لَّمَّا جَمِيعٌ لَّدَيْنَا مُحْضَرُونَ', juz: 23),
  QuranVerse(surahNumber: 36, surahName: 'Ya-Sin', verseNumber: 33, text: 'وَءَايَةٌ لَّهُمُ ٱلْأَرْضُ ٱلْمَيْتَةُ أَحْيَيْنَٰهَa وَأَخْرَجْنَا مِنْهَا حَبًّا', juz: 23),

  // === JUZ 24 ===
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 32, text: 'فَمَنْ أَظْلَمُ مِمَّن كَذَبَ عَلَى ٱللَّهِ وَكَذَّبَ بِٱلصِّدْقِ إِذْ جَآءَهُۥ', juz: 24),
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 33, text: 'وَٱلَّذِى جَآءَ بِٱلصِّدْقِ وَصَدَّقَ بِهِۦٓ أُو۟لَٰٓئِكَ هُمُ ٱلْمُتَّقُونَ', juz: 24),
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 34, text: 'لَهُم مَّا يَشَآءُونَ عِندَ رَبِّهِمْ ذَٰلِكَ جَزَآءُ ٱلْمُحْسِنِينَ', juz: 24),
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 35, text: 'لِيُكَفِّرَ ٱللَّهُ عَنْهُمْ أَسْوَأَ ٱلَّذِى عَمِلُوا۟ وَيَجْزِيَهُم أّجْرَهُم', juz: 24),
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 36, text: 'أَلَيْسَ ٱللَّهُ بِكَافٍ عَبْدَهُۥ ۖ وَيُخَوِّفُونَكَ بِٱلَّذِينَ مِن دُونِهِۦ', juz: 24),
  QuranVerse(surahNumber: 39, surahName: 'Az-Zumar', verseNumber: 37, text: 'وَمَن يَهْدِ ٱللَّهُ فَمَا لَهُۥ مِن مُّضِلٍّ ۗ أَلَيْسَ ٱللَّهُ بِعَزِيزٍ ذِى ٱنتِقَامٍ', juz: 24),

  // === JUZ 25 ===
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 47, text: 'إِلَيْهِ يُرَدُّ عِلْمُ ٱالسَّاعَةِ وَمَا تَخْرُجُ مِن ثَمَرَٰتٍ مِّنْ أَكْمَامِهَا', juz: 25),
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 48, text: 'وَضَلَّ عَنْهُم مَّا كَانُوا۟ يَدْعُونَ مِن قَبْلُ وَظَنُّوا۟ مَا لَهُم مِّن مَّحِيصٍ', juz: 25),
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 49, text: 'لَّا يَسْـَٔمُ ٱلْإِنسَٰنُ مِن دُعَآءِ ٱلْخَيْرِ وَإِن مَّسَّهُ ٱلشَّرُّ فَيَـُٔوسٌ قَنُوطٌ', juz: 25),
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 50, text: 'وَلَئِنْ أَذَقْنَٰهُ رَحْمَةً مِّنَّا مِنۢ بَعْدِ ضَرَّآءَ مَسَّتْهُ لَيَقُولَنَّ هَٰذَا لِى', juz: 25),
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 51, text: 'وَإِذَآ أَنْعَمْنَا عَلَى ٱلْإِنسَٰنِ أَعْرَضَ وَنَـَٔا بِجَانِبِهِۦ', juz: 25),
  QuranVerse(surahNumber: 41, surahName: 'Fussilat', verseNumber: 52, text: 'قُلْ أَرَءَيْتُمْ إِن كَانَ مِنْ عِندِ ٱللَّهِ ثُمَّ كَفَرْتُم بِهِۦٓ', juz: 25),

  // === JUZ 26 ===
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 1, text: 'حم', juz: 26),
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 2, text: 'تَنزِيلُ ٱلْكِtَٰبِ مِنَ ٱللَّهِ ٱلْعَزِيزِ ٱلْحَكِيمِ', juz: 26),
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 3, text: 'مَا خَلَقْنَا ٱلسَّمَٰوَٰتِ وَٱلْأَرْضَ وَمَا بَيْنَهُمَآ إِلَّا بِٱلْحَقِّ وَأَجَلٍ مُّسَمًّى', juz: 26),
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 4, text: 'قُلْ أَرَءَيْتُم مَّا تَدْعُونَ مِن دُونِ ٱللَّهِ أَرُونِى مَاذَا خَلَقُوا۟ مِنَ ٱلْأَرْضِ', juz: 26),
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 5, text: 'وَمَنْ أَضَلُّ مِمَّن يَدْعُوا۟ مِن دُونِ ٱللَّهِ مَن لَّا يَسْتَجِيبُ لَهُۥٓ', juz: 26),
  QuranVerse(surahNumber: 46, surahName: 'Al-Ahqaf', verseNumber: 6, text: 'وَإِذَا حُشِرَ ٱلنَّاسُ كَانُوا۟ لَهُمْ أَعْدَآءً وَكَانُوا۟ بِعِبَادَتِهِمْ كَٰفِرِينَ', juz: 26),

  // === JUZ 27 ===
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 31, text: 'قَالَ فَمَا خَطْبُكُمْ أَيُّهَا ٱلْمُرْسَلُونَ', juz: 27),
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 32, text: 'قَالُوٓا۟ إِنَّآ أُرْسِلْنَآ إِلَىٰ قَوْمٍ مُّجْرِمِينَ', juz: 27),
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 33, text: 'لِنُرْسِلَ عَلَيْهِمْ حِجَارَةً مِّن طِينٍ', juz: 27),
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 34, text: 'مُّسَوَّمَةً عِندَ رَبِّكَ لِلْمُسْرِفِينَ', juz: 27),
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 35, text: 'فَأَخْرَجْنَا مَن كَانَ فِيهَا مِنَ ٱلْمُؤْمِنِينَ', juz: 27),
  QuranVerse(surahNumber: 51, surahName: 'Adh-Dhariyat', verseNumber: 36, text: 'فَمَا وَجَدْنَا فِيهَا غَيْرَ بَيْتٍ مِّنَ ٱلْمُسْلِمِينَ', juz: 27),

  // === JUZ 28 ===
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 1, text: 'قَدْ سَمِعَ ٱللَّهُ قَوْلَ ٱلَّتِى تُجَٰدِلُكَ فِى زَوْجِهَا وَتَشْتَكِىٓ إِلَى ٱللَّهِ', juz: 28),
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 2, text: 'ٱلَّذِينَ يُظَٰهِرُونَ مِنكُم مِّن نِّسَآئِهِم مَّا هُنَّ أُمَّهَٰتِهِم', juz: 28),
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 3, text: 'وَٱلَّذِينَ يُظَٰهِرُونَ مِن نِّسَآئِهِم ثُمَّ يَعُودُونَ لِمَا قَالُوا۟ فَتَحْرِيرُ رَقَبَةٍ', juz: 28),
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 4, text: 'فَمَن لَّمْ يَجِدْ فَصِيَامُ شَهْرَيْنِ مُتَتَابِعَيْنِ مِن قَبْلِ أَن يَتَمَآسَّا', juz: 28),
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 5, text: 'إِنَّ ٱلَّذِينَ يُحَآدُّونَ ٱللَّهَ وَرَسُولَهُۥ كُبِtُوا۟ كَمَا كُبِتَ ٱلَّذِينَ', juz: 28),
  QuranVerse(surahNumber: 58, surahName: 'Al-Mujadilah', verseNumber: 6, text: 'يَوْمَ يَبْعَثُهُمُ ٱللَّهُ جَمِيعًا فَيُنَبِّئُهُم بِمَا عَمِلُوا۟', juz: 28),

  // === JUZ 29 ===
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 1, text: 'تَبَٰرَكَ ٱلَّذِى بِيَدِهِ ٱلْمُلْكُ وَهُوَ عَلَىٰ كُلِّ شَىْءٍ قَدِيرٌ', juz: 29),
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 2, text: 'ٱلَّذِى خَلَقَ ٱلْمَوْتَ وَٱلْحَيَٰوةَ لِيَبْلُوَكُمْ أَيُّكُمْ أَحْسَنُ عَمَلًا', juz: 29),
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 3, text: 'ٱلَّذِى خَلَقَ سَبْعَ سَمَٰوَٰtٍ طِبَاقًا مَّا تَرَىٰ فِى خَلْقِ ٱلرَّحْمَٰنِ مِن تَفَٰوُتٍ', juz: 29),
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 4, text: 'ثُمَّ ٱرْجِعِ ٱلْبَصَرَ كَرَّتَيْنِ يَنقَلِبْ إِلَيْكَ ٱلْبَصَرُ خَاسِئًا وَهُوَ حَسِيرٌ', juz: 29),
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 5, text: 'وَلَقَدْ زَيَّنَّا ٱلسَّمَآءَ ٱلدُّنْيَا بِمَصَٰبِيحَ وَجَعَلْنَٰهَا رُجُومًا', juz: 29),
  QuranVerse(surahNumber: 67, surahName: 'Al-Mulk', verseNumber: 6, text: 'وَلِلَّذِينَ كَفَرُوا۟ بِرَبِّهِمْ عَذَابُ جَهَنَّمَ ۖ وَبِئْسَ ٱلْمَصِيرِ', juz: 29),

  // === JUZ 30 ===
  // Al-Asr
  QuranVerse(surahNumber: 103, surahName: 'Al-\'Asr', verseNumber: 1, text: 'وَالْعَصْرِ', juz: 30),
  QuranVerse(surahNumber: 103, surahName: 'Al-\'Asr', verseNumber: 2, text: 'إِنَّ الْإِنْسَانَ لَفِي خُسْرٍ', juz: 30),
  QuranVerse(surahNumber: 103, surahName: 'Al-\'Asr', verseNumber: 3, text: 'إِلَّا الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ وَتَوَاصَوْا بِالْحَقِّ وَتَوَاصَوْا بِالصَّبْرِ', juz: 30),

  // Quraysh
  QuranVerse(surahNumber: 106, surahName: 'Quraysh', verseNumber: 1, text: 'لِإِيلَافِ قُرَيْشٍ', juz: 30),
  QuranVerse(surahNumber: 106, surahName: 'Quraysh', verseNumber: 2, text: 'إِيلَافِهِمْ رِحْلَةَ الشِّتَاءِ وَالصَّيْفِ', juz: 30),
  QuranVerse(surahNumber: 106, surahName: 'Quraysh', verseNumber: 3, text: 'فَلْيَعْبُدُوا رَبَّ هَٰذَا الْبَيْتِ', juz: 30),
  QuranVerse(surahNumber: 106, surahName: 'Quraysh', verseNumber: 4, text: 'الَّذِي أَطْعَمَهُمْ مِنْ جُوعٍ وَآمَنَهُمْ مِنْ خَوْفٍ', juz: 30),

  // Al-Kautsar
  QuranVerse(surahNumber: 108, surahName: 'Al-Kautsar', verseNumber: 1, text: 'إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ', juz: 30),
  QuranVerse(surahNumber: 108, surahName: 'Al-Kautsar', verseNumber: 2, text: 'فَصَلِّ لِرَبِّكَ وَانْحَرْ', juz: 30),
  QuranVerse(surahNumber: 108, surahName: 'Al-Kautsar', verseNumber: 3, text: 'إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ', juz: 30),

  // An-Nasr
  QuranVerse(surahNumber: 110, surahName: 'An-Nasr', verseNumber: 1, text: 'إِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ', juz: 30),
  QuranVerse(surahNumber: 110, surahName: 'An-Nasr', verseNumber: 2, text: 'وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا', juz: 30),
  QuranVerse(surahNumber: 110, surahName: 'An-Nasr', verseNumber: 3, text: 'فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا', juz: 30),

  // Al-Ikhlas
  QuranVerse(surahNumber: 112, surahName: 'Al-Ikhlas', verseNumber: 1, text: 'قُلْ هُوَ ٱللَّهُ أَحَدٌ', juz: 30),
  QuranVerse(surahNumber: 112, surahName: 'Al-Ikhlas', verseNumber: 2, text: 'ٱللَّهُ ٱلصَّمَدُ', juz: 30),
  QuranVerse(surahNumber: 112, surahName: 'Al-Ikhlas', verseNumber: 3, text: 'لَمْ يَلِدْ وَلَمْ يُولَدْ', juz: 30),
  QuranVerse(surahNumber: 112, surahName: 'Al-Ikhlas', verseNumber: 4, text: 'وَلَمْ يَكُن لَّهُۥ كُفُوًا أَحَدٌ', juz: 30),

  // Al-Falaq
  QuranVerse(surahNumber: 113, surahName: 'Al-Falaq', verseNumber: 1, text: 'قُلْ أَعُوذُ بِرَبِّ ٱلْفَلَقِ', juz: 30),
  QuranVerse(surahNumber: 113, surahName: 'Al-Falaq', verseNumber: 2, text: 'مِن شَرِّ مَا خَلَقَ', juz: 30),
  QuranVerse(surahNumber: 113, surahName: 'Al-Falaq', verseNumber: 3, text: 'وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ', juz: 30),
  QuranVerse(surahNumber: 113, surahName: 'Al-Falaq', verseNumber: 4, text: 'وَمِن شَرِّ ٱلنَّفَّٰثَٰتِ فِي ٱلْعُقَدِ', juz: 30),
  QuranVerse(surahNumber: 113, surahName: 'Al-Falaq', verseNumber: 5, text: 'وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ', juz: 30),

  // An-Nas
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 1, text: 'قُلْ أَعُوذُ بِرَبِّ ٱلنَّاسِ', juz: 30),
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 2, text: 'مَلِكِ ٱلنَّاسِ', juz: 30),
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 3, text: 'إِلَّا هِ ٱلنَّاسِ', juz: 30),
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 4, text: 'مِن شَرِّ ٱلْوَسْوَاسِ ٱلْخَنَّاسِ', juz: 30),
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 5, text: 'ٱلَّذِي يُوَسْوِسُ فِي صُدُورِ ٱلنَّاسِ', juz: 30),
  QuranVerse(surahNumber: 114, surahName: 'An-Nas', verseNumber: 6, text: 'مِنَ ٱلْجِنَّةِ وَٱلنَّاسِ', juz: 30),
];

// Helper to get list of distinct surah names in the database
List<String> getSurahNamesList() {
  return quranVersesDb.map((v) => v.surahName).toSet().toList();
}
