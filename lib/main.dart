import 'package:fit_food/Components/themes.dart';
import 'Constants/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );
  if (await Permission.notification.isDenied) {
    Permission.notification.request();
  }
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: FutureBuilder(
        future: SharedPrefs().autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return const SplashScreen();
            } else {
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
