import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart'; 
import 'veri_kaynagi.dart';
import 'gramer_kaynagi.dart';
import 'cumle_motoru.dart';

void main() {
  runApp(const LingoDeutschApp());
}

List<Map<String, dynamic>> tekrarEdileceklerListesi = [];
List<Map<String, dynamic>> ogrenilenKelimeler = [];

class LingoDeutschApp extends StatelessWidget {
  const LingoDeutschApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LingoDeutsch',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), useMaterial3: true),
      home: const DilSecimEkrani(),
    );
  }
}

class DilSecimEkrani extends StatelessWidget {
  const DilSecimEkrani({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(title: const Text("LingoDeutsch", style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.teal, foregroundColor: Colors.white, centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Öğrenme Dilinizi Seçin\nSelect Your Learning Language", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SeviyeSecimEkrani(secilenDil: "Türkçe"))), icon: const Icon(Icons.language), label: const Text("Türkçe - Almanca", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15))),
            const SizedBox(height: 20),
            ElevatedButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SeviyeSecimEkrani(secilenDil: "English"))), icon: const Icon(Icons.g_translate), label: const Text("English - German", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15))),
          ],
        ),
      ),
    );
  }
}

class SeviyeSecimEkrani extends StatelessWidget {
  final String secilenDil;
  const SeviyeSecimEkrani({super.key, required this.secilenDil});
  @override
  Widget build(BuildContext context) {
    bool isTr = secilenDil == "Türkçe";
    return Scaffold(
      appBar: AppBar(title: Text(isTr ? "Seviyeler" : "Levels"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: GridView.count(
        crossAxisCount: 2, padding: const EdgeInsets.all(20), crossAxisSpacing: 20, mainAxisSpacing: 20,
        children: [
          _seviyeKarti(context, "A1", isTr ? "Başlangıç" : "Beginner"),
          _seviyeKarti(context, "A2", isTr ? "Temel" : "Elementary"),
          _seviyeKarti(context, "B1", isTr ? "Orta" : "Intermediate"),
          _seviyeKarti(context, "B2", isTr ? "İyi" : "Upper Intermediate"),
        ],
      ),
    );
  }
  Widget _seviyeKarti(BuildContext context, String seviye, String aciklama) {
    return Card(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: InkWell(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KategoriSecimEkrani(secilenDil: secilenDil, secilenSeviye: seviye))), borderRadius: BorderRadius.circular(15), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(seviye, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.teal)), const SizedBox(height: 10), Text(aciklama, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey))])));
  }
}

class KategoriSecimEkrani extends StatelessWidget {
  final String secilenDil; final String secilenSeviye;
  const KategoriSecimEkrani({super.key, required this.secilenDil, required this.secilenSeviye});

  @override Widget build(BuildContext context) {
    bool isTr = secilenDil == "Türkçe";
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(title: Text("$secilenSeviye ${isTr ? "Kategorileri" : "Categories"}"), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _kategoriButonu(context: context, ikon: Icons.library_books, baslik: isTr ? "Kelimeler" : "Vocabulary", renk: Colors.blueAccent, hedefEkran: KelimeAltMenuEkrani(secilenDil: secilenDil, secilenSeviye: secilenSeviye)),
          _kategoriButonu(context: context, ikon: Icons.directions_run, baslik: isTr ? "Fiiller (Özel)" : "Verbs (Special)", renk: Colors.orange, hedefEkran: FiilOgrenmeEkrani(secilenDil: secilenDil, secilenSeviye: secilenSeviye)),
          _kategoriButonu(context: context, ikon: Icons.rule, baslik: isTr ? "Gramer Kuralları" : "Grammar Rules", renk: Colors.redAccent, hedefEkran: GramerKonulariEkrani(secilenDil: secilenDil, secilenSeviye: secilenSeviye)),
        ],
      ),
    );
  }

  Widget _kategoriButonu({required BuildContext context, required IconData ikon, required String baslik, required Color renk, Widget? hedefEkran}) {
    return Container(margin: const EdgeInsets.only(bottom: 15), child: ElevatedButton(style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20), backgroundColor: Colors.white, foregroundColor: Colors.black87, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))), onPressed: () { if (hedefEkran != null) { Navigator.push(context, MaterialPageRoute(builder: (context) => hedefEkran)); } else { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$baslik modülü yapım aşamasında."))); } }, child: Row(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: renk.withAlpha(51), shape: BoxShape.circle), child: Icon(ikon, color: renk, size: 30)), const SizedBox(width: 20), Text(baslik, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), const Spacer(), const Icon(Icons.arrow_forward_ios, color: Colors.grey)])));
  }
}

class KelimeAltMenuEkrani extends StatelessWidget {
  final String secilenDil; final String secilenSeviye;
  const KelimeAltMenuEkrani({super.key, required this.secilenDil, required this.secilenSeviye});

  @override Widget build(BuildContext context) {
    bool isTr = secilenDil == "Türkçe";
    return Scaffold(
      backgroundColor: Colors.grey.shade100, appBar: AppBar(title: Text(isTr ? "Kelime Modülü" : "Vocabulary Module"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buyukButon(context, ikon: Icons.school, baslik: isTr ? "Yeni Kelime Öğren" : "Learn New Words", altBaslik: isTr ? "Sadece İsim, Sıfat ve Zarflar." : "Only Nouns, Adjectives, Adverbs.", renk: Colors.blue, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => KelimeOgrenmeEkrani(secilenDil: secilenDil, secilenSeviye: secilenSeviye)))),
            const SizedBox(height: 20),
            _buyukButon(context, ikon: Icons.replay_circle_filled, baslik: isTr ? "Tekrar Listem" : "My Review List", altBaslik: isTr ? "Zorlandığın kelimelere göz at." : "Review words you found difficult.", renk: Colors.orange, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TekrarListesiEkrani(isTr: isTr)))),
          ],
        ),
      ),
    );
  }

  Widget _buyukButon(BuildContext context, {required IconData ikon, required String baslik, required String altBaslik, required Color renk, required VoidCallback onTap}) {
    return InkWell(onTap: onTap, child: Container(width: double.infinity, padding: const EdgeInsets.all(25), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))]), child: Row(children: [Icon(ikon, size: 50, color: renk), const SizedBox(width: 20), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(baslik, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey.shade800)), const SizedBox(height: 5), Text(altBaslik, style: const TextStyle(color: Colors.grey))]))])));
  }
}

class KelimeOgrenmeEkrani extends StatefulWidget {
  final String secilenDil; final String secilenSeviye;
  const KelimeOgrenmeEkrani({super.key, required this.secilenDil, required this.secilenSeviye});
  @override State<KelimeOgrenmeEkrani> createState() => _KelimeOgrenmeEkraniState();
}

class _KelimeOgrenmeEkraniState extends State<KelimeOgrenmeEkrani> {
  List<Map<String, dynamic>> destemiz = [];
  Map<String, dynamic>? suankiKelime;
  late bool isTr;
  final FlutterTts flutterTts = FlutterTts();

  @override void initState() {
    super.initState();
    isTr = widget.secilenDil == "Türkçe";
    destemiz = kelimeVeritabani.where((k) => k["seviye"] == widget.secilenSeviye && k["tur"] != "Verb" && !ogrenilenKelimeler.contains(k) && !tekrarEdileceklerListesi.contains(k)).toList();
    destemiz.shuffle(); 
    _siradaki();
    _sesMotorunuAyarla();
  }

  Future<void> _sesMotorunuAyarla() async { await flutterTts.setLanguage("de-DE"); await flutterTts.setSpeechRate(0.70); }
  Future<void> _seslendir(String metin) async { await flutterTts.speak(metin); }

  void _siradaki() { setState(() { suankiKelime = destemiz.isNotEmpty ? destemiz.removeLast() : null; }); }
  void _tekrarEkle() { tekrarEdileceklerListesi.add(suankiKelime!); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isTr ? "Tekrar listesine atıldı." : "Moved to review list."), duration: const Duration(milliseconds: 600), backgroundColor: Colors.orange)); _siradaki(); }
  void _biliyorum() { ogrenilenKelimeler.add(suankiKelime!); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(isTr ? "Süper! Hafızaya eklendi." : "Awesome! Memorized."), duration: const Duration(milliseconds: 600), backgroundColor: Colors.green)); _siradaki(); }

  @override Widget build(BuildContext context) {
    if (suankiKelime == null) return Scaffold(appBar: AppBar(title: Text(isTr ? "Tebrikler!" : "Congratulations!"), backgroundColor: Colors.blueAccent), body: Center(child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Menüye Dön"))));
    String anlam = isTr ? suankiKelime!["tr"] : suankiKelime!["en"];
    
    return Scaffold(
      backgroundColor: Colors.grey.shade100, appBar: AppBar(title: Text(isTr ? "Kelime Öğren" : "Learn Words"), backgroundColor: Colors.blueAccent, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), 
                child: Container(
                  width: double.infinity, padding: const EdgeInsets.all(20), 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, 
                    children: [
                      Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.blue.withAlpha(51), borderRadius: BorderRadius.circular(10)), child: Text(suankiKelime!["tur"], style: const TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold))), 
                      const SizedBox(height: 20), 
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(suankiKelime!["kelime"], textAlign: TextAlign.center, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.volume_up, color: Colors.blueAccent, size: 35), onPressed: () => _seslendir(suankiKelime!["kelime"]))
                        ],
                      ),
                      const SizedBox(height: 10), 
                      Text(anlam, textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: Colors.grey.shade700))
                    ]
                  )
                )
              )
            ),
            const SizedBox(height: 20),
            Row(children: [Expanded(child: ElevatedButton(onPressed: _tekrarEkle, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 20)), child: Text(isTr ? "Tekrar Et" : "Review", style: const TextStyle(fontSize: 18)))), const SizedBox(width: 15), Expanded(child: ElevatedButton(onPressed: _biliyorum, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 20)), child: Text(isTr ? "Biliyorum" : "I Know It", style: const TextStyle(fontSize: 18))))])
          ],
        ),
      ),
    );
  }
}

// 6. FİİL ÖĞRENME EKRANI (HEDEF FİİLE GÖRE ÇEKİMLENEN MOTOR)
class FiilOgrenmeEkrani extends StatefulWidget {
  final String secilenDil; final String secilenSeviye;
  const FiilOgrenmeEkrani({super.key, required this.secilenDil, required this.secilenSeviye});
  @override State<FiilOgrenmeEkrani> createState() => _FiilOgrenmeEkraniState();
}

class _FiilOgrenmeEkraniState extends State<FiilOgrenmeEkrani> {
  List<Map<String, dynamic>> fiilDestesi = [];
  Map<String, dynamic>? suankiFiil;
  
  Map<String, String>? motorCumlesiData; // Artık çevirileriyle beraber geliyor
  bool motorCeviriGoster = false;
  
  int ornekIndex = 0;
  bool ceviriyiGoster = false; 
  late bool isTr;
  final FlutterTts flutterTts = FlutterTts(); 

  @override void initState() {
    super.initState();
    isTr = widget.secilenDil == "Türkçe";
    fiilDestesi = kelimeVeritabani.where((k) => k["tur"] == "Verb" && k["seviye"] == widget.secilenSeviye).toList();
    fiilDestesi.shuffle(); 
    _sonrakiFiiliCek();
    _sesMotorunuAyarla();
  }

  Future<void> _sesMotorunuAyarla() async { await flutterTts.setLanguage("de-DE"); await flutterTts.setSpeechRate(0.70); }
  Future<void> _seslendir(String metin) async { await flutterTts.speak(metin); }

  void _sonrakiFiiliCek() { 
    setState(() { 
      ceviriyiGoster = false; 
      motorCumlesiData = null; // Cümleyi temizle
      if (fiilDestesi.isNotEmpty) { 
        suankiFiil = fiilDestesi.removeLast(); 
        ornekIndex = 0; 
      } else { 
        suankiFiil = null; 
      } 
    }); 
  }

  void _yeniOrnekGetir() { 
    if (suankiFiil!["ornekler"] != null && suankiFiil!["ornekler"].isNotEmpty) { 
      setState(() { 
        ornekIndex = (ornekIndex + 1) % (suankiFiil!["ornekler"] as List).length; 
        ceviriyiGoster = false; 
      }); 
    } 
  }

  void _zaraBas() {
    setState(() {
      // SADECE O ANKİ FİİLİ (suankiFiil) KULLANARAK CÜMLE ÜRETİR
      motorCumlesiData = CumleMotoru.uret(hedefFiil: suankiFiil!["kelime"], gramerKonusu: "Normal"); 
      motorCeviriGoster = false;
    });
  }

  @override Widget build(BuildContext context) {
    if (suankiFiil == null) return Scaffold(appBar: AppBar(title: Text(isTr ? "Fiiller Bitti!" : "Verbs Finished!"), backgroundColor: Colors.orange), body: Center(child: Text(isTr ? "Bu seviyedeki tüm fiilleri tamamladın." : "You finished all verbs for this level.", style: const TextStyle(fontSize: 20))));

    String anlam = isTr ? suankiFiil!["tr"] : suankiFiil!["en"];
    List ornekler = suankiFiil!["ornekler"] ?? [];
    Map<String, dynamic> cekimler = suankiFiil!["cekimler"] ?? {};

    return Scaffold(
      backgroundColor: Colors.grey.shade100, appBar: AppBar(title: Text(isTr ? "Fiil Modülü" : "Verb Module"), backgroundColor: Colors.orange, foregroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                elevation: 6, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(suankiFiil!["kelime"], textAlign: TextAlign.center, style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                          IconButton(icon: const Icon(Icons.volume_up, color: Colors.orange, size: 35), onPressed: () => _seslendir(suankiFiil!["kelime"]))
                        ],
                      ),
                      const SizedBox(height: 5), Text(anlam, textAlign: TextAlign.center, style: TextStyle(fontSize: 22, color: Colors.grey.shade700)), const Divider(height: 40, thickness: 2),
                      
                      // DİNAMİK CÜMLE MOTORU KUTUSU
                      Container(
                        padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.orange.shade200)), 
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(icon: const Icon(Icons.volume_up, color: Colors.orange, size: 30), onPressed: () => _seslendir(motorCumlesiData != null ? motorCumlesiData!["almanca"]! : "Klicken Sie")), 
                            const SizedBox(width: 10), 
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, 
                                children: [
                                  motorCumlesiData == null 
                                    ? Text(isTr ? "Bu fiille rastgele bir cümle üretmek için zara tıkla!" : "Click dice to generate random sentence with this verb!", style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic))
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Wrap(
                                            spacing: 4.0,
                                            children: motorCumlesiData!["almanca"]!.split(' ').map<Widget>((kelime) => InkWell(
                                              onTap: () => _seslendir(kelime),
                                              child: Text(kelime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                            )).toList(),
                                          ),
                                          const SizedBox(height: 8),
                                          motorCeviriGoster 
                                            ? Text(isTr ? motorCumlesiData!["tr"]! : motorCumlesiData!["en"]!, style: TextStyle(color: Colors.grey.shade700, fontSize: 15))
                                            : InkWell(
                                                onTap: () => setState(() => motorCeviriGoster = true),
                                                child: Text(isTr ? "👀 Çeviriyi Gör" : "👀 Show Translation", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                                              )
                                        ],
                                      )
                                ]
                              )
                            ), 
                            IconButton(icon: const Icon(Icons.casino, color: Colors.deepOrange, size: 35), onPressed: _zaraBas)
                          ]
                        )
                      ),
                      const SizedBox(height: 20),
                      if (cekimler.isNotEmpty) Column(crossAxisAlignment: CrossAxisAlignment.start, children: cekimler.entries.map((zaman) { return Card(margin: const EdgeInsets.only(bottom: 10), color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide(color: Colors.grey.shade300)), child: ExpansionTile(title: Text(zaman.key, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)), children: [Padding(padding: const EdgeInsets.all(15.0), child: Column(children: (zaman.value as Map<String, String>).entries.map((c) => Padding(padding: const EdgeInsets.only(bottom: 4), child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [SizedBox(width: 80, child: Text(c.key, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))), Text(c.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]))).toList()))])); }).toList())
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(children: [Expanded(child: ElevatedButton(onPressed: _sonrakiFiiliCek, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 20)), child: Text(isTr ? "Sıradaki Fiil" : "Next Verb", style: const TextStyle(fontSize: 18))))])
          ],
        ),
      ),
    );
  }
}

class TekrarListesiEkrani extends StatefulWidget {
  final bool isTr; const TekrarListesiEkrani({super.key, required this.isTr});
  @override State<TekrarListesiEkrani> createState() => _TekrarListesiEkraniState();
}
class _TekrarListesiEkraniState extends State<TekrarListesiEkrani> {
  @override Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100, appBar: AppBar(title: Text(widget.isTr ? "Tekrar Listem" : "My Review List"), backgroundColor: Colors.orange, foregroundColor: Colors.white),
      body: tekrarEdileceklerListesi.isEmpty ? Center(child: Text(widget.isTr ? "Listen şu an boş." : "Your list is empty.", style: const TextStyle(fontSize: 16, color: Colors.grey))) : ListView.builder(itemCount: tekrarEdileceklerListesi.length, itemBuilder: (context, index) { var kelime = tekrarEdileceklerListesi[index]; String anlam = widget.isTr ? kelime["tr"] : kelime["en"]; return Card(margin: const EdgeInsets.all(10), child: ListTile(title: Text(kelime["kelime"], style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(anlam), trailing: IconButton(icon: const Icon(Icons.check_circle, color: Colors.green), onPressed: () { setState(() { ogrenilenKelimeler.add(kelime); tekrarEdileceklerListesi.removeAt(index); }); }))); }),
    );
  }
}

class GramerKonulariEkrani extends StatelessWidget {
  final String secilenDil; final String secilenSeviye;
  const GramerKonulariEkrani({super.key, required this.secilenDil, required this.secilenSeviye});

  @override Widget build(BuildContext context) {
    bool isTr = secilenDil == "Türkçe";
    List<Map<String, dynamic>> konular = gramerKonulari.where((k) => k["seviye"] == secilenSeviye).toList();
    
    return Scaffold(
      backgroundColor: Colors.grey.shade100, 
      appBar: AppBar(title: Text("$secilenSeviye ${isTr ? "Gramer" : "Grammar"}"), backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
      body: ListView.builder(padding: const EdgeInsets.all(15), itemCount: konular.length, itemBuilder: (context, index) {
        var konu = konular[index]; 
        String baslik = isTr ? konu["baslik_tr"] : konu["baslik_en"]; 
        String aciklama = isTr ? konu["aciklama_tr"] : konu["aciklama_en"];
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12), 
          child: ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.redAccent), 
            title: Text(baslik, style: const TextStyle(fontWeight: FontWeight.bold)), 
            subtitle: Text(aciklama), 
            trailing: const Icon(Icons.arrow_forward_ios, size: 16), 
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => GramerDetayEkrani(isTr: isTr, konuVerisi: konu)))
          )
        );
      }),
    );
  }
}

// 9. GRAMER DETAY EKRANI (ÇEVİRİLİ MOTOR DESTEĞİ)
class GramerDetayEkrani extends StatefulWidget {
  final bool isTr; 
  final Map<String, dynamic> konuVerisi;
  
  const GramerDetayEkrani({super.key, required this.isTr, required this.konuVerisi});

  @override
  State<GramerDetayEkrani> createState() => _GramerDetayEkraniState();
}

class _GramerDetayEkraniState extends State<GramerDetayEkrani> {
  final FlutterTts flutterTts = FlutterTts();
  
  Map<String, String>? motorCumlesiData; 
  bool motorCeviriGoster = false;

  @override
  void initState() {
    super.initState();
    _sesMotorunuAyarla();
  }

  Future<void> _sesMotorunuAyarla() async { await flutterTts.setLanguage("de-DE"); await flutterTts.setSpeechRate(0.70); }
  Future<void> _seslendir(String metin) async { await flutterTts.speak(metin); }

  void _zaraBas(String konuBaslik) {
    setState(() {
      motorCumlesiData = CumleMotoru.uret(gramerKonusu: konuBaslik); 
      motorCeviriGoster = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String baslik = widget.isTr ? widget.konuVerisi["baslik_tr"] : widget.konuVerisi["baslik_en"];
    String detay = widget.isTr ? widget.konuVerisi["detay_tr"] : widget.konuVerisi["detay_en"];
    String tabloBaslik = widget.isTr ? (widget.konuVerisi["tablo_baslik_tr"] ?? "Kurallar") : (widget.konuVerisi["tablo_baslik_en"] ?? "Rules");
    List tablo = widget.konuVerisi["tablo"] ?? [];
    List ornekler = widget.konuVerisi["ornekler"] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(baslik), backgroundColor: Colors.redAccent, foregroundColor: Colors.white),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.redAccent.shade100)),
              child: Text(detay, style: const TextStyle(fontSize: 16, height: 1.5)),
            ),
            const SizedBox(height: 25),

            if (tablo.isNotEmpty) ...[
              Text(tabloBaslik, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent)),
              const SizedBox(height: 10),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: tablo.map((satir) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Text(widget.isTr ? satir["kural_tr"] : satir["kural_en"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
                          Expanded(flex: 1, child: Text(satir["ek"], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 16))),
                          Expanded(flex: 3, child: Text(satir["ornek"], style: const TextStyle(fontStyle: FontStyle.italic))),
                        ],
                      ),
                    )).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],

            // GRAMER MOTORU KUTUSU (ÇEVİRİLİ)
            Container(
              padding: const EdgeInsets.all(15), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.deepPurple.shade200)), 
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(icon: const Icon(Icons.volume_up, color: Colors.deepPurple, size: 30), onPressed: () => _seslendir(motorCumlesiData != null ? motorCumlesiData!["almanca"]! : "Klicken Sie")), 
                  const SizedBox(width: 10), 
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        motorCumlesiData == null 
                          ? Text(widget.isTr ? "Bu konuya uygun rastgele cümle üretmek için zara tıkla!" : "Click the dice to generate a random sentence!", style: const TextStyle(color: Colors.deepPurple, fontStyle: FontStyle.italic))
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 4.0,
                                  children: motorCumlesiData!["almanca"]!.split(' ').map<Widget>((kelime) => InkWell(
                                    onTap: () => _seslendir(kelime),
                                    child: Text(kelime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  )).toList(),
                                ),
                                const SizedBox(height: 8),
                                motorCeviriGoster 
                                  ? Text(widget.isTr ? motorCumlesiData!["tr"]! : motorCumlesiData!["en"]!, style: TextStyle(color: Colors.grey.shade700, fontSize: 15))
                                  : InkWell(
                                      onTap: () => setState(() => motorCeviriGoster = true),
                                      child: Text(widget.isTr ? "👀 Çeviriyi Gör" : "👀 Show Translation", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14)),
                                    )
                              ],
                            )
                      ]
                    )
                  ), 
                  IconButton(
                    icon: const Icon(Icons.casino, color: Colors.deepPurple, size: 35),
                    onPressed: () => _zaraBas(widget.konuVerisi["baslik_en"] ?? ""), 
                  )
                ]
              )
            ),
            const SizedBox(height: 25),

            if (ornekler.isNotEmpty) ...[
              Row(
                children: [
                  const Icon(Icons.lightbulb_outline, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(widget.isTr ? "Örnek Cümleler" : "Example Sentences", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                ],
              ),
              const SizedBox(height: 10),
              ...ornekler.map((ornek) => GramerOrnekKarti(ornek: ornek, isTr: widget.isTr, onSeslendir: _seslendir)).toList(),
            ]
          ],
        ),
      ),
    );
  }
}

class GramerOrnekKarti extends StatefulWidget {
  final Map<String, dynamic> ornek; final bool isTr; final Function(String) onSeslendir;
  const GramerOrnekKarti({super.key, required this.ornek, required this.isTr, required this.onSeslendir});
  @override State<GramerOrnekKarti> createState() => _GramerOrnekKartiState();
}

class _GramerOrnekKartiState extends State<GramerOrnekKarti> {
  bool ceviriyiGoster = false;
  @override Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(15), width: double.infinity, decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(icon: const Icon(Icons.volume_up, color: Colors.orange, size: 30), onPressed: () => widget.onSeslendir(widget.ornek["almanca"])),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 4.0, children: widget.ornek["almanca"].split(' ').map<Widget>((kelime) => InkWell(onTap: () => widget.onSeslendir(kelime), child: Text(kelime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))).toList()),
                const SizedBox(height: 8),
                ceviriyiGoster
                    ? Text(widget.isTr ? widget.ornek["tr"] : widget.ornek["en"], style: TextStyle(fontSize: 14, color: Colors.grey.shade700))
                    : InkWell(onTap: () => setState(() => ceviriyiGoster = true), child: Text(widget.isTr ? "👀 Çeviriyi Gör" : "👀 Show Translation", style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 14))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
