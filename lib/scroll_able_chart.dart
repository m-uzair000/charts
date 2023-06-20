import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ScrollableAreaChart extends StatefulWidget {
  @override
  _ScrollableAreaChartState createState() => _ScrollableAreaChartState();
}

class _ScrollableAreaChartState extends State<ScrollableAreaChart> {
  // Sample data
  final List<double> data = [100, 200, 150, 300, 250, 400];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Scrollable Area Chart'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: data.length * 80.0, // Adjust width as needed
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: data.length.toDouble() - 1,
              minY: 0,
              maxY: 500,
              lineBarsData: [
                LineChartBarData(
                  spots: _generateSpots(),
                  isCurved: true,
                  barWidth: 4,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                  ),
                ),
              ],
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(value.toString());
                    },
                    reservedSize: 30,
                  ),
                    drawBelowEverything:false,

                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Center(child: Text(value.toString()));
                    },
                    reservedSize: 50,
                  ),
                ),
              ),
              gridData: FlGridData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots() {
    final List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i]));
    }
    return spots;
  }
}