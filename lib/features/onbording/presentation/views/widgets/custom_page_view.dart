import 'package:flutter/material.dart';
import 'page_view_item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, required this.pageController});
  final PageController? pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        PageViewItem(
          title: "all-in-one delivery",
          subTitle: "Order groceries, medicines, and meals \ndelivered straight to your door",
        ),
        PageViewItem(
          title: "User-to-User Delivery",
          subTitle: "Send or receive items from other users quickly and \n easily",
        ),
        PageViewItem(
          title: "Sales & Discounts",
          subTitle: "Discover exclusive sales and deals every day",
        ),
      ],
    );
  }
}