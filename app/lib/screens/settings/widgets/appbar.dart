import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SettingsAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 80,
      centerTitle: false,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, size: 25)),
      title: Row(
        children: [
          Text("Reglages",
              style: GoogleFonts.roboto(
                  fontSize: 24, fontWeight: FontWeight.w500)),
          const SizedBox(width: 20),
          const Icon(Icons.settings_outlined, size: 25)
        ],
      ),
    );
  }
}
