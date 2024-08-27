import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListInfoView extends StatelessWidget {
  const ListInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            width: double.infinity,
            color: ColorUtils.primaryColor,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    "List Data",
                    style: TextStyleUtils.textStyleNunitoS24W700White,
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.circleUser,
                    color: ColorUtils.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.profile);
                  },
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: TextField(
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: ColorUtils.grey,
                ),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
              ),
              onSubmitted: (value) {

              },
              onChanged: (value) {

              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 30,
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "ID00$index",
                              style: TextStyleUtils.textStyleNunitoS18W600Black,
                            ),
                          ),
                          Text(
                            "14/01/2024",
                            style: TextStyleUtils.textStyleNunitoS16W400Black,
                          ),
                        ],
                      ),
                      Text(
                        "Nhiệt độ: 25°C",
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                      Text(
                        "Độ ẩm: 50%",
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                      Text(
                        "Ánh sáng: 1000 lux",
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
