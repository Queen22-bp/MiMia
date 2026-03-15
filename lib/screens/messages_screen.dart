import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagesScreen extends StatefulWidget {
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController msgController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  void sendMessage() async {
    if (msgController.text.isEmpty) return;
    await _firestore.collection('messages').add({
      'text': msgController.text.trim(),
      'sender': FirebaseAuth.instance.currentUser!.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
    msgController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Messages')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                final messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return ListTile(
                      title: Text(msg['text']),
                      subtitle: Text(msg['sender'] ?? ''),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(controller: msgController, decoration: InputDecoration(labelText: 'Message')),
                ),
                IconButton(icon: Icon(Icons.send), onPressed: sendMessage, color: Colors.purple),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
