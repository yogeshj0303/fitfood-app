import '../../../Constants/export.dart';

class Goal extends StatelessWidget {
  Goal({super.key});
  final buttonList = [
    'Weight Loss',
    'Body Toning',
    'Muscle Gain',
    'Hair and Skin Improvement',
    "Mental Well-Being"
  ];
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => c.isRegLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Container(
                height: size.height,
                width: size.width,
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding * 3,
                    vertical: defaultPadding * 2),
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    Text(
                      "What is your Goal?",
                      style: Style.xLargeTextStyle,
                      textAlign: TextAlign.center,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: buttonList.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => c.goalButtonSelIndex.value = index,
                        child: selectableButton(
                          buttonName: buttonList[index],
                          context: context,
                          index: index,
                          isGoal: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "We use all this information to calculate and provide you with daily personal recommendations.",
                      style: Style.smallLighttextStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    customButton(
                      onPressed: () {
                        c.goal.value = buttonList[c.goalButtonSelIndex.value];
                        AuthUtils().getRegistered(
                            name: c.name.value,
                            phone: c.phone.value,
                            height: c.height.value,
                            password: c.password.value,
                            weight: c.weight.value,
                            gender: c.gender.value,
                            city: c.city.value,
                            email: c.mail.value,
                            pref: c.pref.value,
                            goal: c.goal.value,
                            dob: c.dob.value);
                      },
                      size: size,
                      label: 'Next',
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
