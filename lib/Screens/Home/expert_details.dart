// ignore_for_file: deprecated_member_use

import 'package:fit_food/Models/expert_model.dart' as expert;
import '../../Constants/export.dart';

class ExpertDetails extends StatelessWidget {
  final expert.Data expertData;
  ExpertDetails({super.key, required this.expertData});
  final c = Get.put(GetController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(defaultMargin),
            padding: const EdgeInsets.all(defaultPadding),
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image Container
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        width: size.width,
                        decoration: BoxDecoration(
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
                          image: expertData.image == null
                              ? const DecorationImage(
                                  image: AssetImage(profileImg),
                                  fit: BoxFit.cover,
                                )
                              : DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    '$imgPath/${expertData.image}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 8,
                        child: CircleAvatar(
                          backgroundColor: c.isDarkTheme.value
                              ? Colors.grey[850]?.withOpacity(0.8)
                              : Colors.white.withOpacity(0.8),
                          child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: c.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      expertData.name!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            c.isDarkTheme.value ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      expertData.specialist!,
                      style: TextStyle(
                        color: c.isDarkTheme.value
                            ? Colors.white70
                            : Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color:
                          c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildInfoRow(Icons.call, expertData.phone!),
                        _buildInfoRow(Icons.work_history,
                            '${expertData.experience!}+ years'),
                        _buildInfoRow(Icons.location_city, expertData.city!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color:
                          c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About ${expertData.name!}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: c.isDarkTheme.value
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          expertData.about!,
                          style: TextStyle(
                            color: c.isDarkTheme.value
                                ? Colors.white70
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                ],
              ),
            ),
          ),
        ),
        bottomSheet: Container(
          color: c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
          child: Obx(
            () => c.isConsultLoad.value
                ? loading
                : Padding(
                    padding: const EdgeInsets.all(defaultPadding),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        HomeUtils().getExpertConsult(expertData.id!.toInt());
                      },
                      child: Text(
                        'Consult Now'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: c.isDarkTheme.value ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
