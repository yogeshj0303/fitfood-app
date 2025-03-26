import '../Constants/export.dart';

showCustomDialog(
    {required BuildContext context,
    required Widget content,
    required String title}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: content,
    ),
  );
}


