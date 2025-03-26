import 'package:fit_food/Constants/export.dart';

class DietPreference extends StatelessWidget {
  DietPreference({super.key});
  final buttonList = [
    'Pure Vegetarian',
    'Non Vegetarian',
    'Vegan',
    'Eggetarian',
    "Let's Dietician decide"
  ];
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 3, vertical: defaultPadding * 2),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              "What is your Dietery Preferences?",
              style: Style.xLargeTextStyle,
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: buttonList.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => c.prefButtonSelIndex.value = index,
                child: selectableButton(
                  buttonName: buttonList[index],
                  context: context,
                  index: index,
                  isGoal: false,
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
                c.pref.value = buttonList[c.prefButtonSelIndex.value];
                Get.to(() => Goal());
              },
              size: size,
              label: 'Next',
            )
          ],
        ),
      ),
    );
  }
}
