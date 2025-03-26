import 'package:fit_food/Models/aboutus_model.dart';
import '../../Constants/export.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<AboutUsModel>(
          future: ProfileUtils().aboutUs(),
          builder: (context, snapshot) =>
              snapshot.hasData ? aboutsUsData(snapshot) : loading,
        ),
      ),
    );
  }

  Widget aboutsUsData(AsyncSnapshot<AboutUsModel> snapshot) {
    final item = snapshot.data!.data![0];
    return Padding(
      padding: const EdgeInsets.all(defaultPadding * 2),
      child: Column(
        children: [
          BannerWidget(
            opacity: 1,
            aImage: banner,
            child: Row(
              children: [
                const Spacer(flex: 1),
                Lottie.asset(aboutusLottie),
                const SizedBox(width: 10),
                Text(
                  'ABOUT US',
                  style: Style.largeLighttextStyle,
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(item.value!, style: Style.smallLighttextStyle),
        ],
      ),
    );
  }
}
