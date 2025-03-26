import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Screens/AuthScreen/Login/trainer_login.dart';
import 'package:flutter/gestures.dart';
import '../../../Widgets/custom_text_field.dart';

class TrainerSignup extends StatefulWidget {
  const TrainerSignup({super.key});

  @override
  State<TrainerSignup> createState() => _TrainerSignupState();
}

class _TrainerSignupState extends State<TrainerSignup> {
  final c = Get.put(GetController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialistController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController expController = TextEditingController();
  final TextEditingController cnfpassController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final GlobalKey<FormState> signInkey = GlobalKey<FormState>();

  String selectedGender = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => c.isTrainRegLoading.value
            ? loading
            : SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding * 2),
                    child: Form(
                      key: signInkey,
                      child: Column(
                        children: [
                          const SizedBox(height: defaultPadding * 3),
                          Text(
                            "Create an account\n as Trainer",
                            style: Style.largeBoldTextStyle,
                            textAlign: TextAlign.center,
                          ),
                          Image.asset(logoGreen, height: 125),
                          CustomTextField(
                            controller: nameController,
                            hintText: 'Enter your name',
                            iconData: Icons.account_circle,
                          ),
                          CustomTextField(
                            controller: emailController,
                            hintText: 'Enter your email',
                            isEmail: true,
                            iconData: Icons.email,
                          ),
                          CustomTextField(
                            controller: mobileController,
                            hintText: 'Enter your mobile number',
                            isPhone: true,
                            iconData: Icons.phone_android,
                          ),
                          CustomTextField(
                            controller: specialistController,
                            hintText: 'Enter your field of specialization',
                            iconData: Icons.hotel_class,
                          ),
                          CustomTextField(
                            controller: cityController,
                            hintText: 'Enter your city name',
                            iconData: Icons.location_city,
                          ),
                          CustomTextField(
                            controller: expController,
                            hintText: 'Enter your no. of years of experience',
                            iconData: Icons.work_history,
                          ),
                          CustomTextField(
                            controller: passController,
                            hintText: 'Enter Password',
                            isPassword: true,
                            iconData: Icons.lock,
                          ),
                          Row(
                            children: [
                              Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                value: 'Male',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() => selectedGender = value!);
                                },
                              ),
                              Text('Male', style: Style.normalLightTextStyle),
                              Radio(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                                value: 'Female',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() => selectedGender = value!);
                                },
                              ),
                              Text('Female', style: Style.normalLightTextStyle),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          TextFormField(
                            controller: aboutController,
                            minLines: 5,
                            maxLines: 12,
                            validator: (value) => value!.isEmpty
                                ? 'About yourself is required'
                                : null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: const Icon(Icons.wb_incandescent),
                              hintStyle: Style.smallLighttextStyle,
                              hintText: 'Enter about yourself',
                              fillColor: Colors.black12,
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: defaultPadding),
                          signupButton(),
                          alreadyHaveAc(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  ElevatedButton signupButton() {
    return ElevatedButton(
      onPressed: () {
        final isValid = signInkey.currentState!.validate();
        if (isValid) {
          AuthUtils().trainerRegister(
              name: nameController.text,
              email: emailController.text,
              pass: passController.text,
              gender: selectedGender,
              city: cityController.text,
              specialist: specialistController.text,
              exp: expController.text,
              about: aboutController.text,
              mobile: mobileController.text);
        }
      },
      child: Text(
        'Sign up',
        style: Style.normalWTextStyle,
      ),
    );
  }

  RichText alreadyHaveAc() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Already have an account ?  ",
            style: Style.normalLightTextStyle,
          ),
          TextSpan(
            text: "Login",
            style: const TextStyle(
              fontSize: 16,
              color: primaryColor,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Get.to(() => TrainerLogin()),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }
}
