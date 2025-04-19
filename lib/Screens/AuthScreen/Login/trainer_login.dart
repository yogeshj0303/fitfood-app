import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Screens/AuthScreen/Login/trainer_signup.dart';
import 'package:fit_food/Widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';

class TrainerLogin extends StatelessWidget {
  TrainerLogin({super.key});
  final c = Get.put(GetController());
  final mailController = TextEditingController();
  final passController = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
      body: SafeArea(
        child: Obx(
          () => c.isTrainRegLoading.value
              ? loading
              : Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding,
                      ),
                      child: Form(
                        key: loginKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: defaultPadding * 2),
                              child: Image.asset(nutritionist, height: 160),
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            Text(
                              "Trainer's Login",
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: defaultPadding * 3),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.grey[850]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomTextField(
                                controller: mailController,
                                hintText: 'Enter your email',
                                iconData: Icons.mail,
                                isEmail: true,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? Colors.grey[850]
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: CustomTextField(
                                controller: passController,
                                hintText: 'Enter your password',
                                iconData: Icons.security,
                                isPassword: true,
                              ),
                            ),
                            const SizedBox(height: defaultPadding),
                            forgetPass(),
                            const SizedBox(height: defaultPadding * 2),
                            SizedBox(
                              width: double.infinity,
                              child: loginButton(),
                            ),
                            const SizedBox(height: defaultPadding * 2),
                            donthaveAccount(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Row forgetPass() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () => Get.to(() {}),
          child: Text(
            "Forgot Password ?",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 14,
              color: primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton loginButton() {
    return ElevatedButton.icon(
      onPressed: () {
        final isValid = loginKey.currentState!.validate();
        if (isValid) {
          AuthUtils().trainerLogin(mailController.text, passController.text);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: const Icon(Icons.login, color: Colors.white),
      label: const Text(
        "Login",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  RichText donthaveAccount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account yet?  ",
            style: TextStyle(
              fontSize: 14,
              color: Get.isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              color: primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => const TrainerSignup()),
          )
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
