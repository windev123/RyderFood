import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatDetail extends StatefulWidget {
  final frienduid;
  final friendemail;

  ChatDetail({Key? key, this.frienduid, this.friendemail}) : super(key: key);

  @override
  _ChatDetailState createState() => _ChatDetailState(frienduid, friendemail);
}

class _ChatDetailState extends State<ChatDetail> {
  CollectionReference chats = FirebaseFirestore.instance.collection("chats");
  final frienduid;
  final friendemail;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  var chatDocId;

  _ChatDetailState(this.frienduid, this.friendemail);
  @override
  void initState() {
    super.initState();
    chats
        .where("users", isEqualTo: {frienduid: null, currentUserId: null})
        .limit(1)
        .get()
        .then(
          (QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              chatDocId = querySnapshot.docs.single.id;
            } else {
              chats.add({
                'users': {currentUserId: null, frienduid: null}
              }).then((value) => {chatDocId});
            }
          },
        )
        .catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
