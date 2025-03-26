import '../../../Constants/export.dart';

class OnBoardingScreenTwo extends StatelessWidget {
  const OnBoardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Image.asset('assets/images/login_bottom.png',
              color: const Color(0xFFD3E2AB)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Image.asset(
                onboard1,
              ),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Text(
                  'Fitfood meals provides personalized diet plan from our Experts',
                  style: TextStyle(color: Colors.black26, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () => Get.to(() =>  const LoginScreen()),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                    const Spacer(),
                    OutlinedButton(
                      onPressed: () =>
                          Get.to(() => const OnBoardingScreenThree()),
                      child: Text(
                        '   Next   ',
                        style: Style.mediumWhiteTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ],
      ),
    );
  }
}
