import 'package:fit_food/Models/faq_model.dart';
import '../../Constants/export.dart';

class Faq extends StatelessWidget {
  Faq({super.key});
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ'S"),
        centerTitle: true,
        backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
        foregroundColor: c.isDarkTheme.value ? whiteColor : blackColor,
        elevation: 1,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            children: [
              BannerWidget(
                opacity: 1,
                aImage: banner,
                child: Row(
                  children: [
                    const Spacer(flex: 1),
                    Lottie.asset(faqLottie),
                    const SizedBox(width: 10),
                    Text(
                      "Frequently Asked Qusetion",
                      style: Style.normalLightTextStyle,
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
              FutureBuilder<FaqModel>(
                future: ProfileUtils().getFaqs(),
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data!.data!.isEmpty
                        ? Center(
                            child: Text('No FAQ Available',
                                style: Style.normalTextStyle),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) =>
                                buildFaqs(snapshot, index, size),
                          )
                    : loading,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFaqs(AsyncSnapshot<FaqModel> snapshot, int index, Size size) {
    var item = snapshot.data!.data![index];

    return Padding(
      padding: const EdgeInsets.only(
        top: defaultPadding * 2,
      ),
      child: GestureDetector(
        onTap: () {
          c.faqSelectedIndex.value = index;
          c.isFaqTapped.value = !c.isFaqTapped.value;
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Obx(
            () => AnimatedContainer(
              padding: const EdgeInsets.all(defaultPadding * 2),
              curve: Curves.easeInOut,
              color: whiteColor,
              height: c.isFaqTapped.value && c.faqSelectedIndex.value == index
                  ? item.answer!.length.toDouble() * 0.5
                  : 45,
              duration: const Duration(seconds: 1),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(item.question!, style: Style.smallLighttextStyle),
                        const Spacer(),
                        c.faqSelectedIndex.value == index && c.isFaqTapped.value
                            ? const Icon(Icons.remove, size: 14)
                            : const Icon(
                                Icons.add_rounded,
                                size: 14,
                                color: primaryColor,
                              ),
                      ],
                    ),
                    c.faqSelectedIndex.value == index && c.isFaqTapped.value
                        ? const SizedBox(height: 10)
                        : const SizedBox(height: 0),
                    c.faqSelectedIndex.value == index && c.isFaqTapped.value
                        ? Text(
                            item.answer!,
                            style: Style.smallLighttextStyle,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
