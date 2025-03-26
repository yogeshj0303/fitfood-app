import '../../Constants/export.dart';

class ExpertCardDetail extends StatelessWidget {
  ExpertCardDetail({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  decoration: c.trainerDP.value == ''
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
                              '$imgPath/${c.trainerDP.value}',
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
                    c.tName.value.toUpperCase(),
                    style: Style.largeTextStyle,
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    c.tSpecialist.value,
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
                        Text(c.tPhone.value),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.work_history, color: primaryColor),
                        const SizedBox(width: 12),
                        Text('${c.tExp.value}+ years'),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.location_city, color: primaryColor),
                        const SizedBox(width: 12),
                        Text(c.tCity.value),
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
                      Text(c.tMail.value),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text('About ${c.tName.value}', style: Style.mediumTextStyle),
                const SizedBox(height: 8),
                Text(
                  c.tAbout.value,
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
    );
  }
}
