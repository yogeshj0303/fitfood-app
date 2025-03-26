import '../../Constants/export.dart';

class Terms extends StatelessWidget {
  Terms({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('T&C'),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
        elevation: 1,
      ),
    );
  }
}
