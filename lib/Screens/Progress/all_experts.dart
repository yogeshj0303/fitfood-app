import 'package:fit_food/Models/expert_model.dart';
import '../../Constants/export.dart';

class AllExperts extends StatelessWidget {
  final ExpertModel experts;
  AllExperts({super.key, required this.experts});
  final c = Get.find<GetController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        backgroundColor: c.isDarkTheme.value ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          elevation: c.isDarkTheme.value ? 0 : 1,
          centerTitle: true,
          backgroundColor:
              c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
          title: Text(
            'All Experts',
            style: TextStyle(
              color: c.isDarkTheme.value ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: experts.data?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) => expertCard(size, index),
          ),
        ),
      ),
    );
  }

  Widget expertCard(Size size, int index) {
    final expert = experts.data![index];
    return GestureDetector(
      onTap: () => Get.to(() => ExpertDetails(expertData: expert)),
      child: RoundedContainer(
        borderColor: c.isDarkTheme.value ? Colors.white24 : Colors.black12,
        color: c.isDarkTheme.value ? Colors.grey[850] : whiteColor,
        padding: const EdgeInsets.all(defaultPadding),
        isImage: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            expert.image == null
                ? const CircleAvatar(
                    radius: 40,
                    backgroundColor: greyColor,
                    backgroundImage: AssetImage(profileImg),
                  )
                : CircleAvatar(
                    radius: 40,
                    backgroundColor: greyColor,
                    backgroundImage: CachedNetworkImageProvider(
                      '$imgPath/${expert.image}',
                    ),
                  ),
            const SizedBox(height: 8),
            Text(
              expert.name ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: c.isDarkTheme.value ? Colors.white : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              expert.specialist ?? '',
              style: TextStyle(
                fontSize: 12,
                color: c.isDarkTheme.value ? Colors.white70 : Colors.black54,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_city, color: primaryColor, size: 16),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    expert.city ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                          c.isDarkTheme.value ? Colors.white70 : Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'India',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        c.isDarkTheme.value ? Colors.white70 : Colors.black54,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
