import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample5 extends StatefulWidget {
  final Color gradientColor1 = const Color(0xff5051F9).withOpacity(0.8);
  final Color gradientColor2 = const Color(0xff5051F9).withOpacity(0.4);
  final Color gradientColor3 = const Color(0xff5051F9).withOpacity(0.1);
  final Color indicatorStrokeColor = const Color(0xff5051F9);

  @override
  State<LineChartSample5> createState() => _LineChartSample5State();
}

class _LineChartSample5State extends State<LineChartSample5> {
  List<int> showingTooltipOnSpots = [1, 3, 5];
  final List<double> data = [100, 200, 150, 300, 250, 400, 300, 370];
  double minX = 0.0, maxX = 3.0;

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: _generateSpots(),
        isCurved: true,
        barWidth: 3,
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(colors: [
            widget.gradientColor1,
            widget.gradientColor2,
            widget.gradientColor3,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        // dotData: const FlDotData(show: true,),
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            return FlDotCirclePainter(
              radius: 5.5,
              color: const Color(0xff5051F9),
              strokeWidth: 2,
              strokeColor: Colors.white,
            );
          },
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xff5051F9),
            Color(0xff5051F9),
            Color(0xff5051F9),
          ],
        ),
      ),
    ];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              width: data.length * 80,
              height: MediaQuery.of(context).size.height / 3,
              child: LineChart(
                LineChartData(
                  minX: 0,
                  maxX: data.length - 1.toDouble(),
                  minY: 0,
                  maxY: 500,
                  lineTouchData: LineTouchData(
                    enabled: true,
                    handleBuiltInTouches: true,
                    touchCallback:
                        (FlTouchEvent event, LineTouchResponse? response) {
                      if (response == null || response.lineBarSpots == null) {
                        return;
                      }
                      if (event is FlTapUpEvent) {
                        final spotIndex =
                            response.lineBarSpots!.first.spotIndex;
                        setState(() {
                          if (showingTooltipOnSpots.contains(spotIndex)) {
                            showingTooltipOnSpots.remove(spotIndex);
                          } else {
                            showingTooltipOnSpots.add(spotIndex);
                          }
                        });
                      }
                    },
                    mouseCursorResolver:
                        (FlTouchEvent event, LineTouchResponse? response) {
                      if (response == null || response.lineBarSpots == null) {
                        return SystemMouseCursors.basic;
                      }
                      return SystemMouseCursors.click;
                    },
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> spotIndexes) {
                      return spotIndexes.map((index) {
                        return  TouchedSpotIndicatorData(
                          FlLine(
                            color: const Color(0xff5051F9).withOpacity(0.2),
                          ),
                          const FlDotData(
                            show: true,
                          ),
                        );
                      }).toList();
                    },
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: const Color(0xff5051F9).withOpacity(0.8),
                      tooltipRoundedRadius: 4,
                      getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                        return lineBarsSpot.map((lineBarSpot) {
                          return LineTooltipItem(
                            lineBarSpot.y.toString(),
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  lineBarsData: lineBarsData,
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 100,
                        getTitlesWidget: (value, ds) {
                          return Text(
                            ds.formattedValue,
                            textAlign: TextAlign.center,
                          );
                        },
                        reservedSize: 50,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return bottomTitleWidgets(
                            value,
                            meta,
                            double.infinity,
                          );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return SizedBox(
                            width: 5,
                          );
                          // return bottomTitleWidgets(
                          //   value,
                          //   meta,
                          //   double.infinity,
                          // );
                        },
                        reservedSize: 30,
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          return SizedBox(
                            width: 5,
                          );
                          // return bottomTitleWidgets(
                          //   value,
                          //   meta,
                          //   double.infinity,
                          // );
                        },
                        reservedSize: 30,
                      ),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) {
                      return const FlLine(
                        color: Color(0xffE7EBEC),
                        strokeWidth: 0.8,
                      );
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                    border: Border.all(
                      color: const Color(0xff5051F9),
                    ),
                  ),
                ),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    if (minX > 0.0) {
                      setState(() {
                        minX = minX - 4;
                        maxX = maxX - 4;
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
              IconButton(
                  onPressed: () {
                    if (maxX < 11.0) {
                      setState(() {
                        minX = minX + 4;
                        maxX = maxX + 4;
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: LineChart(
              LineChartData(
                minX: minX,
                maxX: maxX,
                minY: 0,
                maxY: 500,
                lineTouchData: LineTouchData(
                  enabled: true,
                  handleBuiltInTouches: true,
                  touchCallback:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null ||
                        response.lineBarSpots == null) {
                      return;
                    }
                    if (event is FlTapUpEvent) {
                      final spotIndex =
                          response.lineBarSpots!.first.spotIndex;
                      setState(() {
                        if (showingTooltipOnSpots.contains(spotIndex)) {
                          showingTooltipOnSpots.remove(spotIndex);
                        } else {
                          showingTooltipOnSpots.add(spotIndex);
                        }
                      });
                    }
                  },
                  mouseCursorResolver:
                      (FlTouchEvent event, LineTouchResponse? response) {
                    if (response == null ||
                        response.lineBarSpots == null) {
                      return SystemMouseCursors.basic;
                    }
                    return SystemMouseCursors.click;
                  },
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> spotIndexes) {
                    return spotIndexes.map((index) {
                      return TouchedSpotIndicatorData(
                        FlLine(
                          color: const Color(0xff5051F9).withOpacity(0.2),
                        ),
                        const FlDotData(
                          show: true,
                        ),
                      );
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor:
                        const Color(0xff5051F9).withOpacity(0.8),
                    tooltipRoundedRadius: 4,
                    getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                      return lineBarsSpot.map((lineBarSpot) {
                        return LineTooltipItem(
                          lineBarSpot.y.toString(),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }).toList();
                    },
                  ),
                ),
                lineBarsData: lineBarsData,
                titlesData: FlTitlesData(
                  show: true,
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 100,
                      getTitlesWidget: (value, ds) {
                        return Text(
                          ds.formattedValue,
                          textAlign: TextAlign.center,
                        );
                      },
                      reservedSize: 50,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return bottomTitleWidgets(
                          value,
                          meta,
                          double.infinity,
                        );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SizedBox(
                          width: 5,
                        );
                        // return bottomTitleWidgets(
                        //   value,
                        //   meta,
                        //   double.infinity,
                        // );
                      },
                      reservedSize: 30,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return SizedBox(
                          width: 5,
                        );
                        // return bottomTitleWidgets(
                        //   value,
                        //   meta,
                        //   double.infinity,
                        // );
                      },
                      reservedSize: 30,
                    ),
                  ),
                ),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  drawVerticalLine: false,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(
                      color: Color(0xffE7EBEC),
                      strokeWidth: 0.8,
                    );
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                  border: Border.all(
                    color: const Color(0xff5051F9),
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            ),
          ),
        ],
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

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: 'Digital',
      color: Colors.grey,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        return const SizedBox();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }
}
