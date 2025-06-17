import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShortcutCard extends StatelessWidget {
  final String imageAsset;
  final String title;

  const ShortcutCard({
    super.key,
    required this.imageAsset,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1EF),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Image.asset(
              imageAsset,
              width: 32,
              height: 32,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style:  GoogleFonts.dmSans(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
