import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final messageController = TextEditingController();

  // Replace with actual user or chat ID
  String chatId = 'your_chat_id';
  String? currentSenderId; // Track the current message sender ID

  // Function to send a message
  void _sendMessage(String message) async {
    if (message.isNotEmpty) {
      final user = _auth.currentUser;

      // Fetch user's name from Firestore
      final userName = await fetchUserName(user!.uid);

      final messageData = {
        'text': message,
        'sender': user.uid,
        'senderName': userName, // Include sender's name
        'timestamp': Timestamp.now(),
      };

      await _firestore.collection('chats').doc(chatId).collection('messages').add(messageData);
      messageController.clear();
    }
  }

  // Stream to listen for new messages
  Stream<QuerySnapshot> _getMessages() {
    return _firestore.collection('chats').doc(chatId).collection('messages').orderBy('timestamp').snapshots();
  }

  // Function to get user name from UID
  Future<String?> fetchUserName(String userId) async {
    final userDoc = await _firestore.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return userDoc['name'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _getMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      final messages = snapshot.data!.docs.reversed;
                      return ListView.builder(
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final messageData = messages.elementAt(index).data() as Map<String, dynamic>;
                          final senderId = messageData['sender'] as String;
                          final isCurrentUser = senderId == _auth.currentUser?.uid;

                          // Get sender's name asynchronously
                          return FutureBuilder<String?>(
                            future: fetchUserName(senderId),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching sender's name
                              }

                              if (snapshot.hasError || snapshot.data == null) {
                                return ChatBubble(
                                  message: messageData['text'],
                                  senderName: 'Unknown Sender',
                                  senderId: senderId,
                                  isCurrentUser: isCurrentUser,
                                );
                              }

                              final senderName = snapshot.data!;

                              return ChatBubble(
                                message: messageData['text'],
                                senderName: senderName,
                                senderId: senderId,
                                isCurrentUser: isCurrentUser,
                              );
                            },
                          );
                        },
                      );
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 12.0), // Add padding from the bottom
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _sendMessage(messageController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String? senderName;
  final String senderId; // Add sender ID
  final bool isCurrentUser;

  const ChatBubble({
    required this.message,
    required this.senderName,
    required this.senderId, // Update constructor
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (senderName != null) // Display sender name if available
          Text(
            'From: ${senderName!} ', // Display sender's name and ID
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5, bottom: 5, left: isCurrentUser ? 50 : 10, right: isCurrentUser ? 10 : 50),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue[100] : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(message),
        ),
      ],
    );
  }
}
