import '../models/dua_model.dart';

class DuaController {
  // Complete List of Duas for Makkah, Tawaf, Sa’i, etc.
  final List<DuaModel> duas = [
    // --- General Travel & Masjid Duas ---
    DuaModel(
      title: "Dua for Travel (Safar)",
      arabic:
          "سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَٰذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ وَإِنَّا إِلَى رَبِّنَا لَمُنقَلِبُونَ",
      translation:
          "Glory to Him Who has subjected this to us, and we could never have accomplished this by ourselves. And surely, to our Lord, we will return.",
    ),
    DuaModel(
      title: "Dua for Entering Masjid al-Haram",
      arabic: "اللّهُـمَّ افْتَـحْ لي أَبْـوابَ رَحْمَتـِكَ",
      translation: "O Allah, open the doors of Your mercy for me.",
    ),
    DuaModel(
      title: "Dua for Leaving Masjid al-Haram",
      arabic: "اللّهُـمَّ إِنِّـي أَسْأَلُـكَ مِنْ فَضْلِـكَ",
      translation: "O Allah, I ask You from Your bounty.",
    ),

    // --- Upon Seeing the Kaaba ---
    DuaModel(
      title: "Dua upon Seeing the Kaaba for the First Time",
      arabic:
          "اللّهُـمَّ زِدْ هَـذَا الْبَيْـتَ تَشْرِيـفًا وَتَعْظِيـمًا وَتَكْرِيـمًا وَمَهَابَـةً، وَزِدْ مَنْ شَرَّفَهُ وَكَرَّمَهُ مِمَّنْ حَجَّهُ أَوِ اعْتَمَرَهُ تَشْرِيفًا وَتَعْظِيمًا وَتَكْرِيمًا وَبِرًّا",
      translation:
          "O Allah, increase this House in honor, greatness, nobility, and awe, and increase those who honor and glorify it through Hajj or Umrah in honor, greatness, nobility, and righteousness.",
    ),

    // --- Dua Before Starting Tawaf ---
    DuaModel(
      title: "Dua Before Starting Tawaf",
      arabic:
          "بِسْمِ اللهِ، اللهُ أَكْبَرُ. اللّهُـمَّ إِيـمَانًا بِكَ وَتَصْدِيـقًا بِكِتَابِكَ وَوَفَاءً بِعَهْدِكَ وَاتِّبَاعًا لِسُنَّةِ نَبِيِّكَ مُحَمَّدٍ ﷺ",
      translation:
          "In the name of Allah, Allah is the Greatest. O Allah, with faith in You, belief in Your Book, loyalty to Your covenant, and following the Sunnah of Your Prophet Muhammad ﷺ.",
    ),

    // --- Dua between Rukn al-Yamani and Hajar al-Aswad ---
    DuaModel(
      title: "Dua between Rukn al-Yamani and Hajar al-Aswad",
      arabic:
          "رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً، وَفِي الآخِرَةِ حَسَنَةً، وَقِنَا عَذَابَ النَّارِ",
      translation:
          "Our Lord, grant us good in this world and good in the Hereafter, and save us from the punishment of the Fire.",
    ),

    // --- Dua After Completing Tawaf ---
    DuaModel(
      title: "Dua After Completing Tawaf",
      arabic:
          "اللّهُـمَّ اجْعَلْهُ حَجًّا مَبْرُورًا، وَذَنْبًا مَغْفُورًا، وَسَعْيًا مَشْكُورًا، وَعَمَلًا صَالِحًا مَقْبُولًا، وَتِجَارَةً لَنْ تَبُورَ",
      translation:
          "O Allah, make it a blessed Hajj, forgiven sin, accepted effort, and a righteous deed that will not perish.",
    ),

    // --- Dua at Maqam Ibrahim ---
    DuaModel(
      title: "Dua at Maqam Ibrahim",
      arabic: "وَاتَّخِذُوا مِن مَّقَامِ إِبْرَاهِيمَ مُصَلًّى",
      translation: "And take the station of Abraham as a place of prayer.",
    ),

    // --- Dua for Drinking Zamzam Water ---
    
    DuaModel(
      title: "Dua When Drinking Zamzam Water",
      arabic:
          "اللّهُـمَّ إِنِّـي أَسْأَلُـكَ عِلْمًا نَافِعًا، وَرِزْقًا وَاسِعًا، وَشِفَاءً مِّنْ كُلِّ دَاءٍ",
      translation:
          "O Allah, I ask You for beneficial knowledge, abundant provision, and healing from every disease.",
    ),

    // --- Dua at Mount Safa (Sa’i Start) ---
    DuaModel(
      title: "Dua at Mount Safa (Starting Sa’i)",
      arabic:
          "إِنَّ الصَّفَا وَالْمَرْوَةَ مِن شَعَائِرِ اللهِ... أَبْدَأُ بِمَا بَدَأَ اللهُ بِهِ",
      translation:
          "Indeed, Safa and Marwah are among the symbols of Allah... I begin with what Allah began with (Safa).",
    ),

    // --- General Dua at Safa and Marwah ---
    DuaModel(
      title: "Dua During Sa’i between Safa and Marwah",
      arabic: "رَبِّ اغْفِرْ وَارْحَمْ، إِنَّكَ أَنتَ الْأَعَزُّ الْأَكْرَمُ",
      translation:
          "My Lord, forgive and have mercy. Indeed, You are the Most Mighty, the Most Noble.",
    ),

    // --- Dua after Completing Sa’i ---
    DuaModel(
      title: "Dua After Completing Sa’i",
      arabic:
          "اللّهُـمَّ تَقَبَّلْ مِنِّي سَعْيِي، وَاغْفِرْ لِي ذَنْبِي، وَاجْعَلْ عَمَلِي صَالِحًا مَقْبُولًا",
      translation:
          "O Allah, accept my Sa’i, forgive my sins, and make my deeds righteous and accepted.",
    ),

    // --- Dua for Entering Mina ---
    DuaModel(
      title: "Dua When Entering Mina",
      arabic:
          "اللّهُـمَّ هَذِهِ مِنىً فَأَنِّمْ عَلَيَّ فِيهَا بِالرَّحْمَةِ وَالْمَغْفِرَةِ",
      translation:
          "O Allah, this is Mina, so bless me in it with mercy and forgiveness.",
    ),
    // --- Talbiyah (Recited Throughout Hajj/Umrah) ---
    DuaModel(
      title: "Talbiyah (Labbayk Allahumma Labbayk)",
      arabic:
          "لَبَّيْكَ اللَّهُمَّ لَبَّيْك، لَبَّيْكَ لَا شَرِيكَ لَكَ لَبَّيْك، "
          "إِنَّ الْحَمْدَ وَالنِّعْمَةَ لَكَ وَالْمُلْكَ، لَا شَرِيكَ لَك",
      translation:
          "Here I am, O Allah, here I am. Here I am, You have no partner, here I am. "
          "Verily all praise, grace, and sovereignty belong to You. You have no partner.",
    ),

    // --- Dua at Arafat ---
    DuaModel(
      title: "Dua at Arafat",
      arabic:
          "لَا إِلٰهَ إِلَّا اللهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، وَهُوَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ",
      translation:
          "There is no god but Allah alone, He has no partner. To Him belongs sovereignty and praise, and He is over all things capable.",
    ),

    // --- Dua for Forgiveness and Mercy ---
    DuaModel(
      title: "General Dua for Forgiveness",
      arabic:
          "رَبِّ اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُسْلِمِينَ يَوْمَ يَقُومُ الْحِسَابُ",
      translation:
          "My Lord, forgive me, my parents, and the believers on the Day the account is established.",
    ),
  ];

  List<DuaModel> searchDuas(String query) {
    if (query.isEmpty) return duas;
    return duas
        .where(
          (dua) =>
              dua.title.toLowerCase().contains(query.toLowerCase()) ||
              dua.translation.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }
}
// 4 kalema
// subhanallahe walhamdulillahi wala ilaha illallahu wallahu akbar wala khawla wala quwwata illa billahil aliyyil azeem
// 