import 'package:fit_food/Models/clients_model.dart';
import '../../Constants/export.dart';

class UserDetails extends StatelessWidget {
  final ClientsModel client;
  const UserDetails({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final item = client.data![0].adminId!;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Health Card Details'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),
            userDetail(size, item),
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
                    Text('BMI : ${item.bmi.toString().substring(0, 5)}',
                        style: Style.normalLightTextStyle),
                    const SizedBox(height: 8),
                    Text('Height : ${item.height} feet',
                        style: Style.normalLightTextStyle),
                    const SizedBox(height: 8),
                    Text('Weight : ${item.weight} kg',
                        style: Style.normalLightTextStyle),
                    const SizedBox(height: 8),
                    Text('Goal : ${item.goal}',
                        style: Style.normalLightTextStyle),
                    const SizedBox(height: 8),
                    Text(
                      'Preference : ${item.preference}',
                      style: Style.normalLightTextStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
            const Divider(color: Colors.black38),
          ],
        ),
      ),
    );
  }

  Column userDetail(Size size, AdminId item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userImg(item),
        const SizedBox(height: 8),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(item.name ?? '', style: Style.mediumTextStyle),
                const SizedBox(width: 5),
                if (item.subsStatus == 1)
                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.workspace_premium, color: primaryColor),
                      SizedBox(width: 2),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(item.phone ?? '', style: Style.normalWhiteTextStyle),
            const SizedBox(height: 5),
            Text(
              item.email ?? '',
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

  CircleAvatar userImg(AdminId item) {
    return item.image == null
        ? const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(profileImg),
          )
        : CircleAvatar(
            radius: 72,
            backgroundColor: whiteColor,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('$imgPath/${item.image}'),
            ),
          );
  }
}
