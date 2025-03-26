import 'package:fit_food/Screens/Progress/graph_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Constants/export.dart';

class BmiGraph extends StatelessWidget {
  BmiGraph({Key? key}) : super(key: key);
  final c = Get.put(GetController());
  final c1 = Get.put(GraphController());
  @override
  Widget build(BuildContext context) {
    c1.getUserBmiData();
    return Column(
      children: [
        Obx(
          () => RoundedContainer(
            padding: const EdgeInsets.all(defaultPadding * 2),
            height: screenHeight * 0.4,
            width: screenWidth,
            color: whiteColor,
            borderColor: Colors.black26,
            isImage: false,
            child: SfCartesianChart(
              title: ChartTitle(text: 'BMI Graph'),
              plotAreaBorderWidth: 0.7,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
              ),
              backgroundColor: c.isDarkTheme.value ? blackColor : whiteColor,
              zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enableDoubleTapZooming: true,
                enableMouseWheelZooming: true,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: getDefaultData(),
              trackballBehavior: TrackballBehavior(
                enable: true,
                lineColor: primaryColor,
                activationMode: ActivationMode.singleTap,
                tooltipSettings:
                    const InteractiveTooltip(format: 'point.x : point.y'),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.top,
              ),
            ),
          ),
        ),
      ],
    );
  }

  RxList<LineSeries<UserGraphData, String>> getDefaultData() {
    return <LineSeries<UserGraphData, String>>[
      LineSeries(
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        dataSource: c1.userBmiData,
        name: 'BMI',
        markerSettings:
            const MarkerSettings(isVisible: true, image: AssetImage(logoWhite)),
        xValueMapper: (UserGraphData data, _) => data.date,
        yValueMapper: (UserGraphData data, _) => data.bmi,
      ),
      LineSeries(
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        dataSource: c1.userBmiData,
        name: 'Weight (in kg)',
        color: primaryColor,
        markerSettings: const MarkerSettings(
          isVisible: true,
          image: AssetImage(logoWhite),
        ),
        xValueMapper: (UserGraphData data, _) => data.date,
        yValueMapper: (UserGraphData data, _) => data.weight,
      ),
    ].obs;
  }
}
