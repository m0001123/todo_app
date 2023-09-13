import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class CompleteDialog extends StatelessWidget {
  const CompleteDialog({super.key, required this.controller});
  final ConfettiController controller;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            height: 300.h,
            child: Column(
              children: [
                Lottie.asset('assets/image/congratulations.json', height: 150.h),
                Text(
                  'COMPLETE',
                  style: GoogleFonts.abel(
                    textStyle:  const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.until((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(5),
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child:  Icon(
                    Icons.done_rounded,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: controller,
            blastDirection: pi/2,
            colors:  [
              Colors.amber,
              Theme.of(context).colorScheme.onSecondary,
            ],
          ),
        ),
      ],
    );
  }
}
