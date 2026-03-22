// cumle_motoru.dart
import 'dart:math';

class CumleMotoru {
  static final Random _rnd = Random();

  // Özneler ve Çekim Kodları (1: Ben, 2: Sen, 3: O, 4: Biz/Onlar)
  static final List<Map<String, String>> _ozneler = [
    {"cekim": "1", "de": "Ich", "tr": "Ben", "en": "I"},
    {"cekim": "2", "de": "Du", "tr": "Sen", "en": "You"},
    {"cekim": "3", "de": "Der Student", "tr": "Öğrenci", "en": "The student"},
    {"cekim": "3", "de": "Die Frau", "tr": "Kadın", "en": "The woman"},
    {"cekim": "4", "de": "Wir", "tr": "Biz", "en": "We"},
  ];

  // Modal Fiiller ve Şahıslara Göre Çekimleri/Çevirileri
  static final Map<String, dynamic> _modaller = {
    "wollen": {
      "cekim_de": {"1": "will", "2": "willst", "3": "will", "4": "wollen"},
      "ek_tr": {"1": "istiyorum", "2": "istiyorsun", "3": "istiyor", "4": "istiyoruz"},
      "ek_en": {"1": "want to", "2": "want to", "3": "wants to", "4": "want to"}
    },
    "müssen": {
      "cekim_de": {"1": "muss", "2": "musst", "3": "muss", "4": "müssen"},
      "ek_tr": {"1": "zorundayım", "2": "zorundasın", "3": "zorunda", "4": "zorundayız"},
      "ek_en": {"1": "have to", "2": "have to", "3": "has to", "4": "have to"}
    },
    "können": { // Yetenek (Yapabilmek)
      "cekim_de": {"1": "kann", "2": "kannst", "3": "kann", "4": "können"},
      "ek_tr": {"1": "biliyorum", "2": "biliyorsun", "3": "biliyor", "4": "biliyoruz"}, 
      "ek_en": {"1": "can", "2": "can", "3": "can", "4": "can"}
    }
  };

  // Asıl Fiillerin Tüm Hallerinin Haritası (Sözlüğü)
  static final Map<String, dynamic> _fiiller = {
    "arbeiten": {
      "mastar_de": "arbeiten", "mastar_tr": "çalışmak", "mastar_en": "work", "yetenek_tr": "çalışa",
      "cekim_de": {"1": "arbeite", "2": "arbeitest", "3": "arbeitet", "4": "arbeiten"},
      "cekim_tr": {"1": "çalışıyorum", "2": "çalışıyorsun", "3": "çalışıyor", "4": "çalışıyoruz"},
      "cekim_en": {"1": "am working", "2": "are working", "3": "is working", "4": "are working"},
      "tamamlayicilar": [{"de": "in einer Bank", "tr": "bir bankada", "en": "in a bank"}, {"de": "sehr hart", "tr": "çok sıkı", "en": "very hard"}]
    },
    "lernen": {
      "mastar_de": "lernen", "mastar_tr": "öğrenmek", "mastar_en": "learn", "yetenek_tr": "öğrene",
      "cekim_de": {"1": "lerne", "2": "lernst", "3": "lernt", "4": "lernen"},
      "cekim_tr": {"1": "öğreniyorum", "2": "öğreniyorsun", "3": "öğreniyor", "4": "öğreniyoruz"},
      "cekim_en": {"1": "am learning", "2": "are learning", "3": "is learning", "4": "are learning"},
      "tamamlayicilar": [{"de": "Deutsch", "tr": "Almanca", "en": "German"}, {"de": "für die Prüfung", "tr": "sınav için", "en": "for the exam"}]
    },
    "spielen": {
      "mastar_de": "spielen", "mastar_tr": "oynamak", "mastar_en": "play", "yetenek_tr": "oynaya",
      "cekim_de": {"1": "spiele", "2": "spielst", "3": "spielt", "4": "spielen"},
      "cekim_tr": {"1": "oynuyorum", "2": "oynuyorsun", "3": "oynuyor", "4": "oynuyoruz"},
      "cekim_en": {"1": "am playing", "2": "are playing", "3": "is playing", "4": "are playing"},
      "tamamlayicilar": [{"de": "Schach", "tr": "satranç", "en": "chess"}, {"de": "Gitarre", "tr": "gitar", "en": "the guitar"}]
    },
    "essen": {
      "mastar_de": "essen", "mastar_tr": "yemek", "mastar_en": "eat", "yetenek_tr": "yiye",
      "cekim_de": {"1": "esse", "2": "isst", "3": "isst", "4": "essen"},
      "cekim_tr": {"1": "yiyorum", "2": "yiyorsun", "3": "yiyor", "4": "yiyoruz"},
      "cekim_en": {"1": "am eating", "2": "are eating", "3": "is eating", "4": "are eating"},
      "tamamlayicilar": [{"de": "eine Pizza", "tr": "bir pizza", "en": "a pizza"}, {"de": "einen Apfel", "tr": "bir elma", "en": "an apple"}]
    },
    "trinken": {
      "mastar_de": "trinken", "mastar_tr": "içmek", "mastar_en": "drink", "yetenek_tr": "içe",
      "cekim_de": {"1": "trinke", "2": "trinkst", "3": "trinkt", "4": "trinken"},
      "cekim_tr": {"1": "içiyorum", "2": "içiyorsun", "3": "içiyor", "4": "içiyoruz"},
      "cekim_en": {"1": "am drinking", "2": "are drinking", "3": "is drinking", "4": "are drinking"},
      "tamamlayicilar": [{"de": "Kaffee", "tr": "kahve", "en": "coffee"}, {"de": "Wasser", "tr": "su", "en": "water"}]
    },
    "gehen": {
      "mastar_de": "gehen", "mastar_tr": "gitmek", "mastar_en": "go", "yetenek_tr": "gide",
      "cekim_de": {"1": "gehe", "2": "gehst", "3": "geht", "4": "gehen"},
      "cekim_tr": {"1": "gidiyorum", "2": "gidiyorsun", "3": "gidiyor", "4": "gidiyoruz"},
      "cekim_en": {"1": "am going", "2": "are going", "3": "is going", "4": "are going"},
      "tamamlayicilar": [{"de": "nach Hause", "tr": "eve", "en": "home"}, {"de": "in die Stadt", "tr": "şehre", "en": "to the city"}]
    },
    "kaufen": {
      "mastar_de": "kaufen", "mastar_tr": "almak", "mastar_en": "buy", "yetenek_tr": "ala",
      "cekim_de": {"1": "kaufe", "2": "kaufst", "3": "kauft", "4": "kaufen"},
      "cekim_tr": {"1": "alıyorum", "2": "alıyorsun", "3": "alıyor", "4": "alıyoruz"},
      "cekim_en": {"1": "am buying", "2": "are buying", "3": "is buying", "4": "are buying"},
      "tamamlayicilar": [{"de": "ein Auto", "tr": "bir araba", "en": "a car"}, {"de": "ein Buch", "tr": "bir kitap", "en": "a book"}]
    },
    "reisen": {
      "mastar_de": "reisen", "mastar_tr": "seyahat etmek", "mastar_en": "travel", "yetenek_tr": "seyahat ede",
      "cekim_de": {"1": "reise", "2": "reist", "3": "reist", "4": "reisen"},
      "cekim_tr": {"1": "seyahat ediyorum", "2": "seyahat ediyorsun", "3": "seyahat ediyor", "4": "seyahat ediyoruz"},
      "cekim_en": {"1": "am traveling", "2": "are traveling", "3": "is traveling", "4": "are traveling"},
      "tamamlayicilar": [{"de": "nach Spanien", "tr": "İspanya'ya", "en": "to Spain"}, {"de": "im Sommer", "tr": "yazın", "en": "in summer"}]
    },
    "sprechen": {
      "mastar_de": "sprechen", "mastar_tr": "konuşmak", "mastar_en": "speak", "yetenek_tr": "konuşa",
      "cekim_de": {"1": "spreche", "2": "sprichst", "3": "spricht", "4": "sprechen"},
      "cekim_tr": {"1": "konuşuyorum", "2": "konuşuyorsun", "3": "konuşuyor", "4": "konuşuyoruz"},
      "cekim_en": {"1": "am speaking", "2": "are speaking", "3": "is speaking", "4": "are speaking"},
      "tamamlayicilar": [{"de": "Deutsch", "tr": "Almanca", "en": "German"}, {"de": "mit meinem Freund", "tr": "arkadaşımla", "en": "with my friend"}]
    },
    "machen": {
      "mastar_de": "machen", "mastar_tr": "yapmak", "mastar_en": "do", "yetenek_tr": "yapa",
      "cekim_de": {"1": "mache", "2": "machst", "3": "macht", "4": "machen"},
      "cekim_tr": {"1": "yapıyorum", "2": "yapıyorsun", "3": "yapıyor", "4": "yapıyoruz"},
      "cekim_en": {"1": "am doing", "2": "are doing", "3": "is doing", "4": "are doing"},
      "tamamlayicilar": [{"de": "Sport", "tr": "spor", "en": "sports"}, {"de": "die Hausaufgaben", "tr": "ödevleri", "en": "the homework"}]
    }
  };

  // 3 DİLLİ VE ÇEKİMLİ CÜMLE ÜRETİCİ FONKSİYON
  static Map<String, String> uret({String? hedefFiil, required String gramerKonusu}) {
    Map<String, String> ozne = _ozneler[_rnd.nextInt(_ozneler.length)];
    String c = ozne["cekim"]!;

    // Kullanıcı bir fiil dayattıysa onu kullan, yoksa rastgele seç (Verbs ekranı için)
    String secilenFiilAnahtari;
    if (hedefFiil != null && _fiiller.containsKey(hedefFiil)) {
      secilenFiilAnahtari = hedefFiil;
    } else {
      List<String> anahtarlar = _fiiller.keys.toList();
      secilenFiilAnahtari = anahtarlar[_rnd.nextInt(anahtarlar.length)];
    }

    Map<String, dynamic> fiil = _fiiller[secilenFiilAnahtari]!;
    List<Map<String, String>> tamamlayicilar = List<Map<String, String>>.from(fiil["tamamlayicilar"]);
    Map<String, String> nesne = tamamlayicilar[_rnd.nextInt(tamamlayicilar.length)];

    bool isModal = gramerKonusu.toLowerCase().contains("modal");

    if (isModal) {
      // Modal Cümle (Örn: Ben Almanca öğrenmek istiyorum)
      List<String> modalKeys = _modaller.keys.toList();
      String secilenModal = modalKeys[_rnd.nextInt(modalKeys.length)];
      Map<String, dynamic> modal = _modaller[secilenModal]!;

      String de = "${ozne["de"]} ${modal["cekim_de"][c]} ${nesne["de"]} ${fiil["mastar_de"]}.";
      String tr;
      if (secilenModal == "können") {
        tr = "${ozne["tr"]} ${nesne["tr"]} ${fiil["yetenek_tr"]}${modal["ek_tr"][c]}."; // Örn: konuşa-biliyorum
      } else {
        tr = "${ozne["tr"]} ${nesne["tr"]} ${fiil["mastar_tr"]} ${modal["ek_tr"][c]}."; // Örn: konuşmak istiyorum
      }
      String en = "${ozne["en"]} ${modal["ek_en"][c]} ${fiil["mastar_en"]} ${nesne["en"]}.";

      return {"almanca": de, "tr": tr, "en": en};
    } else {
      // Normal Cümle (Örn: Ben Almanca öğreniyorum)
      String de = "${ozne["de"]} ${fiil["cekim_de"][c]} ${nesne["de"]}.";
      String tr = "${ozne["tr"]} ${nesne["tr"]} ${fiil["cekim_tr"][c]}.";
      String en = "${ozne["en"]} ${fiil["cekim_en"][c]} ${nesne["en"]}.";

      return {"almanca": de, "tr": tr, "en": en};
    }
  }
}
