import 'package:flutter/material.dart';
import 'package:makkahjourney/utils/app_colors.dart';
import 'package:makkahjourney/views/Check_list_Screen.dart';
import 'package:makkahjourney/views/Dua_Screen.dart';
import 'package:makkahjourney/views/Map_Screen.dart';
import 'package:makkahjourney/views/rituals_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> features = [
      {
        'title': 'Rituals Guide',
        'icon': Icons.menu_book_rounded,
        'color': Colors.green.shade700,
        'page': const RitualsScreen(),
      },
      {
        'title': 'Holy Map',
        'icon': Icons.map_rounded,
        'color': Colors.blue.shade600,
        'page': const MapScreen(),
      },
      {
        'title': 'Dua Collection',
        'icon': Icons.auto_awesome_rounded,
        'color': Colors.amber.shade700,
        'page': const DuaScreen(),
      },
      {
        'title': 'Preparation Checklist',
        'icon': Icons.checklist_rounded,
        'color': Colors.teal.shade600,
        'page': const CheckListScreen(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hajj & Umrah Companion"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final item = features[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item['page']),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [item['color'], item['color'].withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: item['color'].withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], color: Colors.white, size: 50),
                  const SizedBox(height: 10),
                  Text(
                    item['title'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
