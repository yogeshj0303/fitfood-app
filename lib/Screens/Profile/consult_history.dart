import 'package:fit_food/Models/consulted_model.dart';
import '../../Constants/export.dart';

class ConsultHistory extends StatelessWidget {
  ConsultHistory({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultation History'),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
        elevation: 1,
      ),
      body: FutureBuilder<ConsultedModel>(
        future: ProfileUtils().getConsultedHistory(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.data!.length,
                itemBuilder: (context, index) =>
                    ConsultCard(snapshot: snapshot, index: index))
            : loading,
      ),
    );
  }
}

class ConsultCard extends StatelessWidget {
  final AsyncSnapshot<ConsultedModel> snapshot;
  final int index;
  ConsultCard({super.key, required this.snapshot, required this.index});
  final reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var item = snapshot.data!.data![index];
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding),
        borderColor: Colors.black12,
        height: 170,
        width: double.infinity,
        isImage: false,
        child: Row(
          children: [
            item.image == null
                ? RoundedContainer(
                    image: profileImg,
                    width: 125,
                    padding: const EdgeInsets.all(defaultPadding),
                    isImage: true,
                  )
                : RoundedContainer(
                    networkImg: '$imgPath/${item.image}',
                    width: 125,
                    padding: const EdgeInsets.all(defaultPadding),
                    isImage: true,
                  ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(item.name!, style: Style.mediumTextStyle),
                Text(
                  item.specialist!,
                  style: Style.smallLighttextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Image.asset(exp, height: 20),
                        const SizedBox(width: 12),
                        Text('${item.experience!}+ years'),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_city,
                            color: primaryColor, size: 20),
                        const SizedBox(width: 8),
                        Text('${item.city}'),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          starIcon,
                          height: 20,
                          width: 25,
                        ),
                        const SizedBox(width: 8),
                        Text(item.email!),
                      ],
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: () => showRatingsDialog(
                    context,
                    snapshot,
                    index,
                  ),
                  child: Text(
                    'Give review',
                    style: Style.smallColortextStyle,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  showRatingsDialog(
      BuildContext context, AsyncSnapshot<ConsultedModel> snapshot, int index) {
    var item = snapshot.data!.data![index];
    double ratingGiven = 0.0;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedContainer(
                height: 150,
                width: double.infinity,
                networkImg: '$imgPath/${item.image}',
                isImage: true,
              ),
              const SizedBox(height: 8),
              Text(item.name!, style: Style.mediumTextStyle),
              const SizedBox(height: 8),
              Text(
                item.specialist!,
                style: Style.smallLighttextStyle,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        starIcon,
                        height: 20,
                        width: 25,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                minRating: 1,
                itemSize: 22,
                glow: true,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: primaryColor,
                ),
                onRatingUpdate: (rating) => ratingGiven = rating,
              ),
              const SizedBox(height: 8),
              TextFormField(
                maxLines: 7,
                minLines: 7,
                controller: reviewController,
                decoration: const InputDecoration(
                  hintText: 'Type your review',
                ),
              ),
              OutlinedButton(
                onPressed: () => ratingGiven == 0.0
                    ? Fluttertoast.showToast(msg: 'Please fill in ratings...')
                    : ProfileUtils().postReview(
                        ratingGiven.toString(),
                        reviewController.text.isEmpty
                            ? '...'
                            : reviewController.text,
                        item.id!.toInt()),
                child: Text('Submit', style: Style.smallColortextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
