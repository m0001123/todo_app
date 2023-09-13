import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
class TimeBottomSheet extends StatelessWidget {
  TimeBottomSheet(
      {super.key, required this.cancelfn, required this.donefn, required this.controller});
  final VoidCallback cancelfn;
  final Function(int) donefn;
  FixedExtentScrollController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.h,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: cancelfn,
                      child: Text(
                        '取消',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18),
                      )),
                  GestureDetector(
                      onTap: (){
                        donefn(controller.selectedItem+1);
                        Get.back();
                      },
                      child: Text(
                        '完成',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 70.h,
                        child: ListWheelScrollView.useDelegate(
                          controller:controller ,
                          itemExtent: 50,
                          perspective: 0.005,
                          diameterRatio: 1.2,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                              childCount: 90,
                              builder: (context, index) {
                                return Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 5.h),
                                  child: Center(
                                    child: Text(
                                      index + 1 < 10
                                          ? '0${index + 1}'
                                          : '${index + 1}',
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      const Text(
                        'min',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
