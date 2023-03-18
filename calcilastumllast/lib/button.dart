import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final tcolor;
  final String btext;
  final ontap;
  final anscolor;
  final atext;

  MyButton(
      {required this.color,
      required this.btext,
      required this.tcolor,
      this.ontap,
      this.anscolor,
      this.atext});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                btext,
                style: TextStyle(
                  color: tcolor,
                  fontSize: 19,
                  fontFamily: 'IBM',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
