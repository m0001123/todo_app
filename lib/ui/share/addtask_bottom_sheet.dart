import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskBottomSheet extends StatelessWidget {
  final VoidCallback addfn;
  final controller;
  const AddTaskBottomSheet({super.key,required this.addfn,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))
      ),
      padding:  EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('添加待辦',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(height: 15.h,),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: '請輸入任務名稱',
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 2)),
            ),

          ),
          SizedBox(height: 15.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: addfn,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                ),
                child:  const Icon(Icons.done_rounded,size: 20,color: Colors.white,)
              ),
            ],
          )
        ],
      ),
    );
  }
}
