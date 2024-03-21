// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionary/api/api_budget.dart';
import 'package:gestionary/providers/authprovider.dart';
import 'package:gestionary/screens/save_expense/saveexpense.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({super.key});

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _budget = TextEditingController();

  @override
  void dispose() {
    _budget.dispose();
    super.dispose();
  }

  final BudgetApi _budgetApi = BudgetApi();

  Future<void> postBudgetToServer() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<AuthProvider>(context, listen: false);
      var userId = await provider.userId();

      var data = {
        "userId": userId,
        "budget_amount": _budget.text,
        "budget_date": ""
      };

      try {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        final res = await _budgetApi.postBudget(data);
        final body = jsonDecode(res.body);
        if (res.statusCode == 200) {
          _budgetApi.showSnackBarSuccessPersonalized(context, body["message"]);

          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SaveExpenses()));
        } else {
          _budgetApi.showSnackBarSuccessPersonalized(context, body["message"]);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const AddBudget()));
        }
      } catch (e) {
        Exception(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: Colors.grey[200],
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(41, 224, 224, 224)),
                child: const Icon(Icons.arrow_back_ios_new_outlined,
                    size: 24, color: Color.fromARGB(255, 202, 202, 202)))),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _text(context),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextFormField(
                      controller: _budget,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez entrer un montant';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Montant",
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          prefixIcon: const Icon(Icons.monetization_on_outlined,
                              size: 30)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                          onPressed: postBudgetToServer,
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(320, 50),
                              backgroundColor: const Color(0xFF292D4E)),
                          icon: const Icon(Icons.save_rounded,
                              size: 24, color: Colors.white),
                          label: Text("Ajouter",
                              style: GoogleFonts.roboto(
                                  fontSize: 20, color: Colors.white))))
                ],
              )),
        ),
      ),
    );
  }

  Widget _text(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Budget du mois",
                style: GoogleFonts.roboto(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "Ajouter le budget du mois pour pouvoir enregistrer vos depenses du mois en cours",
                style: GoogleFonts.aBeeZee(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w300)),
          )
        ],
      ),
    );
  }
}
