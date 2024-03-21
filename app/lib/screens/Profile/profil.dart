import 'package:flutter/material.dart';
import 'package:gestionary/screens/Profile/widgets/profilphoto.dart';
import 'package:gestionary/screens/Profile/widgets/zonereglages.dart';
import 'package:gestionary/screens/Profile/widgets/profilappbar.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey[200],
      appBar: const SettingsAppBar(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            MyProfilPictureInfos(),
            MyReglages()
          ],
        ),
      )
    );
  }
}