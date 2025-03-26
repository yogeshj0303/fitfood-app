import 'dart:async';
import 'package:fit_food/Constants/export.dart';
import 'package:fit_food/Models/noti_model.dart';

const defaultPadding = 8.00;
const defaultMargin = 12.00;
const defaultRadius = 12.00;
const defaultCardRadius = 12.00;
const smallTextsize = 12.00;
const normalTextsize = 14.00;
const mediumTextsize = 16.00;
const largeTextsize = 20.00;
const xLargeTextsize = 24.00;
const appName = 'FitFood';
const baseUrl = 'https://fitfood.stilld.in/';
const apiUrl = '${baseUrl}api/';
const imgPath = 'https://fitfood.stilld.in/admin/build';
final screenHeight = Get.height;
final screenWidth = Get.width;

const blackDecor = BoxDecoration(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(defaultRadius),
      topRight: Radius.circular(defaultRadius)),
  color: Color(0xFF1E1E1E),
);

const whiteDecor = BoxDecoration(
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(defaultRadius),
      topRight: Radius.circular(defaultRadius)),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      offset: Offset(2, 2),
      blurRadius: 6,
      color: Colors.grey,
    )
  ],
);

const bottomCircular = BorderRadius.only(
  bottomLeft: Radius.circular(defaultRadius),
  bottomRight: Radius.circular(defaultRadius),
);

final borderRadius = BorderRadius.circular(defaultRadius);

const topCircular = BorderRadius.only(
  topLeft: Radius.circular(defaultRadius),
  topRight: Radius.circular(defaultRadius),
);

const buttonDecor = BoxDecoration(
  color: buttonColor,
  borderRadius: BorderRadius.all(Radius.circular(12.00)),
);

const primaryColorDecor = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.all(
    Radius.circular(12.00),
  ),
);

final loading = Center(
  child: Lottie.asset(loadingLottie, height: 150),
);

final StreamController<NotificationModel> notiController = StreamController();
