import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chats.dart';


class ChatRoom extends StatelessWidget {
  const ChatRoom({Key? key}) : super(key: key);
  static final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').orderBy('joinedAt',descending: true).snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "ChatRoom",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              if (Get.isDarkMode) {
                Get.changeThemeMode(ThemeMode.light);
              } else {
                Get.changeThemeMode(ThemeMode.dark);
              }
            },
            icon: Icon(
              Icons.nightlight_round,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState != ConnectionState.waiting) {
            print(snapshot.data?.docs.length);
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chats(email: data['email'], name: data['name'])));

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(leading:CircleAvatar(radius: 30,
                      backgroundImage: NetworkImage(
                          "https://gravatar.com/avatar/${data['email']}?s=32&d=identicon&r=PG"),),title: Text(data['email']),subtitle: Text(data['name']),),
                  ),
                );

              }).toList(),
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
