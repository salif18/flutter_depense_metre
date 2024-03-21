import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SettingsAppBar extends StatelessWidget implements PreferredSizeWidget {

 @override 
 Size get preferredSize => const Size.fromHeight(80);
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color:Color.fromARGB(255, 224, 224, 224)))
      ),
      child: AppBar(
        toolbarHeight: 85,
           title: Text("Profil",
             style:GoogleFonts.aBeeZee(
              fontSize:24,
              fontWeight: FontWeight.w700, 
              color:Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.grey[200],
            elevation: 0,
      ),
    );
  }
}