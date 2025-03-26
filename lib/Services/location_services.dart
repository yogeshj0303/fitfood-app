import 'dart:async';
import 'package:fit_food/Constants/export.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationServices {
  static String? latitude;
  static String? longitude;
  static String? address;
  static final c = Get.put(GetController());

  static late StreamSubscription<Position> streamSubscription;

  static Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
    c.city.value = place.locality!;
    c.currLocation.value = address!;
  }

  static Future<void> getLocation() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDeniedDialog();
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      getAddressFromLatLang(position);
    }
  }
}

_showPermissionDeniedDialog() {
  return Get.defaultDialog(
    title: 'Location Permission Denied',
    middleText: 'Please grant location permission to use this feature.',
    onConfirm: () => Get.back(),
    textConfirm: 'OK',
  );
}
