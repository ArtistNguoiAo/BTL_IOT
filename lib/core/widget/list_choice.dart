import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

class ListChoice extends StatefulWidget {
  const ListChoice({
    super.key,
    required this.title,
    required this.list,
    required this.value,
    required this.onTap,
  });

  final String title;
  final List<String> list;
  final String value;
  final Function(String) onTap;

  @override
  State<ListChoice> createState() => _ListChoiceState();
}

class _ListChoiceState extends State<ListChoice> {
  String valueChoice = '';

  @override
  void initState() {
    valueChoice = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: TextStyleUtils.textStyleNunitoS18W600Black,
        ),
        Expanded(
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(
                      widget.list[index],
                      style: TextStyleUtils.textStyleNunitoS16W400Black,
                    ),
                    selectedColor: ColorUtils.white,
                    backgroundColor: ColorUtils.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: ColorUtils.primaryColor,
                      ),
                    ),
                    selected: valueChoice == widget.list[index],
                    onSelected: (value) {
                      setState(() {
                        if(valueChoice == widget.list[index]) {
                          valueChoice = '';
                        }
                        else {
                          valueChoice = widget.list[index];
                        }
                        print(valueChoice);
                        widget.onTap(valueChoice);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
