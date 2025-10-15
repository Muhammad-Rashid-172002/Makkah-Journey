import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makkahjourney/utils/app_colors.dart';
import 'package:makkahjourney/views/Check_list_Screen.dart';
import 'package:makkahjourney/views/Dua_Screen.dart';
import 'package:makkahjourney/views/Map_Screen.dart';
import 'package:makkahjourney/views/chat_screen.dart';
import 'package:makkahjourney/views/rituals_screen.dart';
import 'package:makkahjourney/views/setting_screen.dart';

final LinearGradient kPrimaryGradient = const LinearGradient(
  colors: [AppColors.primary, AppColors.accent],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);




class BottomNaviation extends StatefulWidget {
  final int initialIndex;
  const BottomNaviation({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _BottomNaviationState createState() => _BottomNaviationState();
}

class _BottomNaviationState extends State<BottomNaviation> {
  int _currentIndex = 0;
  DateTime? _lastBackPressed;

  final List<Widget> _pages = [
    const RitualsScreen(),
    const MapScreen(),
    const DuaScreen(),
    const CheckListScreen(),
    // Provide default or placeholder values for the ChatScreen parameters
    const ChatScreen(receiverId: '', receiverName: '', receiverImage: ''),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabTapped(int index) {
    setState(() => _currentIndex = index);
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
      _lastBackPressed = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Press again to exit', style: TextStyle(fontWeight: FontWeight.w500)),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exit = await _onWillPop();
        if (exit) SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.background,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.9),
                  AppColors.accent.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                currentIndex: _currentIndex,
                onTap: _onTabTapped,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white70,
                showUnselectedLabels: true,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                items: [
                  _buildNavItem(Icons.menu_book_outlined, Icons.menu_book, 'Rituals', 0),
                  _buildNavItem(Icons.map_outlined, Icons.map, 'Map', 1),
                  _buildNavItem(Icons.favorite_border, Icons.favorite, 'Duas', 2),
                  _buildNavItem(Icons.checklist_outlined, Icons.checklist, 'Checklist', 3),
                  _buildNavItem(Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat', 4),
                  _buildNavItem(Icons.settings_outlined, Icons.settings, 'Settings', 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, IconData activeIcon, String label, int index) {
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(6),
        decoration: _currentIndex == index
            ? BoxDecoration(
                gradient: kPrimaryGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : null,
        child: Icon(icon, color: _currentIndex == index ? Colors.white : Colors.white70),
      ),
      activeIcon: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(activeIcon, color: Colors.white),
      ),
      label: label,
    );
  }
}

