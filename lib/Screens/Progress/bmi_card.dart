import '../../Constants/export.dart';
import 'graph_controller.dart';

class BMICard extends StatefulWidget {
  const BMICard({super.key});

  @override
  State<BMICard> createState() => _BMICardState();
}

class _BMICardState extends State<BMICard> {
  final editKey = GlobalKey<FormState>();
  final c = Get.put(GetController());
  final c1 = Get.put(GraphController());
  final editWeight = TextEditingController();
  final editHeight = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RoundedContainer(
        padding: const EdgeInsets.all(defaultPadding * 2),
        borderColor: c.isNormal.value
            ? primaryColor
            : c.isUnderWt.value
                ? yellowColor
                : redColor,
        color: whiteColor,
        isImage: false,
        child: c1.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: c.isNormal.value
                        ? Text('HEALTHY', style: Style.mediumTextStyle)
                        : c.isUnderWt.value
                            ? Text('UNDERWEIGHT', style: Style.mediumTextStyle)
                            : Text('OVERWEIGHT', style: Style.mediumTextStyle),
                  ),
                  Flexible(
                    child: c.isNormal.value
                        ? Text('You have a normal body weight\nGood job!',
                            style: Style.lighttextStyle, textAlign: TextAlign.center)
                        : c.isUnderWt.value
                            ? Text('You have lower than normal body weight',
                                style: Style.lighttextStyle,
                                textAlign: TextAlign.center)
                            : Text('You have a higher than normal body weight',
                                style: Style.lighttextStyle,
                                textAlign: TextAlign.center),
                  ),
                  Row(
                    children: [
                      Image.asset(bmiIcon),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your current BMI \nIndex : ',
                              style: Style.smalltextStyle,
                            ),
                            Row(
                              children: [
                                Text(
                                  c.bmi.value.toStringAsFixed(2),
                                  style: TextStyle(
                                    color: c.isNormal.value
                                        ? primaryColor
                                        : c.isUnderWt.value
                                            ? yellowColor
                                            : redColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: OutlinedButton.icon(
                                    style: OutlinedButton.styleFrom(
                                      visualDensity: VisualDensity.compact,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    onPressed: () => showEditDialog(),
                                    icon: const Icon(Icons.edit,
                                        color: primaryColor, size: 14),
                                    label: FittedBox(
                                      child: Text('Weight', style: Style.mediumColorTextStyle),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [yellowColor, primaryColor, redColor],
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('<18.5', style: Style.normalWTextStyle),
                        Text('18.5 - 25.5', style: Style.normalWTextStyle),
                        Text('>25.5', style: Style.normalWTextStyle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Underweight', style: Style.smalltextStyle),
                      Text('Perfect', style: Style.smalltextStyle),
                      Text('Overweight', style: Style.smalltextStyle),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  showEditDialog() {
    return Get.defaultDialog(
      title: 'Edit Measurements',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: Form(
          key: editKey,
          child: Column(
            children: [
              Text(
                'Please enter your\ncurrent weight',
                style: Style.normalLightTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: editWeight,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'This is required' : null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(defaultPadding),
                  hintText: 'Weight in kg',
                  prefixIcon: Icon(Icons.monitor_weight),
                  suffixIcon: Icon(Icons.edit),
                ),
              ),
              const SizedBox(height: 5),
              OutlinedButton(
                onPressed: () async {
                  final isValid = editKey.currentState!.validate();
                  if (isValid) {
                    await ProfileUtils().addWeightForBmi(editWeight.text);
                    editWeight.clear();
                      editHeight.clear();
                    Get.back();
                    // Refresh BMI data
                    await c1.refreshData();
                  }
                },
                child: Text('Update', style: Style.smallColortextStyle),
              )
            ],
          ),
        ),
      ),
    );
  }
}
