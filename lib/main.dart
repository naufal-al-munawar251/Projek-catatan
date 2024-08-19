import 'package:aplikasi_catatan/Feature/Home/pages/HomePages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

import 'Config/ConfigurasiNotif.dart';
import 'Config/DefaultFirebaseOptions.dart';
import 'Config/ServiceConfig.dart';
import 'Feature/Login/pages/LoginPages.dart';


@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async{
    print("Native called background task: $task");
    ConfigNotif.showNotif(title: "Pengingat Catatan", body: inputData?["title"], payload: "Sholat");
    return Future.value(true);
  });
}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemStatusBarContrastEnforced: false,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarContrastEnforced: false
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  startService();
  Workmanager().initialize(
      callbackDispatcher
  );
  await ConfigNotif.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false
      ),
      home: LoginPage(),
    );
  }

}