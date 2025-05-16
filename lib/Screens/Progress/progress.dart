import 'package:fit_food/Screens/Progress/bmi_graph.dart';
import '../../Constants/export.dart';
import '../../Controllers/home_controller.dart';

class ProgressScreen extends StatelessWidget {
  ProgressScreen({super.key});
  final c = Get.put(GetController());
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => c.isAuthLoading.value
          ? loading
          : Scaffold(
              backgroundColor:
                  c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
              appBar: AppBar(
                title: Text(
                  'Progress',
                  style: TextStyle(
                    color: c.isDarkTheme.value ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                backgroundColor:
                    c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
                elevation: c.isDarkTheme.value ? 0 : 1,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding * 2),
                  decoration: BoxDecoration(
                    color:
                        c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: c.isDarkTheme.value
                              ? Colors.grey[850]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: c.isDarkTheme.value
                                  ? Colors.black12
                                  : Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: BmiGraph(),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: c.isDarkTheme.value
                              ? Colors.grey[850]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: c.isDarkTheme.value
                                  ? Colors.black12
                                  : Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const BMICard(),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          color: c.isDarkTheme.value
                              ? Colors.grey[850]
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: c.isDarkTheme.value
                                  ? Colors.black12
                                  : Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: buildExperts(size),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
