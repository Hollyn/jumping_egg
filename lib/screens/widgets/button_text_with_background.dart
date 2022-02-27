import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/helpers/constant.dart';

class ButtonTextWithBackground extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  const ButtonTextWithBackground({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  _ButtonTextWithBackgroundState createState() =>
      _ButtonTextWithBackgroundState();
}

class _ButtonTextWithBackgroundState extends State<ButtonTextWithBackground> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: AssetImage("assets/images/buttons/default_button.png"),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 9),
            child: Text(
              widget.title,
              style: kGameSubTitleStyle,
            ),
          ),
        ),
      ),
      onTap: widget.onPressed,
    );
  }
}
