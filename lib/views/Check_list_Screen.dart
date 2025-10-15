import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:makkahjourney/controllers/checklist_controller.dart';
import 'package:makkahjourney/models/checklist_item.dart';
import 'package:makkahjourney/utils/app_colors.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({super.key});

  @override
  State<CheckListScreen> createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final CheckListController _controller = CheckListController();
  late List<CheckListItem> items;

  @override
  void initState() {
    super.initState();
    items = _controller.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "🕋 Hajj & Umrah Checklist",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),

      body: items.isEmpty
          ? Center(
              child: Text(
                "No items in checklist 📝",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 80), // ✅ Space for bottom nav
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: item.isDone
                          ? [const Color(0xFFE8F5E9), Colors.white]
                          : [Colors.white, const Color(0xFFF5FFF8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: item.isDone
                          ? AppColors.primary.withOpacity(0.4)
                          : AppColors.accent.withOpacity(0.2),
                      width: 1.3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 10),
                    leading: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: item.isDone
                            ? AppColors.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Icon(
                        item.isDone
                            ? Icons.check
                            : Icons.radio_button_unchecked,
                        color: item.isDone
                            ? Colors.white
                            : AppColors.primary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      item.title,
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: item.isDone
                            ? Colors.grey
                            : AppColors.textDark,
                        decoration: item.isDone
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    subtitle: Text(
                      item.description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: item.isDone
                            ? Colors.grey[500]
                            : Colors.black54,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.accent,
                      size: 18,
                    ),
                    onTap: () {
                      setState(() {
                        _controller.toggleItem(index);
                        items = _controller.items;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
