import 'package:btl_iot/core/helper/string_helper.dart';
import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/core/widget/base_loading.dart';
import 'package:btl_iot/core/widget/list_choice.dart';
import 'package:btl_iot/salomon_screen/cubit/list_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ListInfoView extends StatefulWidget {
  ListInfoView({super.key});

  @override
  State<ListInfoView> createState() => _ListInfoViewState();
}

class _ListInfoViewState extends State<ListInfoView> {
  final TextEditingController searchEditingController = TextEditingController();

  final TextEditingController textPageEditingController = TextEditingController();

  final ExpansionTileController expansionTileController = ExpansionTileController();

  String typeSearch = '';

  String typeSort = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListInfoCubit()..init(page: 1),
      child: Scaffold(
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
            Builder(
              builder: (context) {
                return Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 16, left: 16, right: 8, bottom: 16),
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          keyboardType: TextInputType.number,
                          controller: searchEditingController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
                          ),
                          onSubmitted: (value) {
                            context.read<ListInfoCubit>().search(
                              page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 1,
                              typeSearch: typeSearch,
                              typeSort: typeSort,
                              dataSearch: searchEditingController.text.trim(),
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<ListInfoCubit>().search(
                          page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 1,
                          typeSearch: typeSearch,
                          typeSort: typeSort,
                          dataSearch: searchEditingController.text.trim(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: ColorUtils.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: ColorUtils.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              }
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ExpansionTile(
                      title: Text(
                        'Click here to filter data',
                        style: TextStyleUtils.textStyleNunitoS18W600Black,
                      ),
                      childrenPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      backgroundColor: ColorUtils.white,
                      collapsedBackgroundColor: ColorUtils.white,
                      shape: const Border(),
                      controller: expansionTileController,
                      children: [
                        ListChoice(
                          title: 'Search by:',
                          list: const ['Nhiệt độ', 'Độ ẩm', 'Ánh sáng', 'Thời gian'],
                          value: typeSearch,
                          onTap: (value) {
                            setState(() {
                              typeSearch = value;
                            });
                          }
                        ),
                        const SizedBox(height: 16),
                        ListChoice(
                          title: 'Sort by:',
                          list: const ['Tăng dần', 'Giảm dần'],
                          value: typeSort,
                          onTap: (value) {
                            setState(() {
                              typeSort = value;
                            });
                          }
                        ),
                      ],
                    ),
                    BlocConsumer<ListInfoCubit, ListInfoState>(
                      listener: (context, state) {
                        if(state is ListInfoError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: ColorUtils.redAccent,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if(state is ListInfoLoading) {
                          return const SizedBox(
                            height: 300,
                            child: BaseLoading()
                          );
                        }
                        if(state is ListInfoLoaded) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      color: ColorUtils.white,
                                      child: Table(
                                        border: TableBorder.all(color: Colors.black, width: 1),
                                        columnWidths: const {
                                          0: FixedColumnWidth(80),
                                          1: FixedColumnWidth(130),
                                          2: FixedColumnWidth(130),
                                          3: FixedColumnWidth(130),
                                          4: FixedColumnWidth(130),
                                        },
                                        children: [
                                          TableRow(
                                              children: [
                                                _headerTable('ID'),
                                                _headerTable('TEMPERATURE\n(°C)'),
                                                _headerTable('HUMIDITY\n(%)'),
                                                _headerTable('LIGHT\n(LUX)'),
                                                _headerTable('TIME'),
                                              ]
                                          ),
                                          ...state.listSensorData.map((e) {
                                            return TableRow(
                                              children: [
                                                _dataTable(e.id.toString()),
                                                _dataTable(e.temperature.toString()),
                                                _dataTable(e.humidity.toString()),
                                                _dataTable(e.light.toString()),
                                                _dataTable(StringHelper.convertTimeToString(e.time))
                                              ],
                                            );
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              )
            ),
            const SizedBox(height: 16),
            BlocConsumer<ListInfoCubit, ListInfoState>(
              listener: (context, state) {
                if(state is ListInfoLoaded) {
                  textPageEditingController.text = state.page.toString();
                }
              },
              builder: (context, state) {
                if(state is ListInfoLoaded) {
                  return Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.read<ListInfoCubit>().search(
                            page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 1,
                            typeSearch: typeSearch,
                            typeSort: typeSort,
                            dataSearch: searchEditingController.text.trim(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: ColorUtils.primaryColor,
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                          ),
                          child: Text(
                            'Go',
                            style: TextStyleUtils.textStyleNunitoS16W400White,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                        ),
                        child: TextField(
                          controller: textPageEditingController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: "Page",
                            focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                          ),
                        ),
                      ),
                      Text(
                        ' of ${state.totalPages}',
                        style: TextStyleUtils.textStyleNunitoS16W400Black,
                      ),
                      const SizedBox(width: 16),
                    ],
                  );
                }
                return Container();
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

   Widget _headerTable(String title) {
     return TableCell(
       verticalAlignment: TableCellVerticalAlignment.middle,
       child: Container(
         height: 60,
         padding: const EdgeInsets.all(8.0),
         color: ColorUtils.primaryColor.withOpacity(0.2),
         child: Center(
           child: Text(
             title,
             style: TextStyleUtils.textStyleNunitoS18W600Black,
             textAlign: TextAlign.center,
           ),
         ),
       ),
     );
   }

   Widget _dataTable(String data) {
     return TableCell(
       verticalAlignment: TableCellVerticalAlignment.middle,
       child: Container(
         padding: const EdgeInsets.all(8.0),
         child: Text(
           data,
           style: TextStyleUtils.textStyleNunitoS16W400Black,
           textAlign: TextAlign.center,
         ),
       ),
     );
   }
}
