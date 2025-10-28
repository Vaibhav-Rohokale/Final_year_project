import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/milk_data.dart'; // ✅ Make sure this file exists in /lib/data/

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
          .where((record) => (record['date'] as DateTime).month == selectedMonthInt)
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
      appBar: AppBar(
        title: const Text('📊 Monthly Report'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              hint: const Text("Select Month"),
              value: selectedMonth,
              items: months
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: (value) {
                selectedMonth = value;
                _filterRecords();
              },
            ),
            const SizedBox(height: 20),

            // ✅ Summary card
            if (selectedMonth != null)
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📅 Month: $selectedMonth",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "🐮 Records: ${monthlyRecords.length}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "🥛 Total Milk: ${totalLitres.toStringAsFixed(2)} L",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // ✅ Detailed list
            Expanded(
              child: monthlyRecords.isEmpty
                  ? const Center(
                      child: Text(
                        "No records for this month.",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      itemCount: monthlyRecords.length,
                      itemBuilder: (context, index) {
                        final record = monthlyRecords[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 5,
                          ),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.local_drink,
                                color: Colors.deepPurple),
                            title: Text(record['animalName'] ?? 'Unknown Animal'),
                            subtitle: Text(
                              "Date: ${DateFormat('dd MMM yyyy').format(record['date'])}\n"
                              "Litres: ${record['litres']}",
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
