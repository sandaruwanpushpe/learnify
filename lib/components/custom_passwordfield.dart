import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPassword extends StatefulWidget {
  final TextEditingController controller;
  final String errorMsg;
  final bool isPassword;
  final String labelName;
  final IconData pIcon;
  final int maxline;
  final TextInputType type;

  const CustomPassword({
    required this.controller,
    required this.errorMsg,
    this.maxline = 1,
    this.isPassword = false,
    this.type = TextInputType.text,
    required this.labelName,
    required this.pIcon,
    super.key,
  });

  @override
  State<CustomPassword> createState() => _CustomPasswordState();
}

class _CustomPasswordState extends State<CustomPassword> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscure,
        style: GoogleFonts.raleway(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
          label: Text(widget.labelName,
              style: GoogleFonts.raleway(color: Colors.grey)),
          prefixIcon: Icon(
            widget.pIcon,
            color: Colors.grey,
          ),
          suffixIcon: widget.isPassword == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child:
                      Icon(isObscure ? Icons.visibility_off : Icons.visibility))
              : null,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return widget.errorMsg;
          }
          return null;
        },
      ),
    );
  }
}
