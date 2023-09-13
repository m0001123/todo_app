import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerButton extends StatelessWidget {
  const CustomerButton({super.key, required this.text, required this.ontap, required this.color});
  final String text;
  final VoidCallback ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 130.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
        ),
        onPressed: ontap,
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
