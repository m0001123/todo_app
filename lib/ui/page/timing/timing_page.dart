import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/controller/timing_page_controller.dart';
import 'package:todo_app/ui/page/timing/component/freq_bottom_sheet.dart';
import 'package:todo_app/ui/page/timing/component/time_bottom_sheet.dart';
import 'package:todo_app/ui/page/timing/start_timing_page.dart';

import 'component/condition_container.dart';

class TimingPage extends StatefulWidget {
  const TimingPage({super.key});

  @override
  State<TimingPage> createState() => _TimingPageState();
}

class _TimingPageState extends State<TimingPage> {
  TimingPageController timingPageController = Get.find<TimingPageController>();
  late FixedExtentScrollController focusController;
  late FixedExtentScrollController relaxController;
  late FixedExtentScrollController frequencyController;

  void conditionBottomSheet(BuildContext context,
      FixedExtentScrollController controller, Function(int) done, bool freq) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: freq
              ? FreqBottomSheet(
                  cancelfn: () {
                    Get.back();
                  },
                  donefn: done,
                  controller: controller)
              : TimeBottomSheet(
                  cancelfn: () {
                    Get.back();
                  },
                  donefn: done,
                  controller: controller,
                )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: false,
                maintainSize: false,
                maintainState: true,
                maintainAnimation: false,
                maintainInteractivity: false,
                child: Row(
                  children: [
                    Lottie.asset('assets/work.json',height: 150.h,fit: BoxFit.fill),
                    Lottie.asset('assets/relax.json',height: 150.h,fit: BoxFit.fill),
                    Lottie.asset('assets/image/congratulations.json', height: 150.h,fit: BoxFit.fill),
                  ],
                ),
              ),
              Obx(() {
                return ConditionContainer(
                  child: Text('專注：${timingPageController.focusTime.value} min'),
                  ontap: () {
                    focusController = FixedExtentScrollController(
                        initialItem: timingPageController.focusTime.value - 1);
                    conditionBottomSheet(context, focusController,
                        timingPageController.changeFocusTime, false);
                  },
                );
              }),
              SizedBox(
                height: 50.h,
              ),
              Obx(() {
                return ConditionContainer(
                  child: Text('休息：${timingPageController.relaxTime.value} min'),
                  ontap: () {
                    relaxController = FixedExtentScrollController(
                        initialItem: timingPageController.relaxTime.value - 1);
                    conditionBottomSheet(context, relaxController,
                        timingPageController.changeRelaxTime, false);
                  },
                );
              }),
              SizedBox(
                height: 50.h,
              ),
              Obx(() {
                return ConditionContainer(
                  child: Text('回合：${timingPageController.freq.value} 次'),
                  ontap: () {
                    frequencyController = FixedExtentScrollController(
                        initialItem: timingPageController.freq.value - 1);
                    conditionBottomSheet(context, frequencyController,
                        timingPageController.changeFreq, true);
                  },
                );
              }),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 50.h,
                width: 130.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () async{
                    Get.to(const StartTimingPage());
                  },
                  child: const Text(
                    '開始',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
