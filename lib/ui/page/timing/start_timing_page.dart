import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:todo_app/ui/page/timing/component/customer_button.dart';
import 'package:todo_app/utils/app_theme.dart';
import '../../../controller/start_timing_page_controller.dart';
import 'component/complete_dialog.dart';
import 'package:audioplayers/audioplayers.dart';

class StartTimingPage extends StatefulWidget {
  const StartTimingPage({super.key});

  @override
  State<StartTimingPage> createState() => _StartTimingPageState();
}

class _StartTimingPageState extends State<StartTimingPage> {
  StartTimingPageController startTimingPageController =
      Get.put(StartTimingPageController());

  String secTomin(int sec) {
    int s = sec % 60;
    int m = sec ~/ 60;
    return '$m : ${s < 10 ? '0$s' : s}';
  }

  double getpercent() {
    return (startTimingPageController
                .timelist[startTimingPageController.nowfreq.value - 1] -
            startTimingPageController.spentTime.value) /
        startTimingPageController
            .timelist[startTimingPageController.nowfreq.value - 1];
  }

  void showDoneDialog() {
    Get.dialog(
      CompleteDialog(controller:startTimingPageController.confettiControllerTop),
      barrierDismissible: false,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    startTimingPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ever(startTimingPageController.isDone, (isDone) {
      if (isDone) {
        showDoneDialog();
      }
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: startTimingPageController.relaxTime.value
                        ? Lottie.asset('assets/image/relax.json',
                            key: const ValueKey<int>(0),
                            height: 150.h,
                            fit: BoxFit.fill)
                        : Lottie.asset('assets/image/work.json',
                            key: const ValueKey<int>(1),
                            height: 150.h,
                            fit: BoxFit.fill),
                  )),
              SizedBox(
                height: 10.h,
              ),
              Obx(
                () => CircularPercentIndicator(
                  radius: 150.w,
                  lineWidth: 10.0,
                  circularStrokeCap: CircularStrokeCap.round,
                  percent: getpercent() < 1.0 ? getpercent() : 1.0,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  progressColor: startTimingPageController.relaxTime.value
                      ? AppTheme.appgreen
                      : Theme.of(context).colorScheme.onSecondary,
                  center: Text(
                    secTomin(startTimingPageController.spentTime.value),
                    style: const TextStyle(fontSize:30,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const Spacer(flex: 1,),
              Obx(
                () => startTimingPageController.onStarted.value
                    ? CustomerButton(
                        text: '暫停',
                        ontap: () {
                          startTimingPageController.startTiming();
                        },
                        color: AppTheme.appred,
                      )
                    : CustomerButton(
                        text: '繼續',
                        ontap: () {
                          startTimingPageController.startTiming();
                        },
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
