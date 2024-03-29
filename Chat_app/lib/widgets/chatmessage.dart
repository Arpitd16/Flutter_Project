import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/widgets/messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chatmessage extends StatelessWidget {
  const Chatmessage({super.key});

  @override
  Widget build(BuildContext context) {
    final Authenticuser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatsnapshot) {
        if (chatsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatsnapshot.hasData || chatsnapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('no message found'),
          );
        }
        if (chatsnapshot.hasError) {
          return const Center(
            child: Text('error occured'),
          );
        }
        final loadedmessages = chatsnapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 13,
            right: 13,
          ),
          reverse: true,
          itemCount: loadedmessages.length,
          itemBuilder: (ctx, index) {
            final chatmessage = loadedmessages[index].data();
            final nextmessage = index + 1 < loadedmessages.length
                ? loadedmessages[index + 1].data()
                : null;

            final currentuserid = chatmessage['userId'];
            final nextmessageuserid =
                nextmessage != null ? nextmessage['userId'] : null;

            final nextusersame = nextmessageuserid == currentuserid;

            if (nextusersame) {
              return MessageBubble.next(
                  message: chatmessage['text'],
                  isMe: Authenticuser.uid == currentuserid);
            } else {
              return MessageBubble.first(
                userImage: chatmessage['userimage'],
                username: chatmessage['username'],
                message: chatmessage['text'],
                isMe: Authenticuser.uid == currentuserid,
              );
            }
          },
        );
      },
    );
  }
}
