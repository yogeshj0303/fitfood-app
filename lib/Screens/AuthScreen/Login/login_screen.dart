import 'package:fit_food/Screens/AuthScreen/Login/trainer_login.dart';
import '../../../Constants/export.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneController = TextEditingController();
  final c = Get.put(GetController());
  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      if (phoneController.text.length == 10) {
        FocusScope.of(context).nextFocus();
      }
    });
  }

  @override
  void dispose() {
    phoneController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: size.height / 3,
              decoration: const BoxDecoration(
                borderRadius: bottomCircular,
                image: DecorationImage(
                  image: AssetImage(delivBoy),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding * 3),
              child: Text(
                'Making India a healthier place',
                style: Style.largeBoldTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(defaultRadius),
                      topRight: Radius.circular(defaultRadius)),
                  color: c.isDarkTheme.value ? blackColor : whiteColor,
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(2, 2),
                      blurRadius: 6,
                      color: Colors.grey,
                    )
                  ],
                ),
                child: Obx(
                  () => c.isAuthLoading.value
                      ? loading
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              buildDivider(),
                              buildLogin(),
                              buildOtherLogin(),
                            ],
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding * 2),
      child: Text('LOGIN OR SIGNUP ', style: Style.normalLightTextStyle),
    );
  }

  Widget buildLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding * 2, vertical: defaultPadding / 2),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(flagIcon, height: 40, width: 60, fit: BoxFit.cover),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Enter Mobile Number',
                    prefixIcon:
                        const Icon(Icons.phone_android, color: blackGrey),
                    hintStyle: Style.smallLighttextStyle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            tileColor: bgColor,
            title: Text(
              'I agree to Terms of service and Privacy Policy',
              style: Style.smallLighttextStyle,
            ),
            value: isAgree,
            onChanged: (val) => setState(() => isAgree = val!),
          ),
          InkWell(
            onTap: () {
              if (phoneController.text.length == 10 && isAgree) {
                final mob = phoneController.text;
                AuthUtils().sendOtp(mob);
              } else {
                isAgree
                    ? Fluttertoast.showToast(
                        msg: 'Please enter 10 digit valid phone number')
                    : Fluttertoast.showToast(
                        msg:
                            'Please accept our Terms of service and Privacy Policy');
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: defaultMargin),
              width: double.infinity,
              height: 40,
              decoration: buttonDecor,
              child: Text(
                'Agree & Continue',
                style: Style.normalWTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtherLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: Divider(color: greyColor, thickness: 1),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('OR', style: Style.normalLightTextStyle),
              ),
              const Expanded(
                child: Divider(color: greyColor, thickness: 1),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildSocialButton(
            icon: googleIcon,
            label: 'Login using Google',
            onTap: () {
              // Add Google login logic here
            },
          ),
          const SizedBox(height: 16),
          _buildSocialButton(
            icon: nutritionist,
            label: 'Continue as Trainer',
            onTap: () => Get.to(() => TrainerLogin()),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: c.isDarkTheme.value ? darkGrey : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: greyColor.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: Style.normalLightTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
