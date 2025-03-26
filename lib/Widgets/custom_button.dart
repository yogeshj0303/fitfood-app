import 'package:fit_food/Constants/export.dart';

Widget customButton(
    {required onPressed, required Size size, required String label}) {
  return Material(
    color: Colors.transparent,
    child: Ink(
      height: 50,
      width: size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            color: primaryColor,
            blurRadius: 6,
          ),
        ],
      ),
      child: InkWell(
        onTap: onPressed,
        child: Center(
          child: Text(
            label.toUpperCase(),
            style: Style.normalWTextStyle,
          ),
        ),
      ),
    ),
  );
}
