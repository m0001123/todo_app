import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConditionContainer extends StatelessWidget {
  const ConditionContainer({super.key,required this.child, required this.ontap});

  final Widget child;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 130.w,
        height: 60.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(10.r),
            color: Theme.of(context).colorScheme.secondary),
        child: Center(child: child),
      ),
    );
  }
}
