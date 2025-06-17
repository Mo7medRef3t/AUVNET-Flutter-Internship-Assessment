import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String image;
  final String title;
  final String offer;

  const ServiceCard({
    super.key,
    required this.image,
    required this.title,
    required this.offer,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 105,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(18),
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
            child: SizedBox(
              height: 50,
              width: 60,
              child: ClipRRect(child: Image.asset(image, fit: BoxFit.contain)),
            ),
          ),
          SizedBox(height: 7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF8900FE),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              offer,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 7),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
