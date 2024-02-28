import 'package:flutter/material.dart';
// import 'package:expence_tracker/screen/auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // final imgurl=FirebaseAuth.instance.currentUser!.photoURL;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Account'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          // child: Column(
          // children: [
          //   const SizedBox(
          //     height: 20,
          //   ),
          //   // Container(
          //   //   height: 100,
          //   //   width: 130,
          //   //   child: ClipRRect(
          //   //     borderRadius: BorderRadius.circular(80),
          //   //     child: Image(image: NetworkImage(),),
          //   //   ),
          //   ),
          // ]
          //  ),
        ));
  }
}
