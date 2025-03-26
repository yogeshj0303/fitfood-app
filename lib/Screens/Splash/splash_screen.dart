import 'dart:async';
import 'package:fit_food/Constants/export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final c = Get.put(GetController());
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      c.autoRole.value == 'Trainer'
          ? AuthUtils().trainerLogin(c.autoEmail.value, c.autoPass.value)
          : AuthUtils().authCheck(c.autoLoginPhone.value);
      c.autoRole.value == 'Trainer' ? null : SharedPrefs().getNotiCount();
      c.autoRole.value == 'Trainer'
          ? null
          : Timer.periodic(const Duration(seconds: 5), (timer) {
              HomeUtils().streamNotification(c.autologinId.value);
            });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          color: Colors.black,
          child: Image.asset(logoGreen),
        ),
      ),
    );
  }
}
