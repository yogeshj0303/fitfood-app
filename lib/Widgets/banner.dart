import '../Constants/export.dart';

class BannerWidget extends StatelessWidget {
  final String? iImage;
  final String? aImage;
  final String? name;
  final Widget? child;
  final double opacity;
  const BannerWidget(
      {super.key,
      this.name,
      this.iImage,
      this.child,
      this.aImage,
      required this.opacity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RoundedContainer(
      height: size.height / 8,
      width: size.width,
      color: Colors.black,
      networkImg: iImage,
      opacity: opacity,
      borderColor: Colors.transparent,
      isImage: true,
      child: Center(
        child: name == null
            ? child
            : Text(
                name!,
                style: Style.xLargeWhiteTextStyle,
              ),
      ),
    );
  }
}
