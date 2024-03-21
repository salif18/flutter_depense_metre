import 'package:flutter/material.dart';
import 'package:gestionary/models/raportcurrentbudget.dart';
import 'package:gestionary/models/mostexpenses.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnalyseGeneral extends StatelessWidget {
  const AnalyseGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 275,
            width: 180,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF292D4E),
            ),
            child: Consumer<StatisticsProvider>(
              builder: (context, provider, child) {
                return StreamBuilder<ModelRapportCurrentBudgets?>(
                  stream: provider.loadTheStatsBudgetStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      ModelRapportCurrentBudgets? item = snapshot.data;
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircularPercentIndicator(
                              animation: true,
                              animationDuration: 270,
                              radius: 55,
                              lineWidth: 12,
                              percent: double.parse(item?.percent ?? '0') / 100,
                              progressColor:double.parse(item?.percent! ?? "0.0") >= 80 ? Colors.red : Colors.blue,
                              backgroundColor:
                                  const Color.fromARGB(64, 64, 83, 255),
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Text(
                                "${item?.percent ?? 0}%",
                                style: GoogleFonts.roboto(
                                  fontSize: 25,
                                  color: double.parse(item?.percent! ?? "0.0") >= 80 ? Colors.red : Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7),
                            child: Text(
                              "De Consommation du budget",
                              style: GoogleFonts.roboto(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "${item?.budgetAmount ?? 0}",
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 255, 5, 5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              Container(
                height: 130.5,
                width: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 224, 41, 28),
                ),
                child: Consumer<StatisticsProvider>(
                  builder: (context, provider, child) {
                    return StreamBuilder<ModelTheMostExpense?>(
                      stream: provider.loadTheMostExpenseStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasData) {
                          ModelTheMostExpense? item = snapshot.data;
                          Map<String, dynamic>? category = item?.category;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 2),
                                child: Text(
                                  "Plus depensés",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221),
                                  ),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 2),
                                    child: regeneredIcon(
                                        category?['name_categories']),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "${category?['name_categories'] ?? ""}",
                                      style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "${item?.totalAmount ?? 0}",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 130.5,
                width: 180,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFF292D4E),
                ),
                child: Consumer<StatisticsProvider>(
                  builder: (context, provider, child) {
                    return StreamBuilder<ModelRapportCurrentBudgets?>(
                      stream: provider.loadTheStatsBudgetStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator.adaptive());
                        } else if (snapshot.hasData) {
                          ModelRapportCurrentBudgets? item = snapshot.data;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 8, bottom: 2),
                                child: Icon(
                                  Icons.token,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 2),
                                child: Text(
                                  "Epargnes",
                                  style: GoogleFonts.roboto(
                                    fontSize: 18,
                                    color: const Color.fromARGB(
                                        255, 221, 221, 221),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "${item?.epargnes ?? 0} Fcfa",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// CREER DES ICONS EN FONCTION DU TYPE DE DEPENSES
Icon regeneredIcon(expense) {
  switch (expense) {
    case "Electricite":
      return const Icon(Icons.electrical_services_outlined,
          color: Colors.white, size: 30);
    case "Eau":
      return const Icon(Icons.water_drop, color: Colors.white, size: 30);
    case "Logement":
      return const Icon(Icons.home, color: Colors.white, size: 30);
    case "Communication":
      return const Icon(Icons.phone_android_outlined,
          color: Colors.white, size: 30);
    case "Forfait":
      return const Icon(Icons.phonelink_ring_rounded,
          color: Colors.white, size: 30);
    case "Abonnement TV":
      return const Icon(Icons.tv, color: Colors.white, size: 30);
    case "Abonnement Wifi":
      return const Icon(Icons.wifi, color: Colors.white, size: 30);
    case "Foods":
      return const Icon(Icons.fastfood_sharp, color: Colors.white, size: 30);
    case "Transports":
      return const Icon(Icons.tram_sharp, color: Colors.white, size: 30);
    case "Shoppings":
      return const Icon(Icons.checkroom_sharp, color: Colors.white, size: 30);
    case "Loteries":
      return const Icon(Icons.sports_esports_rounded,
          color: Colors.white, size: 30);
    case "Medical":
      return const Icon(Icons.medical_services_rounded,
          color: Colors.white, size: 30);
    case "Divertissements":
      return const Icon(Icons.multitrack_audio_sharp,
          color: Colors.white, size: 30);
    case "Garage":
      return const Icon(Icons.build, color: Colors.white, size: 30);
    case "Dettes":
      return const Icon(Icons.soap_rounded, color: Colors.white, size: 30);
    case "Carburants":
      return const Icon(Icons.oil_barrel_rounded,
          color: Colors.white, size: 30);
    default:
      return const Icon(Icons.account_balance_wallet,
          color: Colors.white, size: 30);
  }
}
