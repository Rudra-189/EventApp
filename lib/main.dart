import 'package:event_project_01/routes/appRoutes.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/utils/notification.dart';
import 'package:event_project_01/views/auth/splash_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

class PermissionService {
  static Future<void> requestAllPermissions() async {
    await [
      Permission.camera,
      Permission.notification,
    ].request();
  }
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await PermissionService.requestAllPermissions();
  await NotificationService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: splashScreen(),
      initialRoute: appRoutesName.initialScreen,
      getPages: appRoutes.getRouts,
    );
  }
}
