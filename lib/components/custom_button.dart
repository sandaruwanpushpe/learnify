import 'package:flutter/material.dart';
import 'package:learnify/components/custom_text.dart';
import 'package:learnify/utils/responsive.dart';

class CustomButton extends StatefulWidget {
  final String buttonName;
  final double fSize;
  final Size size;
  final VoidCallback onTap;

  const CustomButton({
    required this.buttonName,
    required this.fSize,
    required this.size,
    required this.onTap,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isPressed = false;

  void _togglePressed() {
    setState(() {
      isPressed = !isPressed;
    });
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: Responsive.isSmallScreen(context)
              ? widget.size.width / 1
              : widget.size.width / 1,
          height: Responsive.isSmallScreen(context)
              ? widget.size.height / 15
              : widget.size.height / 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            gradient: isPressed
                ? const LinearGradient(colors: [
                    Colors.orange,
                    Colors.amber,
                  ])
                : const LinearGradient(colors: [
                    Colors.teal,
                    Color(0xff228E8E),
                  ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RalewayText(
                text: widget.buttonName,
                color: Colors.white,
                fontSize: widget.fSize,
                fWaight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
