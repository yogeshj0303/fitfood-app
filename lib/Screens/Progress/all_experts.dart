import 'package:fit_food/Models/expert_model.dart';
import '../../Constants/export.dart';

class AllExperts extends StatelessWidget {
  final AsyncSnapshot<ExpertModel> snapshot;
  const AllExperts({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Experts'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: snapshot.data!.data!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
          itemBuilder: (context, index) => expertCard(size, snapshot, index),
        ),
      ),
    );
  }

  Widget expertCard(Size size, AsyncSnapshot<ExpertModel> snapshot, int index) {
    var item = snapshot.data!.data!;
    return GestureDetector(
      onTap: () {
        Get.to(() => ExpertDetails(index: index, snapshot: snapshot));
      },
      child: RoundedContainer(
        borderColor: Colors.black12,
        color: whiteColor,
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            item[index].image == null
                ? const CircleAvatar(
                    radius: 50,
                    backgroundColor: greyColor,
                    backgroundImage: AssetImage(
                      profileImg,
                    ),
                  )
                : CircleAvatar(
                    radius: 50,
                    backgroundColor: greyColor,
                    backgroundImage: CachedNetworkImageProvider(
                      '$imgPath/${item[index].image}',
                    ),
                  ),
            const Spacer(),
            Text(item[index].name ?? '',
                style: Style.smalltextStyle, textAlign: TextAlign.center),
            Text(item[index].specialist ?? '',
                style: Style.smallLighttextStyle, textAlign: TextAlign.center),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_city, color: primaryColor),
                const Spacer(flex: 1),
                Text(item[index].city!, style: Style.smallLighttextStyle),
                const Spacer(flex: 5),
                Text('India', style: Style.smallLighttextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
