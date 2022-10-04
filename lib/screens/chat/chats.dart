import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
class Chats extends StatelessWidget {
  String email;
  String name;
   Chats({required this.email, required this.name});
   TextEditingController messageController=TextEditingController();
   ScrollController scrollController=ScrollController();
    int dataLength=0;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.height * 0.09),
        child:
        AppBar(
          leadingWidth: 100,
          leading:  Padding(
            padding:
            EdgeInsets.only(top: 4, bottom: 4, left: 0, right: 0),
            child: Row(

              mainAxisSize: MainAxisSize.min,
              children:  [
                IconButton(onPressed: (){
                  Get.back();
                }, icon: Icon(Icons.arrow_back,),color: Theme.of(context).iconTheme.color,),
                 CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                      "https://gravatar.com/avatar/${email}}?s=32&d=identicon&r=PG"),
                ),
              ],
            ),
          ),

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:   [
              Text(name,style: TextStyle(color: Theme.of(context).iconTheme.color),),
              Text(
                email,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          centerTitle: false,
          elevation: 4,
          automaticallyImplyLeading: true,

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),

        ),
      ),
      body:  Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(

          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('chats').doc(email).collection(email).orderBy('dateTime').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  if (scrollController.hasClients) {
                    scrollController.jumpTo(scrollController.position.maxScrollExtent);
                  }
                });
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }


                if (snapshot.connectionState == ConnectionState.waiting) {

                  return Text("Loading");
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 72),
                  child: ListView(
                    controller: scrollController,




                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;




                      return ListTile(
                        title: Bubble(
                          margin: BubbleEdges.only(top: 10),
                          alignment:data['sender']==0? Alignment.topRight:Alignment.topLeft,
                          nipWidth: 8,
                          nipHeight: 24,
                          nip: data['sender']==1?BubbleNip.leftTop:BubbleNip.rightTop,
                          color: data['sender']==0?  Color(0xFF25D366): const Color(0xFF075E54),
                          child: data['message']!=null?Text(data['message'],):const Text("No message yet!"),
                        ),



                      );

                    }).toList(),

                  ),
                );


              },
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            //minWidth: ,
                            //maxWidth: ,
                            minHeight: 25.0,
                            maxHeight: 150.0,
                          ),
                          child: Scrollbar(
                            child: TextField(
                              controller: messageController,
                              cursorColor: Colors.red,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,

                              //controller: tc,
                              // _handleSubmitted : null,
                              decoration: InputDecoration(
                                //prefixIcon: IconButton(icon: Icon(Icons.mood,color: Colors.amber,),onPressed: (){},),

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                fillColor: Colors.grey.shade800,
                                filled: true,
                                contentPadding: const EdgeInsets.only(
                                    top: 30.0, left: 13.0, right: 13.0, bottom: 2.0),
                                hintText: "Type your message",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 20,
                      child: Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.send,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (messageController.text.isNotEmpty) {
                                FirebaseHelper.addMessage(email, messageController.text.toString());
                                messageController.text = "";
                              }

                            },
                          )),
                    )
                  ],
                ),
              ),
            )



          ],
        ),
      ),

      resizeToAvoidBottomInset: true,

    );
  }
}
