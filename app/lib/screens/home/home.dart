import 'package:flutter/material.dart';
import 'package:gestionary/models/user.dart';
import 'package:gestionary/providers/statisticprovider.dart';
import 'package:gestionary/providers/userprovider.dart';
import 'package:gestionary/screens/budgets/budgets.dart';
import 'package:gestionary/screens/home/widget/carousel.dart';
import 'package:gestionary/screens/home/widget/monthdepense.dart';
import 'package:gestionary/screens/home/widget/todaydepense.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
//rafraichire la page en actualisanst la requete
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsWeek(context);
      });
    });
  }

  Future<void> myFetchdata() async {
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<StatisticsProvider>(context, listen: false)
            .fetchStatisticsWeek(context);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    myFetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        backgroundColor: const Color.fromARGB(255, 34, 12, 49),
        color: Colors.grey[100],
        onRefresh: _refresh,
        displacement: 50,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 188, 175, 202),
          body: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Salut !",
                                  style: GoogleFonts.roboto(fontSize: 24)),
                              Consumer<UserInfosProvider>(
                                  builder: (context, provider, child) {
                                return FutureBuilder<ModelUser?>(
                                    future:
                                        provider.loadProfilFromLocalStorage(),
                                    builder: (context, snapshot) {
                                      final profil = snapshot.data!;
                                      return Text("${profil.name},",
                                          style: GoogleFonts.roboto(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w900,
                                              color: const Color.fromARGB(
                                                  255, 34, 12, 49)));
                                    });
                              })
                            ],
                          ),

                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Budgets()));
                                  },
                                  icon: const Icon(Icons.account_balance_sharp,
                                      size: 30)),
                              Text("budgets",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600))
                            ],
                          ),

                          // const SizedBox(width: 5)
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const MyCarousel(),
                  ],
                ),
              ),
              SliverFillRemaining(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Material(
                            color: const Color(0xFFD5CEDD),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20))),
                            child: TabBar(
                              indicator: BoxDecoration(
                                  color: const Color(0xFF292D4E),
                                  borderRadius: BorderRadius.circular(20)),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor:
                                  const Color.fromARGB(255, 253, 253, 253),
                              unselectedLabelColor:
                                  const Color.fromARGB(255, 48, 33, 58),
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Aujourd'hui",
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Mois",
                                    style: GoogleFonts.aBeeZee(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            MyDepenseDay(),
                            MyMonthDepense(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
