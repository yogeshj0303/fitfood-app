import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Screens/AuthScreen/Login/trainer_login.dart';
import 'package:flutter/gestures.dart';
import '../../../Widgets/custom_text_field.dart';
import 'package:fit_food/Constants/indian_location.dart';

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
  final TextEditingController expController = TextEditingController();
  final TextEditingController cnfpassController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final GlobalKey<FormState> signInkey = GlobalKey<FormState>();

  String selectedGender = 'Male';
  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;
  RxList<String> cities = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
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
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.black,
                            ),
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
                          Obx(() => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Get.isDarkMode ? Colors.grey[850] : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_city, 
                                        color: Get.isDarkMode ? Colors.white70 : Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select State',
                                        style: TextStyle(
                                          color: Get.isDarkMode ? Colors.white70 : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: selectedState.value.isEmpty ? null : selectedState.value,
                                items: IndianLocation.states.map((String state) {
                                  return DropdownMenuItem<String>(
                                    value: state,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        state,
                                        style: TextStyle(
                                          color: Get.isDarkMode ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedState.value = newValue;
                                    cities.value = IndianLocation.getDistricts(newValue);
                                    selectedCity.value = '';
                                  }
                                },
                              ),
                            ),
                          )),
                          Obx(() => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Get.isDarkMode ? Colors.grey[850] : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_city, 
                                        color: Get.isDarkMode ? Colors.white70 : Colors.grey[600],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        'Select City',
                                        style: TextStyle(
                                          color: Get.isDarkMode ? Colors.white70 : Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: selectedCity.value.isEmpty ? null : selectedCity.value,
                                items: cities.map((String city) {
                                  return DropdownMenuItem<String>(
                                    value: city,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        city,
                                        style: TextStyle(
                                          color: Get.isDarkMode ? Colors.white : Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    selectedCity.value = newValue;
                                  }
                                },
                              ),
                            ),
                          )),
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
                                activeColor: primaryColor,
                              ),
                              Text(
                                'Male',
                                style: TextStyle(
                                  color: Get.isDarkMode
                                      ? Colors.white70
                                      : Colors.black87,
                                ),
                              ),
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
                              Text(
                                'Female',
                                style: Style.normalLightTextStyle,
                              ),
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
                              prefixIcon: Icon(
                                Icons.wb_incandescent,
                                color: Get.isDarkMode
                                    ? Colors.white70
                                    : Colors.black87,
                              ),
                              hintStyle: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white70
                                    : Colors.black54,
                              ),
                              hintText: 'Enter about yourself',
                              fillColor: Get.isDarkMode
                                  ? Colors.white12
                                  : Colors.black12,
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
        if (isValid && selectedState.value.isNotEmpty && selectedCity.value.isNotEmpty) {
          AuthUtils().trainerRegister(
              name: nameController.text,
              email: emailController.text,
              pass: passController.text,
              gender: selectedGender,
              city: selectedCity.value,
              specialist: specialistController.text,
              exp: expController.text,
              about: aboutController.text,
              mobile: mobileController.text);
        } else {
          Fluttertoast.showToast(msg: 'Please fill all fields');
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
