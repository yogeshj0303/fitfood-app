import '../../Constants/export.dart';
import '../../Models/noti_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: FutureBuilder<NotificationModel>(
            future: c.role.value == 'User'
                ? HomeUtils().getNotification()
                : HomeUtils().getTrainerNotification(),
            builder: (context, snapshot) => snapshot.hasData
                ? snapshot.data!.message!.isEmpty
                    ? Center(
                        child: Text(
                        'No Notifications yet',
                        style: Style.lighttextStyle,
                      ))
                    : notificationCard(snapshot, size)
                : loading,
          ),
        ),
      ),
    );
  }

  Widget notificationCard(
      AsyncSnapshot<NotificationModel> snapshot, Size size) {
    final item = snapshot.data!.message!;
    int length = item.length;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: RoundedContainer(
          color: whiteColor,
          width: size.width,
          padding: const EdgeInsets.all(defaultPadding * 2),
          isImage: false,
          child: Row(
            children: [
              Column(
                children: [
                  Text(
                    item[index].date!.split(' ')[0],
                    textAlign: TextAlign.center,
                    style: Style.largeLighttextStyle,
                  ),
                  Text(
                    item[index].date!.split(' ')[1].substring(0, 3),
                    textAlign: TextAlign.center,
                    style: Style.lighttextStyle,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item[index].type!,
                  ),
                  SizedBox(
                    width: size.width - 125,
                    child: Text(
                      item[index].message!,
                      style: Style.smallLighttextStyle,
                    ),
                  ),
                  Text(
                    item[index].time!,
                    style: Style.smallLighttextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
