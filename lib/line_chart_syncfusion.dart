import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class LineChartSyncfusion extends StatefulWidget {
  const LineChartSyncfusion({Key? key}) : super(key: key);

  @override
  State<LineChartSyncfusion> createState() => _LineChartSyncfusionState();
}

class _LineChartSyncfusionState extends State<LineChartSyncfusion> {
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
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    isVisible: true
                  ),
                  // Chart title
                  // title: ChartTitle(text: 'Half yearly sales analysis'),
                  // Enable legend
                  legend: Legend(isVisible: true),

                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                        dataSource: data,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales',
                        // Enable data label
                        dataLabelSettings:  DataLabelSettings(
                            isVisible: true,
                            borderColor: Colors.lightBlueAccent))
                  ]),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  //Initialize the spark charts widget
                  child: SfSparkLineChart.custom(
                    //Enable the trackball
                    trackball: SparkChartTrackball(
                        activationMode: SparkChartActivationMode.tap),
                    //Enable marker
                    marker: SparkChartMarker(
                        displayMode: SparkChartMarkerDisplayMode.all,
                        shape: SparkChartMarkerShape.circle,
                        borderColor: Colors.white,
                        color: Colors.blueAccent,
                        size: 12,
                        borderWidth: 5),
                    //Enable data label
                    labelDisplayMode: SparkChartLabelDisplayMode.all,
                    xValueMapper: (int index) => data[index].year,
                    yValueMapper: (int index) => data[index].sales,
                    dataCount: 5,

                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
