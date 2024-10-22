import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/media_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/salomon_screen/cubit/home_cubit.dart';
import 'package:btl_iot/salomon_screen/widget/card_iot.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                _header(context),
                _spaceHeight(16),
                _body(context),
                _spaceHeight(16),
                _titleGraph(),
                _spaceHeight(16),
                _graph(),
              ],
            ),
          );
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

  Widget _body(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.8,
      ),
      items: _listCard(context),
    );
  }

  Widget _spaceHeight(double height) {
    return SizedBox(height: height);
  }

  List<Widget> _listCard(BuildContext context) {
    return [
      CardIot(
        iconFirst: FontAwesomeIcons.temperatureLow,
        iconSecond: FontAwesomeIcons.temperatureHigh,
        colorIcon: ColorUtils.redAccent,
        unit: '°C',
        value: 28,
        min: 0,
        max: 50,
        iconFeature: FontAwesomeIcons.wind,
        feature: 'Nhiệt độ',
        device: 'Điều hòa:',
        checkActive: true,
        onTap: () {},
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.droplet,
        iconSecond: FontAwesomeIcons.water,
        colorIcon: ColorUtils.blueAccent,
        unit: '%',
        value: 65,
        min: 20,
        max: 90,
        iconFeature: FontAwesomeIcons.fan,
        feature: 'Độ ẩm',
        device: 'Quạt:',
        checkActive: true,
        onTap: () {},
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.moon,
        iconSecond: FontAwesomeIcons.sun,
        colorIcon: ColorUtils.yellowGold,
        unit: 'Lux',
        value: 450,
        min: 0,
        max: 4095,
        iconFeature: FontAwesomeIcons.lightbulb,
        feature: 'Ánh sáng',
        device: 'Đèn:',
        checkActive: true,
        onTap: () {},
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

  Widget _graph() {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 6,
          left: 6,
          top: 0,
          bottom: 12,
        ),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
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
      maxX: 10,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 3),
            FlSpot(2, 3),
            FlSpot(3, 3),
            FlSpot(4, 5),
            FlSpot(5, 5),
            FlSpot(6, 5),
            FlSpot(7, 4),
            FlSpot(8, 4),
            FlSpot(9, 4),
            FlSpot(10, 4),
          ],
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
          spots: const [
            FlSpot(0, 3.5),
            FlSpot(1, 3.5),
            FlSpot(2, 3.5),
            FlSpot(3, 3.5),
            FlSpot(4, 5.5),
            FlSpot(5, 5.5),
            FlSpot(6, 5.5),
            FlSpot(7, 4.5),
            FlSpot(8, 4.5),
            FlSpot(9, 4.5),
            FlSpot(10, 4.5),
          ],
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
          spots: const [
            FlSpot(0, 6.5),
            FlSpot(1, 6.5),
            FlSpot(2, 6.5),
            FlSpot(3, 6.5),
            FlSpot(4, 5.5),
            FlSpot(5, 5.5),
            FlSpot(6, 7.5),
            FlSpot(7, 7.5),
            FlSpot(8, 6.5),
            FlSpot(9, 6.5),
            FlSpot(10, 6.5),
          ],
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
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '12:00:01';
        break;
      case 3:
        text = '12:00:03';
        break;
      case 5:
        text = '12:00:05';
        break;
      case 7:
        text = '12:00:07';
        break;
      case 9:
        text = '12:00:09';
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
}
