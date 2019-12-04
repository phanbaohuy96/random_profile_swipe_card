import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {

  final double height;
  final double width;
  final List<Color> bgColors;
  final String text;
  final TextStyle textStyle;
  final Function onPressed;
  final double borderRadius;

  const SimpleButton({
    Key key, 
    this.height, 
    this.width, 
    this.bgColors = const [Color(0xffb5f959), Color(0xff69ae08)], 
    this.text, 
    this.onPressed, 
    this.textStyle = const TextStyle(
      color: Colors.white, 
      fontSize: 16, 
      fontWeight: FontWeight.bold
    ),
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? height),
          gradient: LinearGradient(
            colors: bgColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Align(
          child: Text(text,
            style: textStyle,
          )
        ),
      ),
      onTap: onPressed,
    );
  }
}