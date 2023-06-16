import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hi_dokter/app/theme/widget_themes/theme.dart';

import 'app/database/authentication/authentication_repository.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  myApp();
}

void myApp() {
  return runApp(
    GetMaterialApp(
      title: "Application",
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const CircularProgressIndicator(),
    ),
  );
}
