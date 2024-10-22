import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

class RangeSliderChoice extends StatefulWidget {
  const RangeSliderChoice({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.minController,
    required this.maxController,
    required this.color,
    required this.title,
  });

  final double minValue;
  final double maxValue;
  final TextEditingController minController;
  final TextEditingController maxController;
  final Color color;
  final String title;

  @override
  State<RangeSliderChoice> createState() => _RangeSliderChoiceState();
}

class _RangeSliderChoiceState extends State<RangeSliderChoice> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      double.tryParse(widget.minController.text) ?? widget.minValue,
      double.tryParse(widget.maxController.text) ?? widget.maxValue,
    );
  }

  void _onSliderChange(RangeValues values) {
    setState(() {
      _currentRangeValues = values;
      widget.minController.text = values.start.toStringAsFixed(0);
      widget.maxController.text = values.end.toStringAsFixed(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                widget.title,
                style: TextStyleUtils.textStyleNunitoS18W600Black,
              ),
            ),
            Expanded(
              child: RangeSlider(
                values: _currentRangeValues,
                min: widget.minValue,
                max: widget.maxValue,
                activeColor: widget.color,
                inactiveColor: widget.color.withOpacity(0.2),
                divisions: (widget.maxValue - widget.minValue).round(),
                labels: RangeLabels(
                  _currentRangeValues.start.round().toString(),
                  _currentRangeValues.end.round().toString(),
                ),
                onChanged: _onSliderChange,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                ),
                child: TextField(
                  controller: widget.minController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Min...",
                    labelText: "Min",
                    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.grey)),
                  ),
                  onChanged: (value) {
                    double minValue = double.tryParse(value) ?? widget.minValue;
                    if (minValue < _currentRangeValues.end && minValue >= widget.minValue) {
                      _onSliderChange(RangeValues(minValue, _currentRangeValues.end));
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: ColorUtils.white,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                ),
                child: TextField(
                  controller: widget.maxController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Max...",
                    labelText: "Max",
                    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.grey)),
                  ),
                  onChanged: (value) {
                    double maxValue = double.tryParse(value) ?? widget.maxValue;
                    if (maxValue > _currentRangeValues.start && maxValue <= widget.maxValue) {
                      _onSliderChange(RangeValues(_currentRangeValues.start, maxValue));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
