import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:auvnet/core/widgets/custom_buttons.dart';
import 'package:auvnet/core/widgets/space_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'custom_page_view.dart';

class OnBordingBody extends StatefulWidget {
  const OnBordingBody({super.key});

  @override
  State<OnBordingBody> createState() => _OnBordingBodyState();
}

class _OnBordingBodyState extends State<OnBordingBody> {
  late PageController pageController;

  int currentPage = 0;

  @override
  void initState() {
    pageController =
        PageController()..addListener(() {
          final newPage = pageController.page?.round() ?? 0;
          if (currentPage != newPage) {
            setState(() {
              currentPage = newPage;
            });
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -25,
            left: -105,
            child: Container(
              width: SizeConfig.defaultSize! * 32,
              height: SizeConfig.defaultSize! * 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF8900FE), Color(0xFFFFDE59)],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const VerticalSpace(7.5),
              Expanded(
                child: CustomPageView(pageController: pageController),
              ),
              const VerticalSpace(1.5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: CustomGeneralButton(
                  text: "Get Started",
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kLogin);
                  },
                ),
              ),
              const VerticalSpace(1),
              TextButton(
                child: Text(
                  "next",
                  style: TextStyle(color: Color(0xFF677294), fontSize: 14),
                ),
                onPressed: () {
                  if (currentPage < 2) {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else {
                    GoRouter.of(context).push(AppRouter.kLogin);
                  }
                },
              ),
              const VerticalSpace(4),
            ],
          ),
        ],
      ),
    );
  }
}
