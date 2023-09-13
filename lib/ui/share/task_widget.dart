import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/app_theme.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({
    super.key,
    required this.taskName,
    required this.done,
    required this.fn,
    required this.deletefn
  });
  String taskName;
  int done;
  Function() fn;
  Function(BuildContext)? deletefn;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deletefn,
            backgroundColor:AppTheme.appred ,
            icon: Icons.delete_forever,
            borderRadius: BorderRadius.circular(12.r),
          )
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12.r)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: fn,
                  child: done==1
                      ?  Icon(
                    Icons.check_circle,
                    size: 30,
                    color:Theme.of(context).colorScheme.onPrimary ,
                  )
                      :  Icon(
                    Icons.circle_outlined,
                    size: 30,
                    weight: 100,
                  ),
                )
            ),
            Expanded(
              flex: 4,
              child: Text(taskName,
                  style:TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: done==1 ? Theme.of(context).colorScheme.onPrimary:Theme.of(context).colorScheme.primary
                  ),),
            ),
          ],
        ),
      ),
    );
  }
}