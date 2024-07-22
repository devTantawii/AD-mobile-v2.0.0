import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc_providers.dart';
import 'core/constants/langCode.dart';
import 'core/init_app.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await InitializeApp.run();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
    statusBarColor:  Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ),
  );
  ///----------------StartFirebase Code -------------------
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      name: 'abudiyab',
      options: const FirebaseOptions(
        apiKey: "AIzaSyCec8SdOopL4_byJ6_113JfaLyL_1VKFm0",
        appId: "1:1092780024078:ios:6274a163218d2a9ba4375f",
        messagingSenderId: "1092780024078",
        projectId: "abudiyab-ab965",
      ),
    );
    firebaseMessaging.requestPermission(
      alert:true,
      announcement:false,
      badge:true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }else{
    await Firebase.initializeApp();
  }
  await Future.delayed(Duration(seconds:2));
  //String ? fireToken;
  if(Platform.isIOS){
    await Future<void>.delayed(
      const Duration(seconds: 3,),
    );
    await FirebaseMessaging.instance.getAPNSToken().then((value) {
      deviceToken = value;
    });
  }else{
    await FirebaseMessaging.instance.getToken().then((value) {
      deviceToken = value;
    });
  }
  FirebaseMessaging.onMessage.listen((event) {});
  FirebaseMessaging.onMessageOpenedApp.listen((event) {}
  );
  ///----------------- END Firebase Code -----------------
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {

    super.initState();
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widget) {
          return CreateBlocProviders(context);
        });
  }
}
