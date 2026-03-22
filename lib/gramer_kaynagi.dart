// gramer_kaynagi.dart

final List<Map<String, dynamic>> gramerKonulari = [
  {
    "seviye": "A1",
    "baslik_tr": "Şahıs Zamirleri ve Fiil Çekimi",
    "baslik_en": "Personal Pronouns & Conjugation",
    "aciklama_tr": "ich, du, er... ve temel çekim kuralları.",
    "aciklama_en": "ich, du, er... and basic conjugation rules.",
    "detay_tr": "Almancada fiiller özneye (şahıs zamirine) göre çekimlenir. Düzenli fiillerin çoğu '-en' takısı ile biter. Çekim yaparken bu mastar eki atılır ve yerine şahsa uygun ekler (-e, -st, -t, -en, -t, -en) getirilir.",
    "detay_en": "In German, verbs are conjugated according to the subject pronoun. Most regular verbs end in '-en'. To conjugate, drop the ending and add the specific pronoun endings (-e, -st, -t, -en, -t, -en).",
    "tablo_baslik_tr": "Düzenli Fiil Çekimi (machen - yapmak)",
    "tablo_baslik_en": "Regular Verb Conjugation (machen - to do/make)",
    "tablo": [
      {"kural_tr": "ich (Ben)", "kural_en": "ich (I)", "ek": "-e", "ornek": "ich mache"},
      {"kural_tr": "du (Sen)", "kural_en": "du (You)", "ek": "-st", "ornek": "du machst"},
      {"kural_tr": "er/sie/es (O)", "kural_en": "er/sie/es (He/She/It)", "ek": "-t", "ornek": "er macht"},
      {"kural_tr": "wir (Biz)", "kural_en": "wir (We)", "ek": "-en", "ornek": "wir machen"},
      {"kural_tr": "ihr (Siz)", "kural_en": "ihr (You all)", "ek": "-t", "ornek": "ihr macht"},
      {"kural_tr": "sie/Sie (Onlar/Kibar Siz)", "kural_en": "sie/Sie (They/Formal You)", "ek": "-en", "ornek": "sie machen"}
    ],
    "ornekler": [
      {"almanca": "Ich studiere Wirtschaftsingenieurwesen.", "tr": "Endüstri mühendisliği okuyorum.", "en": "I study industrial engineering."},
      {"almanca": "Wir fliegen im Sommer in die USA.", "tr": "Yazın ABD'ye uçuyoruz.", "en": "We are flying to the USA in the summer."},
      {"almanca": "Tuana spielt gern Schach.", "tr": "Tuana satranç oynamayı sever.", "en": "Tuana likes playing chess."}
    ]
  },
  {
    "seviye": "A1",
    "baslik_tr": "Artikeller (der, die, das)",
    "baslik_en": "Articles (der, die, das)",
    "aciklama_tr": "Belirli ve belirsiz artikellerin mantığı.",
    "aciklama_en": "The logic of definite and indefinite articles.",
    "detay_tr": "Almancada her ismin bir cinsiyeti vardır ve isimler bu cinsiyeti belirten 'artikel'ler ile kullanılır. Üç tane belirli artikel vardır: Eril (der), Dişil (die) ve Nötr (das). Bir kelimeyi her zaman artikeliyle ezberlemelisin.",
    "detay_en": "Every noun in German has a gender, indicated by an 'article'. There are three definite articles: Masculine (der), Feminine (die), and Neuter (das). Always memorize a noun with its article.",
    "tablo_baslik_tr": "Artikeller (Nominativ - Yalın Hal)",
    "tablo_baslik_en": "Articles (Nominative Case)",
    "tablo": [
      {"kural_tr": "Eril (Masculin)", "kural_en": "Masculine", "ek": "der / ein", "ornek": "der Mann (adam)"},
      {"kural_tr": "Dişil (Feminin)", "kural_en": "Feminine", "ek": "die / eine", "ornek": "die Frau (kadın)"},
      {"kural_tr": "Nötr (Neutral)", "kural_en": "Neuter", "ek": "das / ein", "ornek": "das Buch (kitap)"},
      {"kural_tr": "Çoğul (Plural)", "kural_en": "Plural", "ek": "die / -", "ornek": "die Kinder (çocuklar)"}
    ],
    "ornekler": [
      {"almanca": "Das Geld ist auf der Bank.", "tr": "Para bankada.", "en": "The money is in the bank."},
      {"almanca": "Der Kaffee ist sehr gut.", "tr": "Kahve çok iyi.", "en": "The coffee is very good."},
      {"almanca": "Die Universität ist in Istanbul.", "tr": "Üniversite İstanbul'da.", "en": "The university is in Istanbul."}
    ]
  },
  {
    "seviye": "A1",
    "baslik_tr": "Modal Fiiller",
    "baslik_en": "Modal Verbs",
    "aciklama_tr": "können, müssen, wollen, dürfen...",
    "aciklama_en": "können, müssen, wollen, dürfen...",
    "detay_tr": "Modal fiiller cümleye zorunluluk, yetenek veya istek katar. Kural şudur: Modal fiil çekimlenip cümlenin 2. sırasına geçer, asıl işi yapan fiil ise mastar halinde (-en takısıyla) cümlenin en sonuna atılır.",
    "detay_en": "Modal verbs express ability, necessity, or desire. The rule: The modal verb is conjugated in the 2nd position, while the main verb goes to the very end of the sentence in its infinitive form.",
    "tablo_baslik_tr": "En Sık Kullanılan Modal Fiiller",
    "tablo_baslik_en": "Most Common Modal Verbs",
    "tablo": [
      {"kural_tr": "können (yetenek)", "kural_en": "können (ability)", "ek": "kann", "ornek": "ich kann spielen"},
      {"kural_tr": "müssen (zorunluluk)", "kural_en": "müssen (must/have to)", "ek": "muss", "ornek": "ich muss lernen"},
      {"kural_tr": "wollen (istek)", "kural_en": "wollen (want)", "ek": "will", "ornek": "ich will gehen"}
    ],
    "ornekler": [
      {"almanca": "Ich will nach Bilbao reisen.", "tr": "Bilbao'ya seyahat etmek istiyorum.", "en": "I want to travel to Bilbao."},
      {"almanca": "Ich muss für die Wirtschaftsprüfung lernen.", "tr": "Ekonomi sınavı için çalışmak zorundayım.", "en": "I have to study for the economics exam."},
      {"almanca": "Kannst du Gitarre spielen?", "tr": "Gitar çalabiliyor musun?", "en": "Can you play the guitar?"}
    ]
  }
];
