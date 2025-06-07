import 'package:intl/intl.dart';
import '../../../Constants/export.dart';

class MoreData extends StatefulWidget {
  const MoreData({super.key});

  @override
  State<MoreData> createState() => _MoreDataState();
}

class _MoreDataState extends State<MoreData> {
  double weight = 50.0;
  double height = 120.0;
  bool isMale = false;
  String dob = '';
  final c = Get.put(GetController());
  bool isLbs = false;
  bool isFeet = true;
  @override
  Widget build(BuildContext context) {
    String wtValue = weight.toString().split('.').first;
    String wtInLbs = (weight * 2.20462).toString().split('.').first;
    String htValue = height.toString().split('.').first;
    int feet = (height / 30.48).floor();
    int inches = (((height / 30.48) - feet) * 12).round();
    String htInFeet = "$feet'$inches\"";
    String htInDecimalFeet = (height / 30.48).toStringAsFixed(1);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(
              vertical: defaultPadding * 2),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildWeightSlider(wtValue, wtInLbs),
                  buildHeightSlider(htValue, htInFeet),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: Text("What's your Gender?", style: Style.normalLightTextStyle),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  maleBox(),
                  femaleBox(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: Text("What's your Date of birth?", style: Style.normalLightTextStyle),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: BlurryContainer(
                  width: size.width,
                  blur: 15,
                  color: primaryColor,
                  child: IconButton(
                    splashRadius: 50,
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MMM-yyyy').format(pickedDate);
                        setState(() {
                          dob = formattedDate;
                        });
                      }
                    },
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month, color: whiteColor),
                        const SizedBox(width: 10),
                        dob == ''
                            ? Text('DD/MM/YYYY', style: Style.normalWhiteTextStyle)
                            : Text(dob, style: Style.normalWTextStyle)
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: Text(
                  "We use all this information to calculate and provide you with daily personal recommendations.",
                  style: Style.smallLighttextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
                child: customButton(
                  label: 'Next',
                  size: size,
                  onPressed: () {
                    if (dob != '') {
                      Fluttertoast.showToast(msg: 'Data saved');
                      c.weight.value = wtValue;
                      c.height.value = htInDecimalFeet;
                      c.gender.value = isMale ? 'Male' : 'Female';
                      c.dob.value = dob;
                      Get.to(() => DietPreference());
                    } else {
                      Fluttertoast.showToast(msg: 'Please provide us DOB');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget maleBox() {
    return BlurryContainer(
      height: 100,
      width: 100,
      color: isMale ? primaryColor : Colors.black26,
      child: Container(
        decoration: isMale
            ? BoxDecoration(borderRadius: BorderRadius.circular(20))
            : const BoxDecoration(),
        child: IconButton(
          splashRadius: 50,
          splashColor: Colors.blue,
          onPressed: () {
            setState(() {
              isMale = !isMale;
            });
          },
          icon: Image.asset(
            'assets/icons/male.png',
          ),
        ),
      ),
    );
  }

  Widget femaleBox() {
    return BlurryContainer(
      height: 100,
      width: 100,
      color: isMale ? Colors.black26 : primaryColor,
      child: Container(
        decoration: isMale
            ? const BoxDecoration()
            : BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: IconButton(
          splashRadius: 50,
          splashColor: Colors.pink,
          onPressed: () {
            setState(() {
              isMale = !isMale;
            });
          },
          icon: Image.asset(
            'assets/icons/female.png',
          ),
        ),
      ),
    );
  }

  Widget buildWeightSlider(String wtValue, String wtInLbs) {
    return BlurryContainer(
      blur: 10,
      child: Column(
        children: [
          const SizedBox(height: 8),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
              customColors: CustomSliderColors(
                dotColor: whiteColor,
                trackColor: whiteColor,
                progressBarColors: [
                  primaryColor,
                  primaryColor,
                ],
              ),
            ),
            initialValue: 40,
            min: 0,
            max: 150,
            onChange: (double value) {
              setState(() {
                weight = value;
              });
            },
            innerWidget: (percentage) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLbs
                    ? Text(wtInLbs, style: Style.normalLightTextStyle)
                    : Text(wtValue, style: Style.normalLightTextStyle),
              ],
            ),
          ),
          Text("What's your weight?", style: Style.normalLightTextStyle),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget buildHeightSlider(String htValue, String htInFeet) {
    return BlurryContainer(
      blur: 10,
      child: Column(
        children: [
          const SizedBox(height: 8),
          SleekCircularSlider(
            appearance: CircularSliderAppearance(
              customColors: CustomSliderColors(
                dotColor: Colors.white,
                trackColor: Colors.white,
                progressBarColors: [
                  primaryColor,
                  primaryColor,
                ],
              ),
            ),
            initialValue: 120,
            min: 0,
            max: 240,
            onChange: (double value) {
              setState(() {
                height = value;
              });
            },
            innerWidget: (percentage) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isFeet
                    ? Text(htInFeet, style: Style.normalLightTextStyle)
                    : Text(htValue, style: Style.normalLightTextStyle),
              ],
            ),
          ),
          Text('How tall are you?', style: Style.normalLightTextStyle),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
