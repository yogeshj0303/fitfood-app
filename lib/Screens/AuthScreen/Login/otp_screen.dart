// ignore_for_file: avoid_print

import 'package:fit_food/Constants/export.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  const OtpScreen({super.key, required this.number});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();

  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    super.dispose();
  }

  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    print(c.otp.value);
    return Scaffold(
      body: Obx(
        () => c.isRegLoading.value
            ? loading
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Let's verify your\nphone number ",
                      style: Style.largeTextStyle, textAlign: TextAlign.center),
                  const SizedBox(height: 35),
                  SizedBox(
                    width: 250,
                    child: Text(
                      'We have sent an SMS to your whatsapp with a code to a number',
                      style: Style.normalLightTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text('+91 ${widget.number}', style: Style.mediumTextStyle),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildOtpBox(context, c1),
                      buildOtpBox(context, c2),
                      buildOtpBox(context, c3),
                      buildOtpBox(context, c4),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the OTP ?",
                        style: Style.smallLighttextStyle,
                      ),
                      TextButton(
                          onPressed: () => AuthUtils().sendOtp(widget.number),
                          child: const Text('Resend ')),
                    ],
                  ),
                  Obx(
                    () => c.isAuthLoading.value
                        ? loading
                        : GestureDetector(
                            onTap: () {
                              String input =
                                  c1.text + c2.text + c3.text + c4.text;
                              if (c.otp.value.toString() == input) {
                                Fluttertoast.showToast(
                                    msg: 'OTP Verified successfully');
                                c.phone.value = widget.number;
                                AuthUtils().authCheck(widget.number);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Incorrect OTP, Please try again');
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                'Verify Number',
                                style: Style.mediumWhiteTextStyle,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget buildOtpBox(BuildContext context, TextEditingController controller) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          hintText: '',
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: greyColor),
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (c4.text.length == 1) {
            FocusScope.of(context).unfocus();
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
