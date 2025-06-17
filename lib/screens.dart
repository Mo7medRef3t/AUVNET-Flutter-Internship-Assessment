import 'package:auvnet/core/hive/hive_helper.dart';
import 'package:auvnet/features/home/presentation/views/home_view.dart';
import 'package:auvnet/features/screens/cart_view.dart';
import 'package:auvnet/features/screens/categories_view.dart';
import 'package:auvnet/features/screens/delivery_view.dart';
import 'package:auvnet/features/screens/profile_view.dart';
import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Screens extends StatefulWidget {
  const Screens({super.key});

  @override
  State<Screens> createState() => _ScreensState();
}

class _ScreensState extends State<Screens> {
  int _selectedIndex = 0;

  Future<UserModel> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    final cachedImage = HiveHelper.getProfileImage();
      return UserModel(
        id: user!.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        profileImg: cachedImage ?? user.photoURL, 
      );
    
  }

  Widget _getScreen(UserModel user, int index) {
    switch (index) {
      case 0:
        return HomeView(user: user);
      case 1:
        return const CategoriesView();
      case 2:
        return const DeliveryView();
      case 3:
        return const CartView();
      case 4:
        return ProfileView(user: user);
      default:
        return HomeView(user: user,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _loadUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        if (!snapshot.hasData) {
          return Scaffold(body: Center(child: Text('No user data available')));
        }

        final user = snapshot.data!;
        return Scaffold(
          body: _getScreen(user, _selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: const Color(0xFF8900FE),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.apps_rounded),
                label: 'Categories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.delivery_dining_outlined),
                label: 'Deliver',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
