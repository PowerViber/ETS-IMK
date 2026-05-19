class JuzDocument {
  const JuzDocument({
    required this.number,
    required this.mushafStartPage,
    required this.mushafEndPage,
  });

  final int number;
  final int mushafStartPage;
  final int mushafEndPage;

  String get title => 'Juz $number';

  String get pageRangeLabel => 'Halaman mushaf $mushafStartPage-$mushafEndPage';

  String get assetPath =>
      'surah-quran/juz/juz-${number.toString().padLeft(2, '0')}.pdf';

  int get totalPages => mushafEndPage - mushafStartPage + 1;

  int get sourcePdfStartPage => mushafStartPage + 3;

  int get sourcePdfEndPage => mushafEndPage + 3;

  QuranPdfSource get remoteSource =>
      QuranPdfSource.forSourcePage(sourcePdfStartPage);
}

class QuranPdfSource {
  const QuranPdfSource({
    required this.partNumber,
    required this.startPage,
    required this.endPage,
    required this.rawUrl,
    this.initialSourcePage,
  });

  final int partNumber;
  final int startPage;
  final int endPage;
  final String rawUrl;
  final int? initialSourcePage;

  int pageInPart(int sourcePage) => sourcePage - startPage + 1;

  int get initialPageInPart =>
      pageInPart(sourcePageClamp(initialSourcePage ?? startPage));

  String get viewerUrl {
    return '$rawUrl#toolbar=0&navpanes=0&scrollbar=0&page=$initialPageInPart&view=FitH';
  }

  int sourcePageClamp(int sourcePage) {
    if (sourcePage < startPage) {
      return startPage;
    }
    if (sourcePage > endPage) {
      return endPage;
    }
    return sourcePage;
  }

  static QuranPdfSource forSourcePage(int sourcePage) {
    for (final source in quranPdfSources) {
      if (sourcePage >= source.startPage && sourcePage <= source.endPage) {
        return QuranPdfSource(
          partNumber: source.partNumber,
          startPage: source.startPage,
          endPage: source.endPage,
          rawUrl: source.rawUrl,
          initialSourcePage: sourcePage,
        );
      }
    }
    return quranPdfSources.last;
  }
}

const String _supabaseQuranBaseUrl =
    'https://dsmabwvgqwybuuieteba.supabase.co/storage/v1/object/public/Alquran/Alquran';

const List<QuranPdfSource> quranPdfSources = [
  QuranPdfSource(
    partNumber: 1,
    startPage: 1,
    endPage: 79,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_1.pdf',
  ),
  QuranPdfSource(
    partNumber: 2,
    startPage: 80,
    endPage: 157,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_2.pdf',
  ),
  QuranPdfSource(
    partNumber: 3,
    startPage: 158,
    endPage: 235,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_3.pdf',
  ),
  QuranPdfSource(
    partNumber: 4,
    startPage: 236,
    endPage: 313,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_4.pdf',
  ),
  QuranPdfSource(
    partNumber: 5,
    startPage: 314,
    endPage: 391,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_5.pdf',
  ),
  QuranPdfSource(
    partNumber: 6,
    startPage: 392,
    endPage: 469,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_6.pdf',
  ),
  QuranPdfSource(
    partNumber: 7,
    startPage: 470,
    endPage: 547,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_7.pdf',
  ),
  QuranPdfSource(
    partNumber: 8,
    startPage: 548,
    endPage: 625,
    rawUrl: '$_supabaseQuranBaseUrl/alquran_8.pdf',
  ),
];

const List<JuzDocument> juzDocuments = [
  JuzDocument(number: 1, mushafStartPage: 1, mushafEndPage: 21),
  JuzDocument(number: 2, mushafStartPage: 22, mushafEndPage: 41),
  JuzDocument(number: 3, mushafStartPage: 42, mushafEndPage: 61),
  JuzDocument(number: 4, mushafStartPage: 62, mushafEndPage: 81),
  JuzDocument(number: 5, mushafStartPage: 82, mushafEndPage: 101),
  JuzDocument(number: 6, mushafStartPage: 102, mushafEndPage: 121),
  JuzDocument(number: 7, mushafStartPage: 122, mushafEndPage: 141),
  JuzDocument(number: 8, mushafStartPage: 142, mushafEndPage: 161),
  JuzDocument(number: 9, mushafStartPage: 162, mushafEndPage: 181),
  JuzDocument(number: 10, mushafStartPage: 182, mushafEndPage: 201),
  JuzDocument(number: 11, mushafStartPage: 202, mushafEndPage: 221),
  JuzDocument(number: 12, mushafStartPage: 222, mushafEndPage: 241),
  JuzDocument(number: 13, mushafStartPage: 242, mushafEndPage: 261),
  JuzDocument(number: 14, mushafStartPage: 262, mushafEndPage: 281),
  JuzDocument(number: 15, mushafStartPage: 282, mushafEndPage: 301),
  JuzDocument(number: 16, mushafStartPage: 302, mushafEndPage: 321),
  JuzDocument(number: 17, mushafStartPage: 322, mushafEndPage: 341),
  JuzDocument(number: 18, mushafStartPage: 342, mushafEndPage: 361),
  JuzDocument(number: 19, mushafStartPage: 362, mushafEndPage: 381),
  JuzDocument(number: 20, mushafStartPage: 382, mushafEndPage: 401),
  JuzDocument(number: 21, mushafStartPage: 402, mushafEndPage: 421),
  JuzDocument(number: 22, mushafStartPage: 422, mushafEndPage: 441),
  JuzDocument(number: 23, mushafStartPage: 442, mushafEndPage: 461),
  JuzDocument(number: 24, mushafStartPage: 462, mushafEndPage: 481),
  JuzDocument(number: 25, mushafStartPage: 482, mushafEndPage: 501),
  JuzDocument(number: 26, mushafStartPage: 502, mushafEndPage: 521),
  JuzDocument(number: 27, mushafStartPage: 522, mushafEndPage: 541),
  JuzDocument(number: 28, mushafStartPage: 542, mushafEndPage: 561),
  JuzDocument(number: 29, mushafStartPage: 562, mushafEndPage: 581),
  JuzDocument(number: 30, mushafStartPage: 582, mushafEndPage: 604),
];

JuzDocument? findJuzDocument(int number) {
  for (final document in juzDocuments) {
    if (document.number == number) {
      return document;
    }
  }
  return null;
}
