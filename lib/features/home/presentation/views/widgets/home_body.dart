import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/utils/assets.dart';
import 'package:auvnet/core/utils/size_config.dart';
import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:auvnet/features/home/presentation/views/widgets/restaurant_card.dart';
import 'package:auvnet/features/home/presentation/views/widgets/service_card.dart';
import 'package:auvnet/features/home/presentation/views/widgets/shourtcut_card.dart';
import 'package:auvnet/features/products/data/models/product_model.dart';
import 'package:auvnet/features/restaurants/models/restaurant_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:auvnet/core/hive/hive_helper.dart';
import 'dart:convert';

class HomeBody extends StatefulWidget {
  final UserModel user;

  const HomeBody({super.key, required this.user});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final PageController _pageController = PageController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await HiveHelper.initHive();
    final user = FirebaseAuth.instance.currentUser;
    if (user?.photoURL != null && widget.user.profileImg == null) {
      await widget.user.updateProfileImage(
        null,
      );
      await HiveHelper.saveProfileImage(user!.photoURL);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userName = widget.user.name;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.defaultSize! * 15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF8900FE), Color(0xFFFFDE59)],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.all(18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivering to",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                        Text(
                          "Al Satwa, 81A Street",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Hi, $userName !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        widget.user.profileImg != null
                            ? MemoryImage(base64Decode(widget.user.profileImg!))
                            : null,
                    child:
                        widget.user.profileImg == null
                            ? Icon(Icons.person, size: 40, color: Colors.grey)
                            : null,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Services',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ServiceCard(
                  image: AssetsData.food,
                  title: "Food",
                  offer: "Up to 50%",
                ),
                ServiceCard(
                  image: AssetsData.health,
                  title: "Health &\nwellness",
                  offer: "20mins",
                ),
                ServiceCard(
                  image: AssetsData.groceries,
                  title: "Groceries",
                  offer: "15 mins",
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/super_saver.png",
                      width: 48,
                      height: 48,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Get a code !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Add your code and save on your\norder",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Shortcuts',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShortcutCard(
                  imageAsset: 'assets/images/past_orders.png',
                  title: 'Past\norders',
                ),
                ShortcutCard(
                  imageAsset: 'assets/images/super_saver.png',
                  title: 'Super\nSaver',
                ),
                ShortcutCard(
                  imageAsset: 'assets/images/must_tries.png',
                  title: 'Must-tries',
                ),
                ShortcutCard(
                  imageAsset: 'assets/images/give_back.png',
                  title: 'Give Back',
                ),
                ShortcutCard(
                  imageAsset: 'assets/images/best_sellers.png',
                  title: 'Best\nSellers',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  height: 200,
                  color: Colors.pink[50],
                  child: Column(
                    children: [
                      Expanded(
                        child: FutureBuilder<List<ProductModel>>(
                          future: _firestore
                              .collection('products')
                              .get()
                              .then(
                                (snapshot) =>
                                    snapshot.docs
                                        .map(
                                          (doc) => ProductModel.fromMap(
                                            doc.data(),
                                            doc.id,
                                          ),
                                        )
                                        .toList(),
                              ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Center(
                                child: Text('No products found'),
                              );
                            }

                            final products = snapshot.data!;
                            return PageView.builder(
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (context, index) {
                                final product = products[index];
                                return GestureDetector(
                                  onTap: () {
                                    context.push(
                                      AppRouter.kProductDetails,
                                      extra: product,
                                    );
                                  },
                                  child: Image.network(
                                    product.imageUrl.isNotEmpty
                                        ? product.imageUrl
                                        : 'https://via.placeholder.com/300',
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: 5,
                          effect: WormEffect(
                            dotColor: Colors.grey,
                            activeDotColor: Colors.purple,
                            dotHeight: 8,
                            dotWidth: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Text(
                'Popular restaurants nearby',
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            FutureBuilder<List<RestaurantModel>>(
              future: FirebaseFirestore.instance
                  .collection('restaurants')
                  .get()
                  .then(
                    (snapshot) =>
                        snapshot.docs
                            .map((doc) => RestaurantModel.fromMap(doc.data()))
                            .toList(),
                  ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No restaurants found'));
                }

                final restaurants = snapshot.data!;
                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      final restaurant = restaurants[index];
                      return RestaurantCard(
                        imageUrl: restaurant.imageUrl,
                        name: restaurant.name,
                        time: restaurant.deliveryTime,
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
