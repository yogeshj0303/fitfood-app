import 'package:fit_food/Screens/Progress/bmi_graph.dart';
import '../../Constants/export.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => c.isAuthLoading.value
          ? loading
          : Scaffold(
              appBar: AppBar(
                title: const Text('Progress'),
                centerTitle: true,
                backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
                foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
                elevation: 1,
                actions: [
                  Obx(
                    () => Switch(
                      value: c.isDarkTheme.value,
                      onChanged: (theme) {
                        Get.changeTheme(Get.isDarkMode
                            ? ThemeData.light()
                            : ThemeData.dark());
                        c.isDarkTheme.value = theme;
                      },
                    ),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding * 2),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BmiGraph(),
                      const SizedBox(height: 10),
                      const BMICard(),
                      const SizedBox(height: 10),
                      buildExperts(size),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
