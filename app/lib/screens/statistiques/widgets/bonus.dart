import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BonusDay extends StatelessWidget {
  const BonusDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text("Analyse votre ",
              style: GoogleFonts.roboto(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.black)),
        ),
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(8),
            // height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF292D4E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text("Dépenses ",
                style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
        )
      ]),
    );
  }
}
