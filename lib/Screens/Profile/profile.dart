import 'dart:io';
import 'package:fit_food/Screens/Profile/saved_address.dart';
import 'package:fit_food/Screens/Profile/scan_qr_result.dart';
import 'package:fit_food/Screens/Profile/trainer_edit_profile.dart';
import '../../Constants/export.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final c = Get.put(GetController());
  File? image;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;

  pickImageFrom(ImageSource source) async {
    XFile? pickedImg = await ImagePicker().pickImage(source: source);
    if (pickedImg != null) {
      image = File(pickedImg.path);
      Get.back();
      c.role.value == 'User'
          ? ProfileUtils().updateUserDP(imagePath: image!.path)
          : ProfileUtils().updateTrainerDP(imagePath: image!.path);
    } else {
      Fluttertoast.showToast(msg: 'No Files selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(
            defaultPadding, defaultPadding, defaultPadding, 0),
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: whiteColor,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.45],
            colors: c.isDarkTheme.value
                ? [blackColor, darkGrey]
                : [primaryColor, whiteColor],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            buildProfileCard(size, context),
            buildBottomCard(),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.2,
      width: size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              c.role.value == 'User' ? userImg() : trainerImg(),
              const SizedBox(height: 8),
              c.role.value == 'User'
                  ? TextButton.icon(
                      icon: const Icon(Icons.qr_code_2, color: whiteColor),
                      onPressed: () =>
                          Get.to(() => ShowQR(), transition: Transition.zoom),
                      label: Text(
                        'Show QR',
                        style: Style.smallLighttextStyle,
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(width: 8),
          const VerticalDivider(
            indent: 25,
            endIndent: 25,
            color: whiteColor,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      c.role.value == 'User'
                          ? Text(c.name.value,
                              style: Style.normalWhiteTextStyle)
                          : Text(c.tName.value,
                              style: Style.normalWhiteTextStyle),
                      const SizedBox(height: 5),
                      c.role.value == 'User'
                          ? Text(c.phone.value,
                              style: Style.normalWhiteTextStyle)
                          : Text(c.tPhone.value,
                              style: Style.normalWhiteTextStyle),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(width: 14),
                  IconButton(
                    onPressed: () {
                      // Get.to(() => QRViewExample(onQRViewCreated: _onQRViewCreated));
                    },
                    icon: Image.asset(qr, height: 30),
                  )
                ],
              ),
              SizedBox(
                width: size.width * 0.5,
                child: c.role.value == 'User'
                    ? Text(
                        c.mail.value,
                        style: Style.smalltextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Text(
                        c.tMail.value,
                        style: Style.smalltextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: size.width * 0.5,
                child: Text(
                  c.currLocation.value,
                  style: Style.smalltextStyle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Obx trainerImg() {
    return Obx(
      () => c.isDpLoading.value
          ? loadingProfileDP()
          : Stack(
              children: [
                c.trainerDP.value == ''
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profileImg),
                      )
                    : CircleAvatar(
                        radius: 52,
                        backgroundColor: whiteColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('$imgPath/${c.trainerDP.value}'),
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => showImagePickerDialog(),
                    child: const CircleAvatar(
                      radius: 17,
                      backgroundColor: whiteColor,
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.edit, color: whiteColor, size: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Obx userImg() {
    return Obx(
      () => c.isDpLoading.value
          ? loadingProfileDP()
          : Stack(
              children: [
                c.userDP.value == ''
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(profileImg),
                      )
                    : CircleAvatar(
                        radius: 52,
                        backgroundColor: whiteColor,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              NetworkImage('$imgPath/${c.userDP.value}'),
                        ),
                      ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => showImagePickerDialog(),
                    child: const CircleAvatar(
                      radius: 17,
                      backgroundColor: whiteColor,
                      child: CircleAvatar(
                        radius: 15,
                        child: Icon(Icons.edit, color: whiteColor, size: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  loadingProfileDP() {
    return Container(
      height: 120,
      width: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: FileImage(image!),
          opacity: 0.3,
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  showImagePickerDialog() {
    return Get.defaultDialog(
      radius: 4,
      title: 'Choose Source',
      titleStyle: Style.mediumTextStyle,
      content: Column(
        children: [
          ListTile(
            dense: true,
            onTap: () => pickImageFrom(ImageSource.camera),
            title: Text('Camera', style: Style.normalTextStyle),
            leading: const Icon(
              Icons.add_a_photo,
              color: primaryColor,
            ),
          ),
          ListTile(
            dense: true,
            onTap: () => pickImageFrom(ImageSource.gallery),
            title: Text('Gallery', style: Style.normalTextStyle),
            leading: const Icon(
              Icons.image,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomCard() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            defaultPadding, defaultPadding, defaultPadding, 0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(defaultCardRadius),
              topRight: Radius.circular(defaultCardRadius)),
          color: c.isDarkTheme.value ? blackColor : whiteColor,
        ),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.badge, size: 30, color: primaryColor),
              title: const Text('Edit Profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => c.role.value == 'User'
                  ? Get.to(() => EditProfile(),
                      transition: Transition.rightToLeft)
                  : Get.to(() => TrainerEditProfile(),
                      transition: Transition.rightToLeft),
            ),
            c.role.value == 'User'
                ? ListTile(
                    leading: const Icon(Icons.card_membership,
                        size: 30, color: primaryColor),
                    title: const Text('Subscription'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () => Get.to(() => const SubscriptionPlan(),
                        transition: Transition.rightToLeft),
                  )
                : Container(),
            c.role.value == 'User'
                ? ListTile(
                    leading: const Icon(Icons.support,
                        size: 30, color: primaryColor),
                    title: const Text('Consulting History'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                    onTap: () => Get.to(() => ConsultHistory(),
                        transition: Transition.rightToLeft),
                  )
                : Container(),
            ListTile(
              leading: const Icon(Icons.location_city,
                  size: 30, color: primaryColor),
              title: const Text('Saved Address'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => Get.to(() => const SavedAddress(forOrder: false),
                  transition: Transition.rightToLeft),
            ),
            ListTile(
              leading: const Icon(Icons.help, size: 30, color: primaryColor),
              title: const Text('FAQ'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () =>
                  Get.to(() => Faq(), transition: Transition.rightToLeft),
            ),
            ListTile(
              leading: const Icon(Icons.group, size: 30, color: primaryColor),
              title: const Text('About us'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => Get.to(() => const AboutUs(),
                  transition: Transition.rightToLeft),
            ),
            ListTile(
              leading: const Icon(Icons.gavel, size: 30, color: primaryColor),
              title: const Text('Terms & Condition'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () =>
                  Get.to(() => Terms(), transition: Transition.rightToLeft),
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety,
                  size: 30, color: primaryColor),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              onTap: () => Get.to(() => PrivacyPolicy(),
                  transition: Transition.rightToLeft),
            ),
            ListTile(
                leading:
                    const Icon(Icons.logout, size: 30, color: primaryColor),
                title: const Text('Log out'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () => Get.defaultDialog(
                      title: 'Confirm Logout',
                      middleText: 'Are you sure you want to logout',
                      onConfirm: () => SharedPrefs().loginClear(),
                      textConfirm: 'Logout',
                      confirmTextColor: whiteColor,
                      onCancel: () => Get.back(),
                    )),
          ],
        ),
      ),
    );
  }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//       if (result != null) {
//         Get.to(() => ScanResult(result: result!.code ?? ''));
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

// class QRViewExample extends StatelessWidget {
//   final Function(QRViewController) onQRViewCreated;

//   QRViewExample({required this.onQRViewCreated});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: QRView(
//         key: GlobalKey(debugLabel: 'QR'),
//         onQRViewCreated: onQRViewCreated,
//       ),
//     );
//   }
}
