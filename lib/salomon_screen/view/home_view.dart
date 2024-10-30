import 'package:btl_iot/core/helper/string_helper.dart';
import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/media_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/core/widget/base_loading.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:btl_iot/salomon_screen/cubit/home_cubit.dart';
import 'package:btl_iot/salomon_screen/widget/card_iot.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  List<String> listTimeData = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..init(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if(state is HomeLoaded) {
            listTimeData = state.listSensorData.reversed.map((e) => StringHelper.convertTimeToStringOnlyTime(e.time)).toList();
          }
        },
        builder: (context, state) {
          if(state is HomeLoading) {
            return const BaseLoading();
          }
          if(state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _header(context),
                  _spaceHeight(16),
                  _body(
                    context: context,
                    checkActiveTemperature: state.checkActiveTemperature,
                    checkActiveHumidity: state.checkActiveHumidity,
                    checkActiveLight: state.checkActiveLight,
                    listSensorData: state.listSensorData,
                  ),
                  _spaceHeight(16),
                  _titleGraph(),
                  _spaceHeight(16),
                  _graph(state.listSensorData),
                  _description(),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _header(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          Container(
              height: 150,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              width: double.infinity,
              color: ColorUtils.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Welcome to IoT world!",
                          style: TextStyleUtils.textStyleNunitoS24W700White,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.bell,
                        color: ColorUtils.white,
                      ),
                    ],
                  ),
                  Text(
                    "I'm virtual assistant T_IOT. How can I help you?",
                    style: TextStyleUtils.textStyleNunitoS16W400White,
                  ),
                ],
              )
          ),
          Positioned(
            top: 100,
            left: 16,
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width - 32,
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ColorUtils.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(MediaUtils.imgAvatar),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyleUtils.textStyleNunitoS16W400Black,
                          ),
                          Text(
                            'Lê Quốc Trung',
                            style: TextStyleUtils.textStyleNunitoS20W700Black,
                          ),
                          Text(
                            'Have a good day!',
                            style: TextStyleUtils.textStyleNunitoS16W400Black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    FaIcon(
                      FontAwesomeIcons.feather,
                      color: ColorUtils.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body({
    required BuildContext context,
    required bool checkActiveTemperature,
    required bool checkActiveHumidity,
    required bool checkActiveLight,
    required List<SensorDataEntity> listSensorData,
  }) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
        // autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {
          context.read<HomeCubit>().init();
        },
      ),
      items: _listCard(
        context: context,
        checkActiveTemperature: checkActiveTemperature,
        checkActiveHumidity: checkActiveHumidity,
        checkActiveLight: checkActiveLight,
        listSensorData: listSensorData,
      ),
    );
  }

  Widget _spaceHeight(double height) {
    return SizedBox(height: height);
  }

  List<Widget> _listCard({
    required BuildContext context,
    required bool checkActiveTemperature,
    required bool checkActiveHumidity,
    required bool checkActiveLight,
    required List<SensorDataEntity> listSensorData,
  }) {
    return [
      CardIot(
        iconFirst: FontAwesomeIcons.temperatureLow,
        iconSecond: FontAwesomeIcons.temperatureHigh,
        colorIcon: ColorUtils.redAccent,
        unit: '°C',
        value: listSensorData.first.temperature,
        min: 0,
        max: 100,
        iconFeature: FontAwesomeIcons.wind,
        feature: 'Nhiệt độ',
        device: 'Điều hòa:',
        checkActive: checkActiveTemperature,
        onTap: () {
          context.read<HomeCubit>().switchStatus(status: !checkActiveTemperature, device: 0);
        },
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.droplet,
        iconSecond: FontAwesomeIcons.water,
        colorIcon: ColorUtils.blueAccent,
        unit: '%',
        value: listSensorData.first.humidity,
        min: 0,
        max: 100,
        iconFeature: FontAwesomeIcons.fan,
        feature: 'Độ ẩm',
        device: 'Quạt:',
        checkActive: checkActiveHumidity,
        onTap: () {
          context.read<HomeCubit>().switchStatus(status: !checkActiveHumidity, device: 1);
        },
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.moon,
        iconSecond: FontAwesomeIcons.sun,
        colorIcon: ColorUtils.yellowGold,
        unit: 'Lux',
        value: listSensorData.first.light,
        min: 0,
        max: 4095,
        iconFeature: FontAwesomeIcons.lightbulb,
        feature: 'Ánh sáng',
        device: 'Đèn:',
        checkActive: checkActiveLight,
        onTap: () {
          context.read<HomeCubit>().switchStatus(status: !checkActiveLight, device: 2);
        },
      ),
    ];
  }

  Widget _titleGraph() {
    return Text(
      'Biểu đồ',
      style: TextStyleUtils.textStyleNunitoS24W700Black,
    );
  }

  List<Color> blueGradientColors = [
    ColorUtils.blueAccent,
    ColorUtils.blueAccent,
  ];

  List<Color> redGradientColors = [
    ColorUtils.redAccent,
    ColorUtils.redAccent,
  ];

  List<Color> yellowGradientColors = [
    ColorUtils.yellowGold,
    ColorUtils.yellowGold,
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
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 16,
          ),
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
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: listSensorData.asMap().entries.map((entry) {
            int reversedIndex = listSensorData.length - 1 - entry.key;
            return FlSpot(reversedIndex.toDouble(), entry.value.temperature / 10);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: redGradientColors,
          ),
          barWidth: 2,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: listSensorData.asMap().entries.map((entry) {
            int reversedIndex = listSensorData.length - 1 - entry.key;
            return FlSpot(reversedIndex.toDouble(), entry.value.humidity / 10);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: blueGradientColors,
          ),
          barWidth: 2,
          dotData: const FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: listSensorData.asMap().entries.map((entry) {
            int reversedIndex = listSensorData.length - 1 - entry.key;
            return FlSpot(reversedIndex.toDouble(), entry.value.light / 409.5);
          }).toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: yellowGradientColors,
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

  Widget leftTitleWidgets(double value, TitleMeta meta) {
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
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '409';
        break;
      case 3:
        text = '1229';
        break;
      case 5:
        text = '2048';
        break;
      case 7:
        text = '2867';
        break;
      case 9:
        text = '3686';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.right);
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Chú thích',
            style: TextStyleUtils.textStyleNunitoS24W700Black,
          ),
          _spaceHeight(8),
          Row(
            children: [
              Container(
                height: 12,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorUtils.redAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                'Nhiệt độ',
                style: TextStyleUtils.textStyleNunitoS16W400Black,
              )
            ],
          ),
          _spaceHeight(8),
          Row(
            children: [
              Container(
                height: 12,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorUtils.blueAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                'Độ ẩm',
                style: TextStyleUtils.textStyleNunitoS16W400Black,
              )
            ],
          ),
          _spaceHeight(8),
          Row(
            children: [
              Container(
                height: 12,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorUtils.yellowGold,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                'Ánh sáng',
                style: TextStyleUtils.textStyleNunitoS16W400Black,
              )
            ],
          ),
        ],
      ),
    );
  }
}
