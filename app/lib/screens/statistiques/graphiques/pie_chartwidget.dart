// ignore_for_file: library_private_types_in_public_api, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gestionary/models/model_chart_data.dart';
import 'package:gestionary/models/raportcurrentbudget.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  _PieChatWidgetState createState() => _PieChatWidgetState();
}

class _PieChatWidgetState extends State<PieChartWidget> {
  bool isPlaying = true;
 List<Color> lineGradiens = [
  Colors.redAccent, Colors.orangeAccent
 ];
  @override
  Widget build(BuildContext context) {
    return Consumer<StatisticsProvider>(
      builder: (context, provider, child) {
        return StreamBuilder<ModelRapportCurrentBudgets?>(
            stream: provider.loadTheStatsBudgetStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                ModelRapportCurrentBudgets? item = snapshot.data;
                // conversion au format modelPiedata
                List<ModelPieData> pieData = [
                  ModelPieData(
                      value: item?.epargnes!.toDouble() ?? 0.0,
                      title: "Epargnes",
                      color: Colors.green),
                  ModelPieData(
                      value: item?.budgetTotal!.toDouble() ?? 0.0,
                      title: "Dépenses",
                      color: lineGradiens.last.withOpacity(0.8)
                      
                      )
                ];
                if(pieData.isEmpty){
                     return Center(
                    child: Text("Aucuns donnees",
                        style: GoogleFonts.roboto(fontSize: 20)));
                }else{
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: const Color(0xFF292D4E),
                          borderRadius: BorderRadius.circular(20)),
                      child: PieChart(
                        swapAnimationDuration: const Duration(
                            milliseconds:
                                800), // Durée de l'animation de basculement
                        swapAnimationCurve:
                            Curves.linear, // Courbe d'animation de basculement
                        PieChartData(
                            sections: pieData
                                .asMap()
                                .entries
                                .map(
                                  (item) => PieChartSectionData(
                                    value: item.value.value.toDouble(),
                                    radius: 40,
                                    showTitle: true,
                                    title: item.value.title,
                                    titlePositionPercentageOffset: 0.4,
                                    titleStyle: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                    color: item.value.color,
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                  ),
                );
                }
              } else {
               return Container();
              }
      });
      },
    );
  }

  
}
