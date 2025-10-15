import 'package:hive/hive.dart';
import 'package:makkahjourney/models/checklist_item.dart';


class CheckListController {
  final Box _box = Hive.box('checklistBox');
  final List<CheckListItem> _defaultItems = [
    CheckListItem(
      title: "Prepare Ihram",
      description: "Ensure you have Ihram clothes and are ready to enter the state of Ihram.",
    ),
    CheckListItem(
      title: "Make Niyyah (Intention)",
      description: "Before crossing Miqat, make the intention for Hajj or Umrah.",
    ),
    CheckListItem(
      title: "Tawaf",
      description: "Perform the 7 rounds of Tawaf around the Ka'bah.",
    ),
    CheckListItem(
      title: "Sa’i between Safa and Marwah",
      description: "Walk 7 times between Safa and Marwah hills.",
    ),
    CheckListItem(
      title: "Halq or Taqsir",
      description: "Men should shave (Halq) or trim (Taqsir) their hair. Women trim slightly.",
    ),
    CheckListItem(
      title: "Perform Salah at Masjid al-Haram",
      description: "Offer prayers regularly at the Haram.",
    ),
    CheckListItem(
      title: "Visit Mina and Arafat",
      description: "Follow the rituals on the 8th and 9th of Dhul Hijjah.",
    ),
  ];

  List<CheckListItem> get items {
    final data = _box.get('items');
    if (data == null) {
      _box.put('items', _defaultItems.map((e) => e.toMap()).toList());
      return _defaultItems;
    }
    return (data as List)
        .map((map) => CheckListItem.fromMap(Map<String, dynamic>.from(map)))
        .toList();
  }

  void toggleItem(int index) {
    final data = items;
    data[index].isDone = !data[index].isDone;
    _box.put('items', data.map((e) => e.toMap()).toList());
  }
}
