import '../../../Constants/export.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<UserData> {
  bool showPassword = true;
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final signupKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    cityController.dispose();
    super.dispose();
  }

  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: signupKey,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Image.asset(
                'assets/images/login_bottom.png',
                color: primaryColor,
                height: 200,
              ),
              Container(
                padding: const EdgeInsets.all(defaultPadding * 2),
                height: size.height,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: defaultPadding * 12),
                      Text(
                        "Let's Know you better",
                        style: Style.xLargeTextStyle,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: defaultPadding * 5),
                      textField(nameController, TextInputType.name, 'Your name',
                          Icons.account_box, false, false, false),
                      const SizedBox(height: defaultPadding),
                      textField(emailController, TextInputType.emailAddress,
                          'Your email', Icons.mail, false, true, false),
                      const SizedBox(height: defaultPadding),
                      textField(passController, TextInputType.emailAddress,
                          'Your password', Icons.security, true, false, false),
                      const SizedBox(height: defaultPadding),
                      textField(
                          cityController,
                          TextInputType.streetAddress,
                          'Your city',
                          Icons.location_city,
                          false,
                          false,
                          false),
                      const SizedBox(height: defaultPadding * 5),
                      ElevatedButton(
                        onPressed: () {
                          final isValid = signupKey.currentState!.validate();
                          if (isValid) {
                            c.name.value = nameController.text;
                            c.mail.value = emailController.text;
                            c.city.value = cityController.text;
                            c.password.value = passController.text;
                            Get.to(() => const MoreData());
                          }
                        },
                        child: Text(
                          "Next".toUpperCase(),
                          style: Style.mediumWTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController controller,
      TextInputType type,
      String hint,
      IconData iconData,
      bool isPassword,
      bool isEmail,
      bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        obscureText: isPassword ? showPassword : false,
        keyboardType: type,
        textInputAction: TextInputAction.next,
        cursorColor: primaryColor,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: showPassword
                      ? const Icon(Icons.visibility, color: primaryColor)
                      : const Icon(Icons.visibility_off, color: primaryColor),
                )
              : null,
          hintText: hint,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Icon(iconData),
          ),
        ),
        validator: (value) {
          const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
          final regExp = RegExp(pattern);
          if (isPassword) {
            if (value!.isEmpty) {
              return 'Enter password';
            } else if (value.length < 6) {
              return 'Enter atleast 6 letter password';
            }
          } else if (isEmail) {
            if (value!.isEmpty) {
              return 'Enter your E-mail';
            } else if (!regExp.hasMatch(value)) {
              return 'Enter an valid E-mail address';
            }
          } else if (isMobile) {
            if (value!.isEmpty) {
              return 'Enter your Mobile number';
            } else if (value.length != 10) {
              return 'Enter valid Mobile number';
            }
          } else {
            if (value!.isEmpty) {
              return 'This field is required';
            }
          }
          return null;
        },
      ),
    );
  }
}
