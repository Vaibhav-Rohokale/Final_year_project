import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import '../data/nutrition_data.dart';

class NutritionListPage extends StatelessWidget {
  const NutritionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final records = NutritionData.records.reversed.toList(); // newest first

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      // -------------------------
      // UPDATED APPBAR (White Arrow + White Title)
      // -------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),  // WHITE BACK ARROW
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '🥗 Nutrition Records',
          style: TextStyle(color: Colors.white),                    // WHITE TITLE
        ),
      ),

      body: records.isEmpty
          ? const Center(
              child: Text(
                'No nutrition records yet',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: records.length,
              itemBuilder: (context, index) {
                final r = records[index];

                return FadeInUp(
                  delay: Duration(milliseconds: 80 * index),
                  child: Card(
                    color: const Color(0xFF121212),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          // -------------------------
                          // Black–Grey Vertical Bar
                          // -------------------------
                          Container(
                            width: 9,
                            height: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF2E2E2E),
                                  Color(0xFF1A1A1A),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          // -------------------------
                          // MAIN DETAILS COLUMN
                          // -------------------------
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${r['animalName'] ?? 'Unknown'} — ${r['feedType'] ?? ''}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 6),

                                Text(
                                  '${DateFormat('dd MMM yyyy').format(r['date'])} • ${r['feedingTime']}',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                Text(
                                  'Qty: ${r['quantityKg']} kg • Water: ${r['waterLitres']} L',
                                  style: const TextStyle(color: Colors.white70),
                                ),

                                if ((r['supplements'] as String).isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    'Supplements: ${r['supplements']}',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                ],

                                if ((r['notes'] as String).isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    'Notes: ${r['notes']}',
                                    style: const TextStyle(color: Colors.white60),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          const SizedBox(width: 8),

                          // -------------------------
                          // PURPOSE TAG + ACTION BUTTON
                          // -------------------------
                          Column(
                            children: [
                              Chip(
                                label: Text(
                                  r['purpose'] ?? '',
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                                backgroundColor: Colors.grey.shade900,
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                              ),
                              const SizedBox(height: 8),

                              IconButton(
                                onPressed: () {
                                  // future: edit / delete / view details
                                },
                                icon: const Icon(Icons.more_vert, color: Colors.white70),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
