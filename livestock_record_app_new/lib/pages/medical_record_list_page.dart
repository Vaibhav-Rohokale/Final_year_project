import 'package:flutter/material.dart';
import '../data/medical_data.dart';

class MedicalRecordListPage extends StatelessWidget {
  const MedicalRecordListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final records = MedicalData.records;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🩺 Medical Records'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.blue.shade50,
      body: records.isEmpty
          ? const Center(
              child: Text(
                'No medical records yet.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                final record = records[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    title: Text(
                      record['animalName'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "🦠 Disease: ${record['disease']}\n💊 Treatment: ${record['treatment']}\n💉 Vaccination: ${record['vaccination']}\n❤️ Health: ${record['healthStatus']}\n📅 Date: ${record['date'].split(' ')[0]}",
                    ),
                  ),
                );
              },
            ),
    );
  }
}
