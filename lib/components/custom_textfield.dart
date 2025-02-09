import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String errorMsg;
  final IconData pIcon;
  final int maxline;
  final TextEditingController controller;
  final TextInputType type;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.pIcon,
    required this.errorMsg,
    required this.controller,
    this.maxline = 1,
    this.type = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        minLines: 1,
        maxLines: maxline,
        keyboardType: type,
        style: GoogleFonts.raleway(
          fontWeight: FontWeight.bold,
        ),
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return errorMsg;
              }
              return null;
            },
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide.none,
          ),
          label: Text(
            labelText,
            style: GoogleFonts.raleway(color: Colors.grey),
          ),
          prefixIcon: Icon(
            color: Colors.grey,
            pIcon,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }
}
