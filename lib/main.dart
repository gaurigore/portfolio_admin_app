import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:protfolio_admin_app/Themes/thems.dart';
import 'package:protfolio_admin_app/firebase/firebase_helper.dart';
import 'package:protfolio_admin_app/notifications/flutter_local_notification_service.dart';
import 'package:protfolio_admin_app/screens/chat/chat_room.dart';
import 'package:protfolio_admin_app/screens/home/home.dart';
import 'package:protfolio_admin_app/screens/startup_screens/signin.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print(message.notification!.title);
  if (message.data != null) {
    Get.to(() => ChatRoom());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FlutterLocalNotificationsService.initialiZe();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");



  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
     await FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
       if(message!=null) {
         Get.to(() => const ChatRoom());
       }

     });

     //when app is on forground
     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      FlutterLocalNotificationsService.display(message);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((message){
      //final routeFromMessage=message.data['route'];
      Get.to(()=>ChatRoom());

    });
  }
  Future<void> setupToken() async {
    // Get the token each time the application loads
    String? token = await FirebaseMessaging.instance.getToken();

    // Save the initial token to the database
    await  FirebaseHelper.saveTokenToDatabase(token!);

    // Any time the token refreshes, store this in the database too.
    FirebaseMessaging.instance.onTokenRefresh.listen(FirebaseHelper.saveTokenToDatabase);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     setupInteractedMessage();
    setupToken();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: FirebaseAuth.instance.currentUser != null
          ? const Home()
          : const SingIn(),
    );
  }
}
