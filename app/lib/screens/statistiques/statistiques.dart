import 'package:flutter/material.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:gestionary/screens/statistiques/graphiques/bar_chart.dart';
import 'package:gestionary/screens/statistiques/graphiques/line_chartwidget.dart';
import 'package:gestionary/screens/statistiques/graphiques/pie_chartwidget.dart';
// import 'package:gestionary/screens/statistiques/graphiques/bar_chart.dart';
// import 'package:gestionary/screens/statistiques/graphiques/line_chartwidget.dart';
// import 'package:gestionary/screens/statistiques/graphiques/pie_chartwidget.dart';
import 'package:gestionary/screens/statistiques/widgets/analyse.dart';
import 'package:gestionary/screens/statistiques/widgets/balanceyear.dart';
import 'package:gestionary/screens/statistiques/widgets/bonus.dart';
import 'package:gestionary/screens/statistiques/widgets/mensuel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyStats extends StatefulWidget {
  const MyStats({super.key});
  @override
  State<MyStats> createState() => _MyStatsState();
}

class _MyStatsState extends State<MyStats> {
//rafraichire la page en actualisant la requette
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    fetchData();
  }

  fetchData() async {
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsYear(context);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsMonth(context);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsTheMost(context);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsCurrentBudget(context);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsAllYear(context);
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsWeek(context);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: SafeArea(
        child: RefreshIndicator(
          backgroundColor: const Color.fromARGB(255, 34, 12, 49),
          color: Colors.grey[100],
          onRefresh: _refresh,
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const MyYearBalance(),
                  Container(height: 1, width: 350, color: Colors.grey[400]),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Mensuelle",
                          style: GoogleFonts.roboto(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const Mensuels(),
                  const BonusDay(),
                  const AnalyseGeneral(),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Hebdomadaire",
                              style: GoogleFonts.roboto(
                                  fontSize: 23, fontWeight: FontWeight.w500)),
                        ],
                      )),
                  const BarChartWidget(),
                  Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Etat du budget",
                              style: GoogleFonts.roboto(
                                  fontSize: 23, fontWeight: FontWeight.w500)),
                        ],
                      )),
                  const PieChartWidget(),
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Statistiques annuel",
                              style: GoogleFonts.roboto(
                                  fontSize: 23, fontWeight: FontWeight.w500)),
                        ],
                      )),
                  const LineChartWidget(),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
