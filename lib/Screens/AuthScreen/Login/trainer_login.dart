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
      backgroundColor: Colors.white,
      body: Obx(
        () => c.isTrainRegLoading.value
            ? loading
            : Padding(
                padding: const EdgeInsets.all(defaultPadding * 2),
                child: Form(
                  key: loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Trainer's Login",
                        style: Style.largeBoldTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: defaultPadding * 3),
                      Image.asset(nutritionist, height: 145),
                      CustomTextField(
                        controller: mailController,
                        hintText: 'Enter your email',
                        iconData: Icons.mail,
                        isEmail: true,
                      ),
                      CustomTextField(
                        controller: passController,
                        hintText: 'Enter your password',
                        iconData: Icons.security,
                        isPassword: true,
                      ),
                      const SizedBox(height: defaultPadding),
                      forgetPass(),
                      const SizedBox(height: defaultPadding * 2),
                      loginButton(),
                      const SizedBox(height: defaultPadding * 2),
                      donthaveAccount(),
                    ],
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
            style: Style.normalColorTextStyle,
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
      icon: const Icon(
        Icons.login,
        color: Colors.white,
      ),
      label: Text(
        "Login",
        style: Style.normalWTextStyle,
      ),
    );
  }

  RichText donthaveAccount() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don't have an account yet?  ",
            style: Style.normalLightTextStyle,
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
