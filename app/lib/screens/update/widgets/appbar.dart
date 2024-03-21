import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateAppBar extends StatelessWidget implements PreferredSizeWidget {
 const UpdateAppBar({super.key});
@override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
       title: Text("Modification de compte",
       style:GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500,) ,),
    );
  }
}