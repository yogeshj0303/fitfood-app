import '../../Constants/export.dart';

class TrainerEditProfile extends StatelessWidget {
  TrainerEditProfile({super.key});
  final cityController = TextEditingController();
  final genderController = TextEditingController();
  final specialistController = TextEditingController();
  final expController = TextEditingController();
  final aboutController = TextEditingController();
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
                                    c.tName.value,
                                    style: Style.smallLighttextStyle,
                                  ),
                                  Text(
                                    c.tPhone.value,
                                    style: Style.smallLighttextStyle,
                                  ),
                                  Text(
                                    c.tMail.value,
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
                          controller: cityController,
                          title: 'City',
                          iconData: Icons.add_home_work,
                          hintText: c.tCity.value,
                        ),
                        customTextField(
                          controller: genderController,
                          title: 'Gender',
                          iconData: Icons.badge,
                          hintText: c.tGender.value,
                        ),
                        customTextField(
                          controller: specialistController,
                          title: 'Specialist',
                          iconData: Icons.view_carousel_outlined,
                          hintText: c.tSpecialist.value,
                        ),
                        const SizedBox(height: 8),
                        Text('More Details', style: Style.mediumTextStyle),
                        customTextField(
                          controller: expController,
                          title: 'Experience',
                          iconData: Icons.work_history,
                          isExp: true,
                          hintText: c.tExp.value,
                        ),
                        customTextField(
                          controller: aboutController,
                          title: 'About',
                          iconData: Icons.info,
                          hintText: c.tAbout.value,
                          isAbout: true,
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              ProfileUtils().editTrainerProfile(
                                exp: expController.text.isEmpty
                                    ? c.tExp.value
                                    : expController.text,
                                specialist: specialistController.text.isEmpty
                                    ? c.tSpecialist.value
                                    : specialistController.text,
                                city: cityController.text.isEmpty
                                    ? c.tCity.value
                                    : cityController.text,
                                about: aboutController.text.isEmpty
                                    ? c.tAbout.value
                                    : aboutController.text,
                              );
                            },
                            child:
                                Text('Save', style: Style.mediumWhiteTextStyle),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customTextField({
    required TextEditingController controller,
    required String title,
    required IconData iconData,
    bool? isExp,
    String? hintText,
    bool? isAbout,
  }) {
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
            maxLines: isAbout ?? false ? 10 : 1,
            minLines: isAbout ?? false ? 8 : 1,
            keyboardType:
                isExp ?? false ? TextInputType.number : TextInputType.text,
            validator: (value) => value!.isEmpty ? '*This is required' : null,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              suffixIcon: const Icon(Icons.edit),
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
}
