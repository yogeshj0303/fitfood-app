import 'package:fit_food/Constants/export.dart';

class UserHealthDetail extends StatelessWidget {
  UserHealthDetail({super.key});
  final c = Get.put(GetController());

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
            'Health Card Details',
            style: TextStyle(
              color: c.isDarkTheme.value ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 8),
                userDetail(size),
                Divider(
                  color: c.isDarkTheme.value ? Colors.white38 : Colors.black38,
                ),
                Container(
                  margin: const EdgeInsets.all(defaultPadding),
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color:
                        c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: c.isDarkTheme.value
                            ? Colors.black12
                            : Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(wtnormal, height: 120),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailText(
                              'BMI', c.bmi.value.toStringAsFixed(2)),
                          const SizedBox(height: 8),
                          Text(
                            'Height : ${_convertCmToFeetInches(c.height.value)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: c.isDarkTheme.value
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildDetailText('Weight', '${c.weight.value} kg'),
                          const SizedBox(height: 8),
                          _buildDetailText('Goal', c.goal.value),
                          const SizedBox(height: 8),
                          _buildDetailText('Preference', c.pref.value),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: c.isDarkTheme.value ? Colors.white38 : Colors.black38,
                ),
                const SizedBox(height: 12),
                Text(
                  'BMI Card',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          c.isDarkTheme.value ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: c.isDarkTheme.value
                              ? Colors.black12
                              : Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const BMICard(),
                  ),
                ),
                const SizedBox(height: defaultPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _convertCmToFeetInches(String value) {
    try {
      // Parse the input string to double
      double cm = double.parse(value);

      // Validate input
      if (cm <= 0) return "0 feet 0 inches";

      // Conversion factors
      const double cmToInches = 0.393701;
      const int inchesPerFoot = 12;

      // Convert cm to total inches
      double totalInches = cm * cmToInches;

      // Calculate feet and remaining inches
      int feet = (totalInches / inchesPerFoot).floor();
      int inches = (totalInches % inchesPerFoot).round();

      // Handle pluralization
      String feetText = feet == 1 ? 'foot' : 'feet';
      String inchesText = inches == 1 ? 'inch' : 'inches';

      // Return formatted string
      return '$feet $feetText $inches $inchesText';
    } catch (e) {
      // Handle parsing errors or invalid input
      return 'Invalid height';
    }
  }

  Widget _buildDetailText(String label, String value) {
    return Text(
      '$label : $value',
      style: TextStyle(
        fontSize: 14,
        color: c.isDarkTheme.value ? Colors.white70 : Colors.black54,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Column userDetail(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userImg(),
        const SizedBox(height: 8),
        Column(
          children: [
            Text(
              c.name.value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: c.isDarkTheme.value ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              c.phone.value,
              style: TextStyle(
                color: c.isDarkTheme.value ? Colors.white70 : Colors.black54,
              ),
            ),
            const SizedBox(height: 5),
            if (c.isSubscribed.value)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.workspace_premium, color: primaryColor),
                  const SizedBox(width: 2),
                  Text(
                    '${c.planName.value} Plan',
                    style: TextStyle(
                      color:
                          c.isDarkTheme.value ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 5),
            Text(
              c.mail.value,
              style: TextStyle(
                color: c.isDarkTheme.value ? Colors.white70 : Colors.black54,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  CircleAvatar userImg() {
    return c.userDP.value == ''
        ? const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage(profileImg),
          )
        : CircleAvatar(
            radius: 72,
            backgroundColor: whiteColor,
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage('$imgPath/${c.userDP.value}'),
            ),
          );
  }
}
