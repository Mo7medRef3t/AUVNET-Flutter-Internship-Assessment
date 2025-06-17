import 'package:auvnet/core/utils/assets.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:auvnet/core/widgets/space_widget.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const VerticalSpace(1.5),
        Align(
          alignment: Alignment(-0.7,0),
          child: SizedBox(
            width: SizeConfig.defaultSize! * 31,
            height: SizeConfig.defaultSize! * 31,
            child: Image.asset(
              AssetsData.logo,
              fit: BoxFit.contain,
            ),
          ),
        ),
        
        const VerticalSpace(5),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        const VerticalSpace(1.5),
        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF677294),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}