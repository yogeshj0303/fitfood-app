import '../Constants/export.dart';

class RoundedContainer extends StatelessWidget {
  final String? image;
  final Widget? child;
  final double? height;
  final double? width;
  final dynamic onTap;
  final Color? color;
  final String? networkImg;
  final EdgeInsetsGeometry? padding;
  final double? opacity;
  final Color? borderColor;
  final bool isImage;
  RoundedContainer({
    super.key,
    this.image,
    this.child,
    this.height,
    this.width,
    this.padding,
    this.onTap,
    this.opacity,
    this.color,
    this.networkImg,
    this.borderColor,
    required this.isImage,
  });
  final c = Get.put(GetController());
  @override
  Widget build(BuildContext context) {
    return Ink(
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: c.isDarkTheme.value
            ? blackColor
            : isImage
                ? blackColor
                : whiteColor,
        border: Border.all(
          color: borderColor ?? darkGrey,
        ),
        borderRadius: BorderRadius.circular(defaultCardRadius),
        image: image == null
            ? networkImg == null
                ? DecorationImage(
                    image: const AssetImage(banner),
                    fit: BoxFit.cover,
                    opacity: opacity ?? 0.0,
                  )
                : DecorationImage(
                    image: CachedNetworkImageProvider(networkImg!),
                    fit: BoxFit.cover,
                    opacity: opacity ?? 1.0,
                  )
            : DecorationImage(
                image: AssetImage(image!),
                fit: BoxFit.cover,
                opacity: opacity ?? 0.6,
              ),
      ),
      child: InkWell(
        onTap: onTap,
        child: child,
      ),
    );
  }
}
