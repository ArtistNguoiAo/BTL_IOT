import 'dart:async';
import 'dart:math';

import 'package:btl_iot/core/helper/string_helper.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:btl_iot/wind_screen/cubit/wind_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WindScreen extends StatefulWidget {
  const WindScreen({super.key});

  @override
  State<WindScreen> createState() => _WindScreenState();
}

class _WindScreenState extends State<WindScreen> with SingleTickerProviderStateMixin{
  List<String> listTimeData = [];
  Color _currentColor = Colors.red;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WindCubit()..init(),
      child: BlocConsumer<WindCubit, WindState>(
        listener: (context, state) {
          if(state is WindLoaded) {
            _timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
              setState(() {
                _currentColor = _currentColor == Colors.red ? Colors.white : Colors.red;
              });
            });
            Future.delayed(const Duration(milliseconds: 1500), () {
              _timer.cancel();
              setState(() {
                _currentColor = Colors.white;
              });
            });

            listTimeData = state.listSensorDataEntity.reversed.map((e) => StringHelper.convertTimeToStringOnlyTime(e.time)).toList();
          }
        },
        builder: (context, state) {
          if(state is WindLoaded) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorUtils.primaryColor,
                title: Text(
                  'Bao cao bai 5',
                  style: TextStyle(
                    color: ColorUtils.white,
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 80,
                        child: _graph(state.listSensorDataEntity)
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: ColorUtils.white,
                              border: Border.all(
                                color: ColorUtils.primaryColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              state.wind.toString() + 'm/s',
                            ),
                          ),
                          if(state.check == false)
                            Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: ColorUtils.white,
                                border: Border.all(
                                  color: ColorUtils.primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.triangleExclamation,
                                color: ColorUtils.yellowGold,
                              ),
                            )
                          else
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 100,
                              decoration: BoxDecoration(
                                color: _currentColor,
                                border: Border.all(
                                  color: ColorUtils.primaryColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 100,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.triangleExclamation,
                                  color: ColorUtils.yellowGold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  List<Color> greenGradientColors = [
    Colors.green,
    Colors.green,
  ];

  Widget _graph(List<SensorDataEntity> listSensorData) {
    return AspectRatio(
      aspectRatio: 1.50,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
          left: 6,
          top: 0,
          bottom: 12,
        ),
        child: LineChart(
          mainData(listSensorData),
        ),
      ),
    );
  }

  LineChartData mainData(List<SensorDataEntity> listSensorData) {
    return LineChartData(
      backgroundColor: ColorUtils.white,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: ColorUtils.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: ColorUtils.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: rightTitleWidgets,
            reservedSize: 28,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
      ),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 11,
      lineBarsData: [
        LineChartBarData(
          spots: listSensorData.asMap().entries.map((entry) {
            int reversedIndex = listSensorData.length - 1 - entry.key;
            return FlSpot(reversedIndex.toDouble(), double.parse(entry.value.wind) / 10);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: greenGradientColors,
          ),
          barWidth: 2,
          dotData: const FlDotData(
            show: false,
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              const textStyle = TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              );

              // Kiểm tra barIndex và chỉnh sửa giá trị và nhãn
              double modifiedY = touchedSpot.y;
              String label = '';
              String init = '';

              if (touchedSpot.barIndex == 0) {
                modifiedY *= 10; // Đồ thị 1
                label = 'Nhiệt độ: ';
                init = '°C';
              } else if (touchedSpot.barIndex == 1) {
                modifiedY *= 10; // Đồ thị 2
                label = 'Độ ẩm: ';
                init = '%';
              } else if (touchedSpot.barIndex == 2) {
                modifiedY *= 409.5; // Đồ thị 2
                label = 'Ánh sáng: ';
                init = 'Lux';
              }

              return LineTooltipItem(
                '$label${modifiedY.toStringAsFixed(1)} $init',
                textStyle,
              );
            }).toList();
          },
        ),
        touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {
          if (touchResponse != null &&
              touchResponse.lineBarSpots != null &&
              event is FlTapUpEvent) {
            final touchedSpot = touchResponse.lineBarSpots!.first;

            double modifiedY = touchedSpot.y;
            String label = '';

            if (touchedSpot.barIndex == 0) {
              modifiedY *= 10;
              label = 'Nhiệt độ: ';
            } else if (touchedSpot.barIndex == 1) {
              modifiedY *= 100;
              label = 'Độ ẩm: ';
            }else if (touchedSpot.barIndex == 2) {
              modifiedY *= 409.5; // Đồ thị 2
              label = 'Ánh sáng: ';
            }
          }
        },
        handleBuiltInTouches: true,
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, ) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = listTimeData[0];
        break;
      case 3:
        text = listTimeData[3];
        break;
      case 6:
        text = listTimeData[6];
        break;
      case 9:
        text = listTimeData[9];
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10';
        break;
      case 3:
        text = '30';
        break;
      case 5:
        text = '50';
        break;
      case 7:
        text = '70';
        break;
      case 9:
        text = '90';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.right);
  }
}
