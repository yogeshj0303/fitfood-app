import 'package:fit_food/Models/expert_model.dart';
import '../../Constants/export.dart';

class AllExperts extends StatelessWidget {
  final ExpertModel experts;
  const AllExperts({super.key, required this.experts});

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
          itemCount: experts.data?.length ?? 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8, // Added to fix overflow
          ),
          itemBuilder: (context, index) => expertCard(size, index),
        ),
      ),
    );
  }

  Widget expertCard(Size size, int index) {
    final expert = experts.data![index];
    return GestureDetector(
      onTap: () {
        Get.to(() => ExpertDetails(expertData: expert));
      },
      child: RoundedContainer(
        borderColor: Colors.black12,
        color: whiteColor,
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Added to prevent overflow
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            expert.image == null
                ? const CircleAvatar(
                    radius: 40, // Reduced radius
                    backgroundColor: greyColor,
                    backgroundImage: AssetImage(profileImg),
                  )
                : CircleAvatar(
                    radius: 40, // Reduced radius
                    backgroundColor: greyColor,
                    backgroundImage: CachedNetworkImageProvider(
                      '$imgPath/${expert.image}',
                    ),
                  ),
            const SizedBox(height: 8),
            Text(expert.name ?? '',
                style: Style.smalltextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(expert.specialist ?? '',
                style: Style.smallLighttextStyle,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_city, color: primaryColor, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(expert.city ?? '',
                      style: Style.smallLighttextStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(width: 4),
                Text('India',
                    style: Style.smallLighttextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
