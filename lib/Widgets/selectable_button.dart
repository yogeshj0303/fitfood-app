import 'package:fit_food/Constants/export.dart';

Widget selectableButton(
    {required BuildContext context,
    required String buttonName,
    required int index,
    required bool isGoal}) {
  final size = MediaQuery.of(context).size;
  final c = Get.put(GetController());
  return Padding(
    padding: const EdgeInsets.only(top: defaultPadding * 2),
    child: Obx(
      () => Ink(
        height: 50,
        width: size.width,
        decoration: BoxDecoration(
          color: isGoal
              ? index == c.goalButtonSelIndex.value
                  ? primaryColor
                  : whiteColor
              : index == c.prefButtonSelIndex.value
                  ? primaryColor
                  : whiteColor,
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(defaultCardRadius),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: isGoal
                ? index == c.goalButtonSelIndex.value
                    ? Style.mediumWTextStyle
                    : Style.normalTextStyle
                : index == c.prefButtonSelIndex.value
                    ? Style.mediumWTextStyle
                    : Style.normalTextStyle,
          ),
        ),
      ),
    ),
  );
}
