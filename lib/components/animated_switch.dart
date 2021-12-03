import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mise_news/constants/app_constants.dart';

class AnimatedSwitch extends StatefulWidget {
  final String leftText;
  final String rightText;
  final bool value;
  final Function(bool value) onChanged;

  const AnimatedSwitch({
    Key? key,
    required this.leftText,
    required this.rightText,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _AnimatedSwitchState createState() => _AnimatedSwitchState();
}

const double width = 80.0;
const double height = 30.0;
const double onAlign = -1;
const double offAlign = 1;
const Color selectedColor = Colors.white;
const Color defaultColor = Colors.black54;

class _AnimatedSwitchState extends State<AnimatedSwitch> {
  late double xAlign;
  late Color onColor;
  late Color offColor;
  late bool enabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.value) {
      xAlign = onAlign;
      onColor = selectedColor;
      offColor = defaultColor;
      enabled = true;
    } else {
      xAlign = offAlign;
      offColor = selectedColor;
      onColor = defaultColor;
      enabled = false;
    }
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.grey,
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xAlign, 0),
            duration: const Duration(milliseconds: 200),
            child: Container(
              width: width * 0.5,
              height: height,
              decoration: const BoxDecoration(
                color: blue,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = onAlign;
                onColor = selectedColor;
                offColor = defaultColor;
              });
              widget.onChanged(true);
            },
            child: Align(
              alignment: const Alignment(-1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.leftText,
                  style: TextStyle(
                    color: onColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                xAlign = offAlign;
                offColor = selectedColor;
                onColor = defaultColor;
              });
              widget.onChanged(false);
            },
            child: Align(
              alignment: const Alignment(1, 0),
              child: Container(
                width: width * 0.5,
                color: Colors.transparent,
                alignment: Alignment.center,
                child: Text(
                  widget.rightText,
                  style: TextStyle(
                    color: offColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
