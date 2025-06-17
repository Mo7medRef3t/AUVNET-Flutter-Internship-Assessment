import 'package:auvnet/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final bool isPassword;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    this.isPassword = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.defaultSize! * 5,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obscure : false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 13),
          prefixIcon: Icon(widget.icon, color: Colors.grey[500], size: 26),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.mulish(
            color: Colors.grey[500],
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          suffixIcon:
              widget.isPassword
                  ? IconButton(
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[500],
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                  )
                  : null,
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
