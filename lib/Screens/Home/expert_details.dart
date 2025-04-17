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
    return Scaffold(
      backgroundColor: whiteColor,
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
                Container(
                  height: size.height * 0.4,
                  width: size.width,
                  decoration: expertData.image == null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(profileImg),
                          ),
                        )
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(
                              '$imgPath/${expertData.image}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    expertData.name!.toUpperCase(),
                    style: Style.largeTextStyle,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    expertData.specialist!,
                    style: Style.smallLighttextStyle,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.call, color: primaryColor),
                        const SizedBox(width: 12),
                        Text(expertData.phone!),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work_history, color: primaryColor),
                        const SizedBox(width: 12),
                        Text('${expertData.experience!}+ years'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_city, color: primaryColor),
                        const SizedBox(width: 12),
                        Text('${expertData.city}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RoundedContainer(
                  padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.7,
                      horizontal: defaultPadding),
                  borderColor: primaryColor,
                  isImage: false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.email, color: primaryColor),
                      const SizedBox(width: 12),
                      Text(expertData.email!),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('About ${expertData.name!}', style: Style.mediumTextStyle),
                const SizedBox(height: 8),
                Text(
                  expertData.about!,
                  style: Style.smallLighttextStyle,
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Obx(
        () => c.isConsultLoad.value
            ? loading
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(defaultPadding * 2),
                    child: ElevatedButton(
                      onPressed: () {
                        HomeUtils().getExpertConsult(expertData.id!.toInt());
                      },
                      child: Text('Consult Now'.toUpperCase(),
                          style: Style.mediumWTextStyle),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
