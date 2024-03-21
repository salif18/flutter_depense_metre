import 'package:flutter/material.dart';
import 'package:gestionary/screens/settings/widgets/appbar.dart';
import 'package:gestionary/screens/update/updatepassword.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: const SettingsAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    _notificationReglage(context),
                    Container(height: 1, width: 320, color: Colors.grey[200]),
                    _themeReglage(context),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    _changerMotdePass(context),
                    Container(height: 1, width: 320, color: Colors.grey[200]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _notificationReglage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notifications, size: 30),
                  const SizedBox(width: 10),
                  Text("Notification",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20, fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),
          const Expanded(child: Switch(value: true, onChanged: null))
        ],
      ),
    );
  }

  Widget _themeReglage(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.sunny, size: 30),
                  const SizedBox(width: 10),
                  Text("Theme",
                      style: GoogleFonts.aBeeZee(
                          fontSize: 20, fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),
          const Expanded(child: Switch(value: true, onChanged: null))
        ],
      ),
    );
  }

  Widget _changerMotdePass(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      height: 100,
      child: InkWell(
        onTap: () => _showUpdatePassword(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.sync_lock_rounded, size: 30),
                    const SizedBox(width: 10),
                    Text("Changer mot de passe",
                        style: GoogleFonts.aBeeZee(
                            fontSize: 20, fontWeight: FontWeight.w300))
                  ],
                ),
              ],
            ),
            const Expanded(
                child: Icon(Icons.arrow_forward_ios_rounded, size: 24))
          ],
        ),
      ),
    );
  }

  void _showUpdatePassword(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: const UpdatePassword());
        });
  }
}
