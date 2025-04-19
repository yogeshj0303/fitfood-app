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
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height / 3.5,
                  decoration: const BoxDecoration(
                    borderRadius: bottomCircular,
                    image: DecorationImage(
                      image: AssetImage(delivBoy),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(defaultPadding * 2),
                  child: Text(
                    'Making India a healthier place',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode ? Colors.white : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultRadius),
                    color: Get.isDarkMode ? Colors.grey[850] : whiteColor,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(2, 2),
                        blurRadius: 6,
                        color: Get.isDarkMode
                            ? Colors.black12
                            : Colors.grey.withOpacity(0.3),
                      )
                    ],
                  ),
                  child: Obx(
                    () => c.isAuthLoading.value
                        ? loading
                        : Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                buildDivider(),
                                buildLogin(),
                                buildOtherLogin(),
                              ],
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
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
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Get.isDarkMode ? Colors.grey[800] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Add this
              children: [
                Image.asset(flagIcon, height: 30, width: 45, fit: BoxFit.cover),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black87,
                      fontSize: 16, // Add consistent font size
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, // Add vertical padding
                        horizontal: 8,
                      ),
                      border: InputBorder.none,
                      hintText: 'Enter Mobile Number',
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                        size: 20,
                      ),
                      prefixIconConstraints: const BoxConstraints(
                        // Add constraints
                        minWidth: 40,
                        minHeight: 40,
                      ),
                      hintStyle: TextStyle(
                        color: Get.isDarkMode ? Colors.white70 : Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Theme(
            data: Theme.of(context).copyWith(
              unselectedWidgetColor:
                  Get.isDarkMode ? Colors.white70 : Colors.black54,
            ),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                'I agree to Terms of service and Privacy Policy',
                style: TextStyle(
                  fontSize: 13,
                  color: Get.isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              value: isAgree,
              onChanged: (val) => setState(() => isAgree = val!),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (phoneController.text.length == 10 && isAgree) {
                AuthUtils().sendOtp(phoneController.text);
              } else {
                isAgree
                    ? Fluttertoast.showToast(
                        msg: 'Please enter 10 digit valid phone number')
                    : Fluttertoast.showToast(
                        msg:
                            'Please accept our Terms of service and Privacy Policy');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Agree & Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
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
          // const SizedBox(height: 24),
          // _buildSocialButton(
          //   icon: googleIcon,
          //   label: 'Login using Google',
          //   onTap: () {
          //     // Add Google login logic here
          //   },
          // ),
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
          color: Get.isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Get.isDarkMode ? Colors.white24 : Colors.black12,
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
              style: TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
