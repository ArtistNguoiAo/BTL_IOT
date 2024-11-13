import 'package:btl_iot/core/helper/string_helper.dart';
import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/text_style_utils.dart';
import 'package:btl_iot/core/widget/base_loading.dart';
import 'package:btl_iot/core/widget/list_choice.dart';
import 'package:btl_iot/salomon_screen/cubit/history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  String device = '';

  final TextEditingController searchEditingController = TextEditingController();

  final TextEditingController textPageEditingController = TextEditingController();

  final ExpansionTileController expansionTileController = ExpansionTileController();

  String typeStatus = '';

  String typeDevice = '';

  String typeSort = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit()..init(page: 1),
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
                      "History Action",
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
                          controller: searchEditingController,
                          decoration: InputDecoration(
                            hintText: "Search...",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
                          ),
                          onSubmitted: (value) {
                            context.read<HistoryCubit>().search(
                              page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 0,
                              typeStatus: typeStatus,
                              typeDevice: typeDevice,
                              typeSort: typeSort,
                              dataSearch: searchEditingController.text.trim(),
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<HistoryCubit>().search(
                          page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 0,
                          typeStatus: typeStatus,
                          typeDevice: typeDevice,
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
                    list: const ['ON', 'OFF'],
                    value: typeStatus,
                    onTap: (value) {
                      setState(() {
                        typeStatus = value;
                      });
                    }
                ),
                const SizedBox(height: 16),
                ListChoice(
                    title: 'Search by:',
                    list: const ['Điều hoà', 'Quạt', 'Đèn', 'Thiết bị 1', 'Thiết bị 2', 'Thiết bị 3'],
                    value: typeDevice,
                    onTap: (value) {
                      setState(() {
                        typeDevice = value;
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
            BlocConsumer<HistoryCubit, HistoryState>(
              listener: (context, state) {
                if(state is HistoryError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: ColorUtils.redAccent,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if(state is HistoryLoading) {
                  return const Expanded(child: BaseLoading());
                }
                if(state is HistoryLoaded) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
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
                                      0: FixedColumnWidth(60),
                                      1: FixedColumnWidth(100),
                                      2: FixedColumnWidth(100),
                                      3: FixedColumnWidth(100),
                                    },
                                    children: [
                                      TableRow(
                                          children: [
                                            _headerTable('ID'),
                                            _headerTable('DEVICE'),
                                            _headerTable('TIME'),
                                            _headerTable('STATUS'),
                                          ]
                                      ),
                                      ...state.listOpsHistory.map((e) {
                                        return TableRow(
                                          children: [
                                            _dataTable(e.id.toString()),
                                            _dataTable(e.device == 0 ? 'Điều hòa' : e.device == 1 ? 'Quạt' : e.device == 2 ? 'Đèn' : e.device == 3 ? 'Thiết bị 1' : e.device == 4 ? 'Thiết bị 2' : 'Thiết bị 3'),
                                            _dataTable(StringHelper.convertTimeToString(e.time)),
                                            _dataTable(e.status ? 'ON' : 'OFF'),
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
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            BlocConsumer<HistoryCubit, HistoryState>(
              listener: (context, state) {
                if(state is HistoryLoaded) {
                  textPageEditingController.text = state.page.toString();
                }
              },
              builder: (context, state) {
                if(state is HistoryLoaded) {
                  return Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          context.read<HistoryCubit>().search(
                            page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 0,
                            typeStatus: typeStatus,
                            typeDevice: typeDevice,
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
        padding: const EdgeInsets.all(8.0),
        color: ColorUtils.primaryColor.withOpacity(0.2),
        child: Text(
          title,
          style: TextStyleUtils.textStyleNunitoS18W600Black,
          textAlign: TextAlign.center,
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
