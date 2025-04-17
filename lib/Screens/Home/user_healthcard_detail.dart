import 'package:fit_food/Constants/export.dart';

class UserHealthDetail extends StatelessWidget {
  UserHealthDetail({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Health Card Details'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 8),
              userDetail(size),
              const Divider(color: Colors.black38),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(wtnormal, height: 140),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BMI : ${c.bmi.value.toString().substring(0, 5)}',
                          style: Style.normalLightTextStyle),
                      const SizedBox(height: 8),
                      Text('Height : ${c.height.value} feet',
                          style: Style.normalLightTextStyle),
                      const SizedBox(height: 8),
                      Text('Weight : ${c.weight.value} kg',
                          style: Style.normalLightTextStyle),
                      const SizedBox(height: 8),
                      Text('Goal : ${c.goal.value}',
                          style: Style.normalLightTextStyle),
                      const SizedBox(height: 8),
                      Text(
                        'Preference : ${c.pref.value}',
                        style: Style.normalLightTextStyle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: Colors.black38),
              const SizedBox(height: 12),
              Text('BMI Card', style: Style.normalColorTextStyle),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: BMICard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column userDetail(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userImg(),
        const SizedBox(height: 8),
        Column(
          children: [
            Text(c.name.value, style: Style.normalWhiteTextStyle),
            const SizedBox(height: 5),
            Text(c.phone.value, style: Style.normalWhiteTextStyle),
            const SizedBox(height: 5),
            c.isSubscribed.value
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.workspace_premium, color: primaryColor),
                      const SizedBox(width: 2),
                      Text(
                        '${c.planName.value} Plan',
                        style: Style.normalLightTextStyle,
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 5),
            Text(
              c.mail.value,
              style: Style.normalLightTextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  CircleAvatar userImg() {
    return c.userDP.value == ''
        ? const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(profileImg),
          )
        : CircleAvatar(
            radius: 72,
            backgroundColor: whiteColor,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('$imgPath/${c.userDP.value}'),
            ),
          );
  }
}
