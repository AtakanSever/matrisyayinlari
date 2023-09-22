class Soru {
  final int id;
  final String kitapAdi;
  final String konuAdi;
  final String testAdi;
  final String soruSayisi;
  final String url;
  final String testKodu;

  Soru(
      {required this.id,
      required this.kitapAdi,
      required this.konuAdi,
      required this.testAdi,
      required this.soruSayisi,
      required this.url,
      required this.testKodu});
}

class Detay {
  final int id;
  final String konuAdi;
  final String testAdi;
  final List<String> soruSayisi;
  final String url;
  final String testKodu;

  Detay(
      {required this.id,
      required this.konuAdi,
      required this.testAdi,
      required this.soruSayisi,
      required this.url,
      required this.testKodu});

}
