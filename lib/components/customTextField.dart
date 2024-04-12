import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({required this.cont, required this.hint, required this.validator,required this.hasSuffix});
  final cont;
  final hint;
  final validator;
  final hasSuffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.cont,
      obscureText: widget.hasSuffix?!_isVisible:false,
      decoration: widget.hasSuffix? InputDecoration(
        fillColor: Color(0xFFF7F8F9),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hint,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFFDADADA),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        hintStyle: GoogleFonts.urbanist(
          textStyle: TextStyle(
            color: Color(0xFF8391A1),
            fontSize: 15,
          ),
        ),
        suffixIcon: GestureDetector(
          onTap: (){
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          child: _isVisible?Icon(Icons.visibility):Icon(Icons.visibility_off),
        )
      ):InputDecoration(
        fillColor: Color(0xFFF7F8F9),
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hint,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red)
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color(0xFFDADADA),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        hintStyle: GoogleFonts.urbanist(
          textStyle: TextStyle(
            color: Color(0xFF8391A1),
            fontSize: 15,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
