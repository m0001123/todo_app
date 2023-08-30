import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                '添加代辦',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(fontSize: 30,fontWeight: FontWeight.w600)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
