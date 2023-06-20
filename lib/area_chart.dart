import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class AreaChartSyncfusion extends StatefulWidget {
  const AreaChartSyncfusion({Key? key}) : super(key: key);

  @override
  State<AreaChartSyncfusion> createState() => _AreaChartSyncfusionState();
}

class _AreaChartSyncfusionState extends State<AreaChartSyncfusion> {
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40),
    _SalesData('Jun', 25),
    _SalesData('July', 20),
    _SalesData('Aug', 100),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Line Chart Syncfusion"),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
            width: size.width,
            height: size.height/2,
            child: SfSparkAreaChart(
                axisLineWidth:0,
                data: <double>[
                  10,6, 8, -5, 11, 5, -2, 7, -3, 6, 8, 10
                ],
              marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                  shape: SparkChartMarkerShape.circle,
                  borderColor: Colors.white,
                  color: Colors.blueAccent,
                  size: 12,
                  borderWidth: 5),
              labelDisplayMode: SparkChartLabelDisplayMode.all,
              trackball: SparkChartTrackball(activationMode: SparkChartActivationMode.tap),
            )
        ),
      ),
    );
  }
}
class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
