import 'package:flutter/material.dart';
import '../data/animal_data.dart';
import '../data/medical_data.dart';
import 'medical_record_list_page.dart';

class MedicalRecordPage extends StatefulWidget {
  const MedicalRecordPage({super.key});

  @override
  State<MedicalRecordPage> createState() => _MedicalRecordPageState();
}

class _MedicalRecordPageState extends State<MedicalRecordPage> {
  String? selectedAnimal;
  final TextEditingController diseaseController = TextEditingController();
  final TextEditingController treatmentController = TextEditingController();
  final TextEditingController vaccinationController = TextEditingController();
  final TextEditingController healthStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐮 Medical Record'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            tooltip: "View All Records",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MedicalRecordListPage()),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.blue.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select Animal",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    value: selectedAnimal,
                    hint: const Text("Choose Animal"),
                    items: AnimalData.animals
                        .map(
                          (animal) => DropdownMenuItem<String>(
                            value: animal['name'],
                            child: Text(animal['name']),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAnimal = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTextField("Disease History", diseaseController),
                  const SizedBox(height: 15),
                  _buildTextField("Treatments Given", treatmentController),
                  const SizedBox(height: 15),
                  _buildTextField("Vaccination Details", vaccinationController),
                  const SizedBox(height: 15),
                  _buildTextField("Health Status", healthStatusController),
                  const SizedBox(height: 25),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _saveRecord,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text(
                        "Save Record",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveRecord() {
    if (selectedAnimal == null ||
        diseaseController.text.isEmpty ||
        treatmentController.text.isEmpty ||
        vaccinationController.text.isEmpty ||
        healthStatusController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Please fill all fields!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    MedicalData.addRecord(
      animalName: selectedAnimal!,
      disease: diseaseController.text,
      treatment: treatmentController.text,
      vaccination: vaccinationController.text,
      healthStatus: healthStatusController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("✅ Record for $selectedAnimal saved!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MedicalRecordListPage()),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
    );
  }
}
