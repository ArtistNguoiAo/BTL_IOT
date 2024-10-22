import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/salomon_screen/view/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListInfoView extends StatefulWidget {
  ListInfoView({super.key});

  @override
  State<ListInfoView> createState() => _ListInfoViewState();
}

class _ListInfoViewState extends State<ListInfoView> {
   List<DataResponse> list = FakeData.listFake;
   List<String> listTest = <String>['Điều hoà', 'Qu', 'Three', 'Four'];
   String dropdownValue = '';

  @override
  void initState() {
    dropdownValue = listTest.first;
    super.initState();
  }
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
            child: Row(
              children: [
                Expanded(
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
                      setState(() {
                        list = FakeData.listFake.where((element) => element.id.contains(value) ||
                            element.time.contains(value) ||
                            element.fakeA.contains(value) ||
                            element.fakeB.contains(value) ||
                            element.fakeC.contains(value)
                        ).toList();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
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
                              list[index].id,
                              style: TextStyleUtils.textStyleNunitoS18W600Black,
                            ),
                          ),
                          Text(
                            list[index].time,
                            style: TextStyleUtils.textStyleNunitoS16W400Black,
                          ),
                        ],
                      ),
                      Text(
                        'Nhiệt độ: ${list[index].fakeA}',
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                      Text(
                        'Độ ẩm: ${list[index].fakeB}',
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                      Text(
                        'Ánh sáng: ${list[index].fakeC}',
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
