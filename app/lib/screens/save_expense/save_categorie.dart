// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gestionary/api/api_categories.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateCategories extends StatefulWidget {
  const CreateCategories({super.key});

  @override
  State<CreateCategories> createState() => _CreateCategoriesState();
}

class _CreateCategoriesState extends State<CreateCategories> {
  final CategoriesApi _cateApi = CategoriesApi();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameCategorie = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameCategorie.dispose();
  }

  Future<void> sendCategorie() async {
    var data = {"name_categories": nameCategorie.text};
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
            context: context,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            });
        final res = await _cateApi.postCategories(data);
        final dynamic decodedData = jsonDecode(res.body);
        if (res.statusCode == 201) {
          _cateApi.showSnackBarSuccessPersonalized(
              context, decodedData["message"]);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const CreateCategories()));
        } else {
          _cateApi.showSnackBarErrorPersonalized(
              context, decodedData["message"]);
        }
      } catch (e) {
        _cateApi.showSnackBarErrorPersonalized(
            context, "Erreur de serveur . Veuillez reessayer");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Creer vos categories")),
              _categorieForm(context),
              _buttonSend(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _categorieForm(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: TextFormField(
            controller: nameCategorie,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer une categorie';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: const Color.fromARGB(255, 250, 250, 253),
              filled: true,
              hintText: "Nom de la categorie",
              hintStyle: GoogleFonts.roboto(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 38, 38, 85),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.category_outlined,
                color: Color.fromARGB(255, 38, 38, 85),
                size: 23,
              ),
            )));
  }

  Widget _buttonSend(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
            onPressed: sendCategorie,
            child:
                Text("Sauvegarder", style: GoogleFonts.roboto(fontSize: 20))));
  }
}
