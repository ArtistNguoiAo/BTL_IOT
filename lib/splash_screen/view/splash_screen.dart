import 'package:btl_iot/core/route/app_route.dart';
import 'package:btl_iot/core/utils/media_utils.dart';
import 'package:btl_iot/splash_screen/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit()..init(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            Navigator.pushNamed(context, AppRoutes.home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: Center(
                      child: SvgPicture.asset(
                        MediaUtils.imgLogo,
                        width: 160,
                        height: 160,
                      ).animate().addEffect(
                        SlideEffect(
                          begin: const Offset(0, -1),
                          end: const Offset(0, 0),
                          duration: 1.seconds,
                          curve: Curves.easeInOut,
                        ),
                      ).then().addEffect(
                          const ShakeEffect(
                            duration: Duration(seconds: 1),
                            hz: 4,
                            curve: Curves.easeInOut,
                          )
                      )
                  ),
                ),
                Text(
                    'Developed by Le Quoc Trung',
                ).animate().addEffect(
                    const FadeEffect(
                      duration: Duration(seconds: 2),
                      begin: 0.0,
                      end: 1.0,
                    )
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}