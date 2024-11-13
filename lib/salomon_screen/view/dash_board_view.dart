import 'dart:math';

import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/entity/sensor_data_entity.dart';
import 'package:btl_iot/salomon_screen/cubit/dash_board_cubit.dart';
import 'package:btl_iot/salomon_screen/widget/card_iot.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({super.key});

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      DashBoardCubit()
        ..init(),
      child: BlocConsumer<DashBoardCubit, DashBoardState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if(state is DashBoardLoaded) {
            return Scaffold(
              appBar: AppBar(
                leading: Container(),
                title: Text(
                  "Bai 5",
                  style: TextStyleUtils.textStyleNunitoS24W700White,
                ),
                centerTitle: true,
                backgroundColor: ColorUtils.primaryColor,
              ),
              body: Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 190,
                    // autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    onPageChanged: (index, reason) {
                      //context.read<HomeCubit>().init();
                    },
                  ),
                  items: _listCard(
                    context: context,
                    checkActiveTemperature: state.checkCB1,
                    checkActiveHumidity: state.checkCB2,
                    checkActiveLight: state.checkCB3,
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

  List<Widget> _listCard({
    required BuildContext context,
    required bool checkActiveTemperature,
    required bool checkActiveHumidity,
    required bool checkActiveLight,
  }) {
    return [
      CardIot(
        iconFirst: FontAwesomeIcons.temperatureLow,
        iconSecond: FontAwesomeIcons.temperatureHigh,
        colorIcon: ColorUtils.redAccent,
        unit: '',
        value: Random().nextInt(101).toString(),
        min: 0,
        max: 100,
        iconFeature: FontAwesomeIcons.wind,
        feature: 'Cảm biến 1',
        device: 'Thiết bị 1:',
        checkActive: checkActiveTemperature,
        onTap: () {
          context.read<DashBoardCubit>().switchStatus(
              status: !checkActiveTemperature, device: 3);
        },
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.droplet,
        iconSecond: FontAwesomeIcons.water,
        colorIcon: ColorUtils.blueAccent,
        unit: '',
        value: Random().nextInt(101).toString(),
        min: 0,
        max: 100,
        iconFeature: FontAwesomeIcons.fan,
        feature: 'Cảm biến 2',
        device: 'Thiết bị 2:',
        checkActive: checkActiveHumidity,
        onTap: () {
          context.read<DashBoardCubit>().switchStatus(
              status: !checkActiveHumidity, device: 4);
        },
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.moon,
        iconSecond: FontAwesomeIcons.sun,
        colorIcon: ColorUtils.yellowGold,
        unit: '',
        value: Random().nextInt(101).toString(),
        min: 0,
        max: 100,
        iconFeature: FontAwesomeIcons.lightbulb,
        feature: 'Cảm biến 3',
        device: 'Thiết bị 3:',
        checkActive: checkActiveLight,
        onTap: () {
          context.read<DashBoardCubit>().switchStatus(
              status: !checkActiveLight, device: 5);
        },
      ),
    ];
  }

}
