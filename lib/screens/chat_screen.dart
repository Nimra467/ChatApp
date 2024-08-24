import 'package:chatapp/screens/chatdetail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chats').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final chatDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage('Assets/images/naxient.jpg')),
                title: Text(chatDocs[index]['userName']),
                subtitle: Text(chatDocs[index]['lastMessage']),
                trailing: Text(chatDocs[index]['timestamp']),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatDetailScreen(
                      chatDocs[index].id,
                    ),
                  ));
                },
                shape: LinearBorder(side: BorderSide(color: Colors.grey))),
          );
        },
      ),
    );
  }
}
