import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestionary/routes/routes.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const MainRoutes())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Center(
            child: AnimatedSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          duration: const Duration(seconds: 5),
          child: Container(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                    key: UniqueKey(),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: const Color(0xFF292D4E),
                              borderRadius: BorderRadius.circular(20)),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "D",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                              TextSpan(
                                  text: "mètre",
                                  style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 0, 182, 214))),
                            ]),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "dépensesmètre.pro",
                              style: GoogleFonts.robotoSerif(fontSize: 16),
                            )),
                      ],
                    )),
                Column(
                  children: [
                    Text(
                      "from",
                      style: GoogleFonts.aBeeZee(fontSize: 16),
                    ),
                    Text(
                      "DevApps Center",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    )
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
