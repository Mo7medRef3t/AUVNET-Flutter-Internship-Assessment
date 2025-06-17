// ignore_for_file: use_build_context_synchronously

import 'package:auvnet/core/utils/app_router.dart';
import 'package:auvnet/core/widgets/custom_card.dart';
import 'package:auvnet/core/widgets/space_widget.dart';
import 'package:auvnet/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late UserModel _user;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await _user.updateProfileImage(image);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpace(10),
        Row(
          children: [
            const HorizantalSpace(2),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    _user.profileImg != null
                        ? MemoryImage(base64Decode(_user.profileImg!))
                        : null,
                child:
                    _user.profileImg == null
                        ? Icon(Icons.person, size: 40, color: Colors.grey)
                        : null,
              ),
            ),
            const HorizantalSpace(4),
            Column(
              children: [
                Text(
                  _user.name,
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  _user.email,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF8E8E8E),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        const VerticalSpace(2),
        CustomCard(
          icon: const Icon(Icons.favorite_border),
          text: "Favourites",
          onTap: () {},
        ),
        CustomCard(
          icon: const Icon(Icons.account_box_outlined),
          text: "About me",
          onTap: () {},
        ),
        CustomCard(
          icon: const Icon(Icons.vpn_key_outlined),
          text: "Change Password",
          onTap: () {},
        ),
        CustomCard(
          icon: const Icon(Icons.logout),
          text: "Log Out",
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            GoRouter.of(context).pushReplacement(AppRouter.kLogin);
          },
        ),
      ],
    );
  }
}
