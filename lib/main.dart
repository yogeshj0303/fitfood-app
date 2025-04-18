import 'package:fit_food/Components/themes.dart';
import 'Constants/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: FutureBuilder(
        future: SharedPrefs().autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data == true
              ? const SplashScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}
