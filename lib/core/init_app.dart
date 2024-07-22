import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../service_locator.dart';
import 'my_observer.dart';

class InitializeApp {
  static Future run() async {
    WidgetsFlutterBinding.ensureInitialized();
    // MobileAds.instance.initialize();
    await setup();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    Bloc.observer = MyObserver();
    runApp(App());
  }
}
