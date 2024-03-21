// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:gestionary/api/api_depense.dart';
import 'package:gestionary/models/expenses.dart';
import 'package:gestionary/providers/authprovider.dart';
import 'package:gestionary/screens/save_expense/saveexpense.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyMonthDepense extends StatefulWidget {
  const MyMonthDepense({super.key});

  @override
  State<MyMonthDepense> createState() => _MyMonthDepenseState();
}

class _MyMonthDepenseState extends State<MyMonthDepense> {
  ExpenseServicesApi expenseApi = ExpenseServicesApi();
  StreamController<List<ModelExpenses>> dataStream =
      StreamController<List<ModelExpenses>>.broadcast();
  String? month = "";
  int? totalMonth = 0;

//get depense for server data
  Future<void> getExpenseToServerData() async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final userId = await provider.userId();
    try {
      final response = await expenseApi.getExpensesUserByMonth(userId);
      dynamic decodedData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          dataStream.add((decodedData["expenses"] as List)
              .map((json) => ModelExpenses.fromJson(json))
              .toList());
          month = decodedData["month"];
          totalMonth = decodedData["totalMonth"];
        });
      } else {
        expenseApi.showSnackBarErrorPersonalized(
            context, decodedData["message"]);
      }
    } catch (err) {
      expenseApi.showSnackBarErrorPersonalized(
          context, "Erreur de serveur, veuillez réessayer. $err");
    }
  }

  @override
  void initState() {
    super.initState();
    getExpenseToServerData();
  }

  @override
  void dispose() {
    dataStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded,
                              color: Colors.red, size: 30),
                          const SizedBox(width: 10),
                          Text(
                            "$month",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "Total",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "$totalMonth",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.monetization_on_rounded,
                              color: Colors.amber, size: 30),
                        ],
                      )),
                ),
              ],
            ),
            StreamBuilder(
                stream: dataStream.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    List<ModelExpenses> expenseStream = snapshot.data ?? [];
                    if (expenseStream.isEmpty) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              "Salut n'oublier pas d'insérer vos dépenses du jours",
                              style: GoogleFonts.roboto(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => _showAddExpenses(context),
                              child: const Icon(Icons.add, size: 33),
                            )
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                        itemCount: expenseStream.length,
                        itemBuilder: (context, index) {
                          return Column(
                              children: expenseStream.map((expense) {
                            final category = expense.category;
                            return _expenses(context, expense, category);
                          }).toList());
                        },
                      ));
                    }
                  } else {
                    return Container();
                  }
                }),
          ],
        ));
  }

  Widget _expenses(BuildContext context, expense, category) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                regeneredIcon(category?["name_categories"] ?? ""),
                const SizedBox(
                  width: 10,
                ),
                Text(category?["name_categories"] ?? "",
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.w400)),
              ],
            ),
            Row(
              children: [
                Text("${expense.amount}",
                    style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.monetization_on_sharp,
                    size: 30, color: Colors.amber)
              ],
            ),
          ],
        ),
      ),
    );
  }

  //showModalBottomSheet la fenetre modale contenant le formulaire
  void _showAddExpenses(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: const SaveExpenses());
      },
    );
  }
}

// CREER DES ICONS EN FONCTION DU TYPE DE DEPENSES
Icon regeneredIcon(expense) {
  switch (expense) {
    case "Electricite":
      return const Icon(Icons.electrical_services_outlined,
          color: Colors.amber, size: 30);
    case "L'eau":
      return const Icon(Icons.water_drop, color: Colors.blue, size: 30);
    case "Logement":
      return const Icon(Icons.home, color: Colors.green, size: 30);
    case "Abonnement TV":
      return const Icon(Icons.tv,
          color: Color.fromARGB(255, 7, 6, 1), size: 30);
    case "Communication":
      return const Icon(Icons.phone_android_outlined,
          color: Color.fromARGB(255, 46, 37, 34), size: 30);
    case "Abonnement Wifi":
      return const Icon(Icons.wifi,
          color: Color.fromARGB(255, 59, 144, 255), size: 30);
    case "Foods":
      return const Icon(Icons.fastfood_rounded, color: Colors.brown, size: 30);
    case "Forfait":
      return const Icon(Icons.phonelink_ring_rounded,
          color: Color.fromARGB(255, 10, 44, 116), size: 30);
    case "Transports":
      return const Icon(Icons.tram_sharp,
          color: Color.fromARGB(255, 206, 59, 59), size: 30);
    case "Shoppings":
      return const Icon(Icons.checkroom_sharp,
          color: Color.fromARGB(255, 51, 177, 135), size: 30);
    case "Medical":
      return const Icon(Icons.medical_services_outlined,
          color: Color.fromARGB(255, 238, 11, 11), size: 30);
    case "Loteries":
      return const Icon(Icons.sports_esports_rounded,
          color: Color.fromARGB(255, 206, 0, 96), size: 30);
    case "Divertissements":
      return const Icon(Icons.multitrack_audio_sharp,
          color: Color.fromARGB(255, 43, 13, 150), size: 30);
    case "Garage":
      return const Icon(Icons.build, color: Colors.blueAccent, size: 30);
    case "Dettes":
      return const Icon(Icons.soap_rounded,
          color: Color.fromARGB(255, 255, 137, 68), size: 30);
    case "Carburants":
      return const Icon(Icons.oil_barrel_rounded, color: Colors.red, size: 30);
    default:
      return const Icon(Icons.account_balance_wallet,
          color: Colors.grey, size: 30);
  }
}
