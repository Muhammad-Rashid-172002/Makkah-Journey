class ChatMessage {
  final String senderId;
  final String senderName;
  final String senderImage;
  final String message;
  final String type; // text, image, location
  final DateTime timestamp;

  ChatMessage({
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.message,
    required this.type,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderName': senderName,
      'senderImage': senderImage,
      'message': message,
      'type': type,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['senderId'],
      senderName: map['senderName'],
      senderImage: map['senderImage'],
      message: map['message'],
      type: map['type'],
      timestamp:
          DateTime.fromMillisecondsSinceEpoch(map['timestamp']),
    );
  }
}
