import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class RitualsScreen extends StatelessWidget {
  const RitualsScreen({super.key});

  final List<Map<String, String>> rituals = const [
    {
      "title": "Ihram",
      "desc": "Wear Ihram garments and make Niyyah (intention) for Hajj or Umrah."
    },
    {
      "title": "Tawaf",
      "desc": "Circumambulate the Kaaba seven times in an anti-clockwise direction."
    },
    {
      "title": "Sa’i",
      "desc": "Walk between Safa and Marwah hills seven times."
    },
    {
      "title": "Arafat",
      "desc": "Stand in prayer and reflection at Mount Arafat until sunset."
    },
    {
      "title": "Muzdalifah",
      "desc": "Collect pebbles and rest under the open sky after Arafat."
    },
    {
      "title": "Ramy al-Jamarat",
      "desc": "Throw stones at the pillars symbolizing the devil in Mina."
    },
    {
      "title": "Qurbani & Tawaf al-Ifadah",
      "desc": "Sacrifice an animal and perform another Tawaf."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rituals Guide"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rituals.length,
        itemBuilder: (context, index) {
          final ritual = rituals[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary,
                child: Text("${index + 1}",
                    style: const TextStyle(color: Colors.white)),
              ),
              title: Text(
                ritual["title"]!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(ritual["desc"]!),
            ),
          );
        },
      ),
    );
  }
}
