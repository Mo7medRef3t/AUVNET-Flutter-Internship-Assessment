import 'package:auvnet/core/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({
    super.key,
    required this.text,
    required this.onTap, this.fontSize = 18,
  });

  final String? text;
  final VoidCallback? onTap;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.defaultSize! * 5,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8900FE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
          elevation: 3,
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
