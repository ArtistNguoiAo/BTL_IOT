import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/media_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/salomon_screen/cubit/home_cubit.dart';
import 'package:btl_iot/salomon_screen/widget/card_iot.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<String> imgList = [
    'Card1',
    'Card2',
    'Card3',
  ];

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
        colorIconFirst: ColorUtils.blueAccent,
        colorIconSecond: ColorUtils.redAccent,
        colorSlider: ColorUtils.redAccent,
        unitFirst: '(0°C)',
        unitSecond: '(50°C)',
        value: 20,
        min: 0,
        max: 50,
        iconFeature: FontAwesomeIcons.wind,
        feature: 'Nhiệt độ',
        device: 'Điều hòa:',
        onTap: () {},
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.temperatureLow,
        iconSecond: FontAwesomeIcons.water,
        colorIconFirst: ColorUtils.blueAccent.withOpacity(0.5),
        colorIconSecond: ColorUtils.blueAccent,
        colorSlider: ColorUtils.blueAccent,
        unitFirst: '(20%)',
        unitSecond: '(90%)',
        value: 20,
        min: 0,
        max: 50,
        iconFeature: FontAwesomeIcons.fan,
        feature: 'Độ ẩm',
        device: 'Quạt:',
        onTap: () {},
      ),
      CardIot(
        iconFirst: FontAwesomeIcons.moon,
        iconSecond: FontAwesomeIcons.sun,
        colorIconFirst: ColorUtils.yellowGold.withOpacity(0.5),
        colorIconSecond: ColorUtils.yellowGold,
        colorSlider: ColorUtils.yellowGold,
        unitFirst: '(6000Lux)',
        unitSecond: '(1Lux)',
        value: 20,
        min: 0,
        max: 50,
        iconFeature: FontAwesomeIcons.lightbulb,
        feature: 'Ánh sáng',
        device: 'Đèn:',
        onTap: () {},
      ),
    ];
  }
}
