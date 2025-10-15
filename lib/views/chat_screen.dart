import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:makkahjourney/controllers/chat_controller.dart';
import 'package:makkahjourney/models/chat_message.dart';
import 'package:makkahjourney/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String receiverImage;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController _chatController = ChatController();
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? currentUserId;
  String? currentUserName;
  String? currentUserImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('Users').doc(user.uid).get();
      setState(() {
        currentUserId = user.uid;
        currentUserName = doc['name'];
        currentUserImage = doc['profileImage'];
      });
    }
  }

  Future<void> _sendTextMessage() async {
    if (_msgController.text.trim().isEmpty || currentUserId == null) return;

    final chatId =
        _chatController.generateChatId(currentUserId!, widget.receiverId);

    final message = ChatMessage(
      senderId: currentUserId!,
      senderName: currentUserName ?? "Unknown",
      senderImage: currentUserImage ?? "",
      message: _msgController.text.trim(),
      type: "text",
      timestamp: DateTime.now(),
    );

    await _chatController.sendMessage(chatId, message);
    _msgController.clear();
  }

  Future<void> _sendImageMessage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null || currentUserId == null) return;

    final chatId =
        _chatController.generateChatId(currentUserId!, widget.receiverId);

    final ref = FirebaseStorage.instance
        .ref()
        .child('chat_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await ref.putFile(File(pickedFile.path));
    final imageUrl = await ref.getDownloadURL();

    final message = ChatMessage(
      senderId: currentUserId!,
      senderName: currentUserName ?? "Unknown",
      senderImage: currentUserImage ?? "",
      message: imageUrl,
      type: "image",
      timestamp: DateTime.now(),
    );

    await _chatController.sendMessage(chatId, message);
  }

  Future<void> _sendLocationMessage() async {
    final location = Location();
    final currentLocation = await location.getLocation();

    final lat = currentLocation.latitude;
    final lng = currentLocation.longitude;

    final chatId =
        _chatController.generateChatId(currentUserId!, widget.receiverId);

    final message = ChatMessage(
      senderId: currentUserId!,
      senderName: currentUserName ?? "Unknown",
      senderImage: currentUserImage ?? "",
      message: "https://www.google.com/maps?q=$lat,$lng",
      type: "location",
      timestamp: DateTime.now(),
    );

    await _chatController.sendMessage(chatId, message);
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final chatId =
        _chatController.generateChatId(currentUserId!, widget.receiverId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.receiverImage.isNotEmpty
                  ? NetworkImage(widget.receiverImage)
                  : null,
              child: widget.receiverImage.isEmpty
                  ? const Icon(Icons.person)
                  : null,
            ),
            const SizedBox(width: 8),
            Text(widget.receiverName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: _chatController.getMessages(chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == currentUserId;

                    return Align(
                      alignment:
                          isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isMe
                              ? AppColors.primary.withOpacity(0.9)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: msg.type == "image"
                            ? Image.network(msg.message, width: 180)
                            : msg.type == "location"
                                ? InkWell(
                                    onTap: () async {
                                      final Uri url = Uri.parse(msg.message);
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url,
                                            mode: LaunchMode
                                                .externalApplication);
                                      }
                                    },
                                    child: const Text(
                                      "📍 Shared Location",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    ),
                                  )
                                : Text(
                                    msg.message,
                                    style: TextStyle(
                                      color: isMe
                                          ? Colors.white
                                          : AppColors.textDark,
                                      fontSize: 16,
                                    ),
                                  ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.image, color: AppColors.primary),
              onPressed: _sendImageMessage,
            ),
            IconButton(
              icon: const Icon(Icons.location_on, color: AppColors.primary),
              onPressed: _sendLocationMessage,
            ),
            Expanded(
              child: TextField(
                controller: _msgController,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: AppColors.primary),
              onPressed: _sendTextMessage,
            ),
          ],
        ),
      ),
    );
  }
}
