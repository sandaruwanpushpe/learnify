import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RalewayText extends StatefulWidget {
  final String text;
  final double fontSize;
  final FontWeight fWaight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow textOverflow;

  const RalewayText({
    required this.text,
    this.fontSize = 24,
    this.textOverflow = TextOverflow.visible,
    this.color = Colors.black,
    this.fWaight = FontWeight.w500,
    this.textAlign = TextAlign.center,
    super.key,
  });

  @override
  State<RalewayText> createState() => _RalewayTextState();
}

class _RalewayTextState extends State<RalewayText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          textAlign: widget.textAlign,
          style: GoogleFonts.raleway(
            fontSize: widget.fontSize,
            fontWeight: widget.fWaight,
            color: widget.color,
          ),
        ),
      ],
    );
  }
}
