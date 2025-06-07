import '../../Constants/export.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});
  final prefList = [
    'Pure Vegetarian',
    'Non Vegetarian',
    'Vegan',
    'Eggetarian',
    "Let's Dietician decide"
  ];
  final goalList = [
    'Weight Loss',
    'Body Toning',
    'Muscle Gain',
    'Hair and Skin Improvement',
    "Mental Well-Being"
  ];
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final prefController = TextEditingController();
  final goalController = TextEditingController();
  final c = Get.put(GetController());
  final isFeet = true.obs;

  @override
  Widget build(BuildContext context) {
    // Convert height to feet and inches
    String heightInFeetInches = c.height.value;
    List<String> heightParts = heightInFeetInches.split('.');
    int feet = int.parse(heightParts[0]);
    int inches = ((double.parse('0.' + heightParts[1]) * 12).round());

    // Add a listener to the heightController to convert input to feet and inches
    heightController.addListener(() {
      String input = heightController.text;
      // Check if input is already formatted as 'X feet Y inches'
      if (RegExp(r'^\d+ feet \d+ inches$').hasMatch(input)) {
        return; // Skip parsing if already formatted
      }
      if (input.contains('.') && !input.endsWith('.')) {
        List<String> parts = input.split('.');
        if (parts.length == 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
          int feet = int.parse(parts[0]);
          // Directly use the part after the decimal as inches if it's a valid number
          int inches = int.parse(parts[1]);
          // Ensure inches do not exceed 11
          if (inches >= 12) {
            feet += inches ~/ 12;
            inches = inches % 12;
          }
          // Update the text field with the correct format
          heightController.value = TextEditingValue(
            text: '$feet feet $inches inches',
            selection: TextSelection.fromPosition(
              TextPosition(offset: '$feet feet $inches inches'.length),
            ),
          );
        }
      }
    });

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back,
              color: c.isDarkTheme.value ? Colors.white : Colors.black87),
        ),
        title: Text('Edit Profile',
            style: TextStyle(
              color: c.isDarkTheme.value ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding * 2),
            child: Obx(
              () => c.isEditLoading.value
                  ? loading
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BannerWidget(
                          aImage: banner,
                          opacity: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(flex: 1),
                              Lottie.asset(profileLottie),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    c.name.value,
                                    style: Style.smallLighttextStyle,
                                  ),
                                  Text(
                                    c.phone.value,
                                    style: Style.smallLighttextStyle,
                                  ),
                                ],
                              ),
                              const Spacer(flex: 3),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Basic Details', style: Style.mediumTextStyle),
                        customTextField(
                          controller: emailController,
                          title: 'Email',
                          iconData: Icons.mail,
                          hintText: c.mail.value,
                        ),
                        customTextField(
                          controller: cityController,
                          title: 'City',
                          iconData: Icons.add_home_work,
                          hintText: c.city.value,
                        ),
                        customTextField(
                          controller: genderController,
                          title: 'Gender',
                          iconData: Icons.badge,
                          hintText: c.gender.value,
                        ),
                        const SizedBox(height: 8),
                        Text('Body Index Details',
                            style: Style.mediumTextStyle),
                        customTextField(
                          controller: heightController,
                          title: 'Height',
                          iconData: Icons.height,
                          isHeight: true,
                          hintText: isFeet.value 
                              ? '$feet feet $inches inches'
                              : '${c.height.value} cm',
                        ),
                        customTextField(
                          controller: weightController,
                          title: 'Weight',
                          iconData: Icons.monitor_weight,
                          isWeight: true,
                          hintText: c.weight.value,
                        ),
                        customTextField(
                          controller: prefController,
                          title: 'Preference',
                          iconData: Icons.room_preferences,
                          isPref: true,
                          hintText: c.pref.value,
                        ),
                        customTextField(
                          controller: goalController,
                          title: 'Goal',
                          iconData: Icons.api,
                          isGoal: true,
                          hintText: c.goal.value,
                        ),
                        SizedBox(height: size.height * 0.1),
                      ],
                    ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(defaultPadding * 2),
        height: 65,
        child: customButton(
          size: size,
          label: 'Save',
          onPressed: () {
            String heightValue = heightController.text.isEmpty
                ? c.height.value
                : heightController.text;
            
            // Convert formatted height to decimal format
            if (heightValue.contains('feet')) {
              List<String> parts = heightValue.split(' ');
              int feet = int.parse(parts[0]);
              int inches = int.parse(parts[2]);
              // Convert to decimal format
              heightValue = (feet + inches / 12).toStringAsFixed(1);
            }
            
            // Update the heightController with the formatted height
            double totalInches = double.parse(heightValue) * 12;
            int feet = totalInches ~/ 12;
            int inches = (totalInches % 12).round();
            heightController.text = '$feet feet $inches inches';
            
            ProfileUtils().editProfile(
              name: c.name.value,
              phone: c.phone.value,
              height: heightValue, // Pass height as a decimal string
              weight: weightController.text.isEmpty
                  ? c.weight.value
                  : weightController.text,
              email: emailController.text.isEmpty
                  ? c.mail.value
                  : emailController.text,
              gender: genderController.text.isEmpty
                  ? c.gender.value
                  : genderController.text,
              city: cityController.text.isEmpty
                  ? c.city.value
                  : cityController.text,
              dob:
                  dobController.text.isEmpty ? c.dob.value : dobController.text,
              pref: prefController.text.isEmpty
                  ? c.pref.value
                  : prefController.text,
              goal: goalController.text.isEmpty
                  ? c.goal.value
                  : goalController.text,
            );
          },
        ),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController controller,
    required String title,
    required IconData iconData,
    bool? isHeight,
    bool? isWeight,
    bool? isPref,
    bool? isGoal,
    bool? isDob,
    String? hintText,
  }) {
    bool asheight = isHeight ?? false;
    bool asWeight = isWeight ?? false;
    bool asPref = isPref ?? false;
    bool asGoal = isGoal ?? false;
    bool asDob = isDob ?? false;

    return Padding(
      padding: const EdgeInsets.only(top: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Text(title, style: Style.smallLighttextStyle),
          ),
          const SizedBox(height: 5),
          TextFormField(
            keyboardType: asWeight || asheight
                ? TextInputType.number
                : TextInputType.text,
            readOnly: asDob || asPref || asGoal ? true : false,
            onTap: () {
              if (asPref) {
                Get.defaultDialog(
                  titlePadding: const EdgeInsets.only(top: 25),
                  title: 'Preference',
                  content: prefContent(),
                );
              }
              if (asGoal) {
                Get.defaultDialog(
                  titlePadding: const EdgeInsets.only(top: 25),
                  title: 'Goal',
                  content: goalContent(),
                );
              }
            },
            validator: (value) => value!.isEmpty ? '*This is required' : null,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (asWeight)
                    Text(
                      'kg',
                      style: Style.normalLightTextStyle,
                    ),
                  const SizedBox(width: 10),
                  const Icon(Icons.edit),
                  const SizedBox(width: 10),
                ],
              ),
              prefixIcon: Icon(
                iconData,
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget prefContent() {
    return SizedBox(
      width: 300,
      height: 260,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: prefList.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            prefController.text = prefList[index];
            Get.back();
          },
          title: Text(prefList[index]),
        ),
      ),
    );
  }

  Widget goalContent() {
    return SizedBox(
      width: 300,
      height: 260,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: goalList.length,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            goalController.text = goalList[index];
            Get.back();
          },
          title: Text(goalList[index]),
        ),
      ),
    );
  }
}
