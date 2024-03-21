import 'package:flutter/material.dart';
import 'package:gestionary/models/year_stats.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyYearBalance extends StatefulWidget {
  const MyYearBalance({super.key});

  @override
  State<MyYearBalance> createState() => _MyYearBalanceState();
}

class _MyYearBalanceState extends State<MyYearBalance> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top * 1.8, left: 20),
      child: Container(
        padding: const EdgeInsets.only(
          left:20
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(top: 9.0),
                    child: Consumer<StatisticsProvider>(
                        builder: (context, provider, child) {
                      return StreamBuilder<ModelYearStats?>(
                          stream: provider.loadStatsYearStream(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator.adaptive());
                            } else if (snapshot.hasError) {
                              return Text("errer: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              ModelYearStats? statsYear = snapshot.data;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(Icons.balance_rounded, size:40, color:Color.fromARGB(255, 161, 161, 161)),
                                  const SizedBox(width: 10),
                                  Text(
                                    "Balance de ${statsYear?.year ?? 0}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          const Color.fromARGB(255, 161, 161, 161),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return const Text("");
                            }
                          });
                    })),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Consumer<StatisticsProvider>(
                      builder: (context, provider, child) {
                    return StreamBuilder<ModelYearStats?>(
                        stream: provider.loadStatsYearStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text("err:${snapshot.error}");
                          } else if (snapshot.hasData) {
                            ModelYearStats? statsYear = snapshot.data;
                            return Text(
                                  "${statsYear?.totalExpenses ?? 0} Fcfa",
                                  style: GoogleFonts.roboto(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromARGB(255, 18, 1, 65),
                                  ),
                                );
                          } else {
                            return const Text("0");
                          }
                        });
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}