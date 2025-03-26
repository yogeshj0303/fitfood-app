import '../../Constants/export.dart';

class ShowQR extends StatelessWidget {
  ShowQR({super.key});
  final c = Get.put(GetController());
  String getName(String name) {
    final List<String> sName = c.name.value.toString().split(' ');
    String name = '';
    String full = '';
    for (int i = 0; i < sName.length; i++) {
      name = sName[i][0];
      full = full + name;
    }
    return full;
  }

  @override
  Widget build(BuildContext context) {
    final sname = getName(c.name.value);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 45),
            Image.asset(logoGreen, height: 150),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(defaultPadding * 4),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(defaultRadius)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 45),
                        Text(c.name.value, style: Style.normalLightTextStyle),
                        Text(c.mail.value, style: Style.smallLighttextStyle),
                        Text(c.phone.value, style: Style.smallLighttextStyle),
                        QrImageView(
                          data:
                              '${c.name.value},\n${c.phone.value},\n${c.height.value} cm,\n${c.weight.value} kg,\n${c.bmi.value} kg/m2,\n${c.goal.value},\n${c.pref.value}',
                          size: 220,
                          embeddedImage: const AssetImage(logo),
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(40, 40),
                          ),
                          errorStateBuilder: (cxt, err) => const Center(
                            child: Text(
                              'Uh oh! Something went wrong...',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: -35,
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(sname.toUpperCase(),
                        style: Style.xLargeWhiteTextStyle),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
