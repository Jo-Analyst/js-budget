import 'package:flutter/material.dart';
import 'package:js_budget/src/summary/widgets/summary_total_widget.dart';
import 'package:js_budget/src/themes/light_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Resumo',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: theme.primaryColor,
              child: TabBar(
                tabAlignment: TabAlignment.center,
                isScrollable: true,
                // indicatorColor: Colors.red,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                controller: _tabController,
                tabs: const <Tab>[
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    text: 'Despesas da oficina',
                    icon: Icon(
                      FontAwesomeIcons.screwdriverWrench,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  Tab(
                    iconMargin: EdgeInsets.zero,
                    text: 'Despesas pessoais',
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              height: MediaQuery.of(context).size.height - 240,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_circle_left_outlined,
                                        size: 30,
                                      ),
                                    ),
                                    // const Text(
                                    //   'Janeiro de 2024',
                                    //   style: lightThemeTitleSmall,
                                    // ),
                                    const Text.rich(
                                      TextSpan(children: [
                                        TextSpan(text: 'Janeiro de '),
                                        TextSpan(
                                          text: '2024',
                                          style: TextStyle(fontFamily: 'Anta'),
                                        ),
                                      ], style: lightThemeTitleSmall),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.arrow_circle_right_outlined,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SummaryTotalWidget(
                        value: 25,
                        textColor: Colors.blue,
                      )
                    ],
                  ),
                  Container(color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
