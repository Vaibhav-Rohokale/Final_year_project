import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/milk_data.dart';

class MonthlyReportPage extends StatefulWidget {
  const MonthlyReportPage({super.key});

  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  String? selectedMonth;
  List<Map<String, dynamic>> monthlyRecords = [];
  double totalLitres = 0.0;

  void _filterRecords() {
    if (selectedMonth == null) return;

    final selectedMonthInt = DateFormat('MMMM').parse(selectedMonth!).month;

    setState(() {
      monthlyRecords = MilkData.records
          .where((record) =>
              (record['date'] as DateTime).month == selectedMonthInt)
          .toList();

      totalLitres = monthlyRecords.fold(
        0.0,
        (sum, record) => sum + ((record['litres'] as num).toDouble()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final months = List.generate(
      12,
      (index) => DateFormat('MMMM').format(DateTime(0, index + 1)),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        title: const Text(
          '📊 Monthly Milk Report',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 6,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              dropdownColor: const Color(0xFF1E1E1E),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                labelText: "Select Month",
                labelStyle: const TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              value: selectedMonth,
              items: months
                  .map((m) => DropdownMenuItem(
                        value: m,
                        child: Text(m, style: const TextStyle(color: Colors.white)),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedMonth = value;
                _filterRecords();
              },
            ),

            const SizedBox(height: 20),

            // Summary Card
            if (selectedMonth != null)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade900,
                      Colors.grey.shade800,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "📅 Month: $selectedMonth",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "🐮 Records Found: ${monthlyRecords.length}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "🥛 Total Milk: ${totalLitres.toStringAsFixed(2)} L",
                      style: const TextStyle(
                        color: Colors.tealAccent,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Records List
            Expanded(
              child: monthlyRecords.isEmpty
                  ? const Center(
                      child: Text(
                        "No records available for selected month.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: monthlyRecords.length,
                      itemBuilder: (context, index) {
                        final record = monthlyRecords[index];

                        return Card(
                          color: const Color(0xFF1C1C1C),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.local_drink,
                                color: Colors.white70, size: 32),
                            title: Text(
                              record['animalName'] ?? 'Unknown Animal',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Date: ${DateFormat('dd MMM yyyy').format(record['date'])}\n"
                              "Milk: ${record['litres']} L",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
