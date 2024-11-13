import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

class CardIot extends StatelessWidget {
  const CardIot({
    super.key,
    required this.iconFirst,
    required this.iconSecond,
    required this.colorIcon,
    required this.unit,
    required this.value,
    required this.min,
    required this.max,
    required this.iconFeature,
    required this.feature,
    required this.device,
    required this.checkActive,
    required this.onTap,
  });

  final IconData iconFirst;
  final IconData iconSecond;
  final Color colorIcon;
  final String unit;
  final String value;
  final double min;
  final double max;
  final IconData iconFeature;
  final String feature;
  final String device;
  final bool checkActive;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ColorUtils.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ColorUtils.primaryColor.withOpacity(0.5),
          width: 2,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              feature,
              style: TextStyleUtils.textStyleNunitoS20W700Black,
            ),
            Row(
              children: [
                FaIcon(
                  iconFirst,
                  color: colorIcon,
                ),
                Expanded(
                  child: Slider(
                      value: double.parse(value),
                      onChanged: (value) {},
                      min: min,
                      max: max,
                      divisions: 100,
                      activeColor: colorIcon,
                      inactiveColor: colorIcon.withOpacity(0.2),
                    )
                ),
                FaIcon(
                  iconSecond,
                  color: colorIcon,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  '(${min.toInt()}$unit)',
                  style: TextStyleUtils.textStyleNunitoS16W400Black,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      value.toString(),
                      style: TextStyleUtils.textStyleNunitoS24W700Black,
                    ),
                  ),
                ),
                Text(
                  '(${max.toInt()}$unit)',
                  style: TextStyleUtils.textStyleNunitoS16W400Black,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  device,
                  style: TextStyleUtils.textStyleNunitoS16W400Black,
                ),
                Expanded(child: Container()),
                LiteRollingSwitch(
                  value: checkActive,
                  width: 120,
                  textOn: 'Active',
                  textOff: 'Inactive',
                  textSize: 16,
                  colorOn: ColorUtils.primaryColor,
                  colorOff: ColorUtils.grey,
                  textOnColor: ColorUtils.white,
                  iconOn: iconFeature,
                  iconOff: FontAwesomeIcons.powerOff,
                  animationDuration: const Duration(milliseconds: 200),
                  onChanged: (bool state) {

                  },
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: onTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
