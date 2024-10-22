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

class HistoryView extends StatelessWidget {
  HistoryView({super.key});

  String device = '';
  final TextEditingController searchEditingController = TextEditingController();
  final TextEditingController textPageEditingController = TextEditingController();
  final TextEditingController startEditingController = TextEditingController();
  final TextEditingController endEditingController = TextEditingController();
  final ExpansionTileController expansionTileController = ExpansionTileController();

  DateTime? _firstSelectedDate;
  DateTime? _secondSelectedDate;

  Future<void> _selectDateTime(BuildContext context, TextEditingController controller, {DateTime? firstDate, DateTime? lastDate}) async {
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();

    // Chọn ngày với giới hạn firstDate và lastDate
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;

      // Chọn giờ
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );

      if (pickedTime != null) {
        selectedTime = pickedTime;

        // Định dạng ngày và giờ
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        final String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(finalDateTime);

        // Cập nhật TextField tương ứng
        controller.text = formattedDateTime;

        if (controller == startEditingController) {
          // Nếu thời gian thứ 1 lớn hơn thời gian thứ 2, cập nhật thời gian thứ 1 bằng thời gian thứ 2
          if (_secondSelectedDate != null && finalDateTime.isAfter(_secondSelectedDate!)) {
            _firstSelectedDate = _secondSelectedDate!;
            controller.text = DateFormat('dd-MM-yyyy HH:mm:ss').format(_secondSelectedDate!);
          } else {
            _firstSelectedDate = finalDateTime;
          }
        } else {
          // Nếu thời gian thứ 2 nhỏ hơn thời gian thứ 1, cập nhật thời gian thứ 2 bằng thời gian thứ 1
          if (_firstSelectedDate != null && finalDateTime.isBefore(_firstSelectedDate!)) {
            _secondSelectedDate = _firstSelectedDate!;
            controller.text = DateFormat('dd-MM-yyyy HH:mm:ss').format(_firstSelectedDate!);
          } else {
            _secondSelectedDate = finalDateTime;
          }
        }
      }
    }
  }

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
                            hintText: "Search by device name...",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
                          ),
                          onSubmitted: (value) {
                            context.read<HistoryCubit>().search(
                              page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 0,
                              device: searchEditingController.text.trim(),
                              status: device,
                              startTime: startEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(startEditingController.text) : null,
                              endTime: endEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(endEditingController.text) : null,
                            );
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<HistoryCubit>().search(
                          page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 0,
                          device: searchEditingController.text.trim(),
                          status: device,
                          startTime: startEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(startEditingController.text) : null,
                          endTime: endEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(endEditingController.text) : null,
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
              title: ListChoice(
                  list: const ['ON', 'OFF'],
                  value: device,
                  onTap: (value) {
                    device = value;
                  }
              ),
              childrenPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              backgroundColor: ColorUtils.white,
              collapsedBackgroundColor: ColorUtils.white,
              shape: const Border(),
              controller: expansionTileController,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        'Start Time:',
                        style: TextStyleUtils.textStyleNunitoS18W600Black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.datetime,
                          controller: startEditingController,
                          decoration: InputDecoration(
                            hintText: "From...         <01-01-2024 12:00:00>",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
                            suffixIcon: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.calendarDays,
                                color: ColorUtils.primaryColor,
                              ),
                              onPressed: () => _selectDateTime(context, startEditingController, lastDate: _secondSelectedDate)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        'End Time:',
                        style: TextStyleUtils.textStyleNunitoS18W600Black,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorUtils.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          keyboardType: TextInputType.datetime,
                          controller: endEditingController,
                          decoration: InputDecoration(
                            hintText: "To...              <01-01-2024 12:00:00>",
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.primaryColor)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorUtils.grey)),
                            suffixIcon: IconButton(
                              icon: FaIcon(
                                FontAwesomeIcons.calendarDays,
                                color: ColorUtils.primaryColor,
                              ),
                              onPressed: () => _selectDateTime(context, endEditingController, firstDate: _firstSelectedDate)
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                                            _dataTable(e.device == 0 ? 'Điều hòa' : e.device == 1 ? 'Quạt' : 'Đèn'),
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
                            page: textPageEditingController.text.isNotEmpty ? int.parse(textPageEditingController.text) : 1,
                            device: searchEditingController.text.trim(),
                            status: device,
                            startTime: startEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(startEditingController.text) : null,
                            endTime: endEditingController.text != '' ? StringHelper.convertStringToOffsetDateTime(endEditingController.text) : null,
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
