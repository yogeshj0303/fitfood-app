import 'package:fit_food/Constants/export.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key, required this.result});
  final String result;
  @override
  Widget build(BuildContext context) {
    List<String> scanData = result.split(',');
    String name = scanData[0];
    String phone = scanData[1];
    String ht = scanData[2];
    String wt = scanData[3];
    String bmi = scanData[4].substring(0, 5);
    String goal = scanData[5];
    String pref = scanData[6];
    // String planName = 'scanData[7]';
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Result'),
      ),
      body: Container(
        margin: const EdgeInsets.all(defaultMargin * 2),
        height: size.height / 3,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultCardRadius),
          color: primaryColor,
          image: const DecorationImage(
              image: AssetImage(cardBg), fit: BoxFit.cover, opacity: 0.8),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                        radius: 45, backgroundImage: AssetImage(profileImg)),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 135,
                      child: Text(
                        name,
                        style: Style.normalWhiteTextStyle,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      phone,
                      style: Style.normalWhiteTextStyle,
                    ),
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.workspace_premium, color: whiteColor),
                      ],
                    )
                  ],
                ),
                const VerticalDivider(
                  width: 30.0,
                  thickness: 1.0,
                  color: whiteColor,
                  indent: 35,
                  endIndent: 35,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BMI : $bmi', style: Style.mediumWhiteTextStyle),
                    Text('Height : $ht', style: Style.mediumWhiteTextStyle),
                    Text('Weight : $wt', style: Style.mediumWhiteTextStyle),
                    Text('Goal : $goal', style: Style.mediumWhiteTextStyle),
                    SizedBox(
                      width: 170,
                      child: Text(
                        'Pref : $pref',
                        style: Style.mediumWTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: -20,
              child: Image.asset(
                logoWhite,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
