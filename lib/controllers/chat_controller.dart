import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:makkahjourney/models/chat_message.dart';


class ChatController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get messages for a specific chat room
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatMessage.fromMap(doc.data())).toList());
  }

  /// Send a message (text, image, or location)
  Future<void> sendMessage(String chatId, ChatMessage message) async {
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add(message.toMap());

    // ✅ Optionally update last message info for chat list
    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': message.message,
      'lastSenderName': message.senderName,
      'lastSenderImage': message.senderImage,
      'lastMessageType': message.type,
      'timestamp': message.timestamp.millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }

  /// Create or get a chat ID between two users
  String generateChatId(String userId1, String userId2) {
    // Sort alphabetically so both users get the same chatId
    final sorted = [userId1, userId2]..sort();
    return "${sorted[0]}_${sorted[1]}";
  }
}
