import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';

import 'add_animal_page.dart';
import 'animal_profile_page.dart';
import 'milk_production_page.dart';
import 'medical_record_page.dart';
import 'monthly_report_page.dart';
import '../data/government_schemes.dart';

// Correct imports (DO NOT USE pages/pages/)
import 'add_nutrition_page.dart';
import 'nutrition_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int hoveredIndex = -1;

  final List<Map<String, dynamic>> features = const [
    {'icon': Icons.add_circle, 'title': 'Add Animal'},
    {'icon': Icons.pets, 'title': 'Animal Profile'},
    {'icon': Icons.medical_services, 'title': 'Medical Record'},
    {'icon': Icons.local_drink, 'title': 'Milk Production & Quality'},
    {'icon': Icons.insert_chart, 'title': 'Monthly Report'},
    {'icon': Icons.restaurant_menu, 'title': 'Add Nutrition'},
    {'icon': Icons.food_bank, 'title': 'Nutrition Records'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        title: const Text(
          '🐄 Livestock Manager',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
        shadowColor: Colors.grey,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------------- GRID MENU ----------------
            Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: features.length,
                itemBuilder: (context, index) {
                  final feature = features[index];
                  final isHovered = hoveredIndex == index;

                  return MouseRegion(
                    onEnter: (_) => setState(() => hoveredIndex = index),
                    onExit: (_) => setState(() => hoveredIndex = -1),
                    child: AnimatedScale(
                      scale: isHovered ? 1.08 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: FadeInUp(
                        delay: Duration(milliseconds: 120 * index),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            if (feature['title'] == 'Add Animal') {
                              Navigator.push(context, _createRoute(const AddAnimalPage()));

                            } else if (feature['title'] == 'Animal Profile') {
                              Navigator.push(context, _createRoute(const AnimalProfilePage()));

                            } else if (feature['title'] == 'Medical Record') {
                              Navigator.push(context, _createRoute(const MedicalRecordPage()));

                            } else if (feature['title'] == 'Milk Production & Quality') {
                              Navigator.push(context, _createRoute(const MilkProductionPage()));

                            } else if (feature['title'] == 'Monthly Report') {
                              Navigator.push(context, _createRoute(const MonthlyReportPage()));

                            } else if (feature['title'] == 'Add Nutrition') {
                              Navigator.push(context, _createRoute(const AddNutritionPage()));

                            } else if (feature['title'] == 'Nutrition Records') {
                              Navigator.push(context, _createRoute(const NutritionListPage()));
                            }
                          },

                          // ---------------- MENU CARD ----------------
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade900,
                                  Colors.grey.shade800,
                                  Colors.grey.shade700,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  feature['icon'],
                                  size: 50,
                                  color: Colors.grey.shade200,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  feature['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ---------------- GOVT SCHEMES ----------------
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "🌾 Government Schemes",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GovernmentSchemes.schemes.length,
                itemBuilder: (context, index) {
                  final scheme = GovernmentSchemes.schemes[index];

                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: Card(
                      elevation: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        width: 260,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.grey.shade800,
                              Colors.grey.shade700,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              scheme['title']!,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            Expanded(
                              child: Text(
                                scheme['description']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white70,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextButton(
                              onPressed: () async {
                                final url = Uri.parse(scheme['link']!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.externalApplication);
                                }
                              },
                              child: const Text(
                                "🔗 Learn More",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// Page transition animation
  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
