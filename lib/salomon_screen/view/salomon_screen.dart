import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/salomon_screen/cubit/salomon_cubit.dart';
import 'package:btl_iot/salomon_screen/view/history_view.dart';
import 'package:btl_iot/salomon_screen/view/home_view.dart';
import 'package:btl_iot/salomon_screen/view/list_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SalomonScreen extends StatefulWidget {
  const SalomonScreen({super.key});

  @override
  State<SalomonScreen> createState() => _SalomonScreenState();
}

class _SalomonScreenState extends State<SalomonScreen> {
  final List<Widget> _pages = [
    const HomeView(),
    const ListInfoView(),
    const HistoryView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalomonCubit()..init(0),
      child: BlocConsumer<SalomonCubit, SalomonState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          state as SalomonLoaded;
          return SafeArea(
            child: Scaffold(
              body: _pages[state.currentIndex],
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: state.currentIndex,
                onTap: (i) {
                  context.read<SalomonCubit>().init(i);
                },
                items: [
                  SalomonBottomBarItem(
                    icon: const FaIcon(FontAwesomeIcons.houseChimney),
                    title: const Text("Home"),
                    selectedColor: ColorUtils.primaryColor,
                  ),
                  SalomonBottomBarItem(
                    icon: const FaIcon(FontAwesomeIcons.listUl),
                    title: const Text("List"),
                    selectedColor: ColorUtils.primaryColor,
                  ),
                  SalomonBottomBarItem(
                    icon: const FaIcon(FontAwesomeIcons.clockRotateLeft),
                    title: const Text("History"),
                    selectedColor: ColorUtils.primaryColor,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
