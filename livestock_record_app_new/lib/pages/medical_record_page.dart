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
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.list, color: Colors.white),
            tooltip: "View All Records",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MedicalRecordListPage(),
                ),
              );
            },
          ),
        ],
      ),

      // Background Dark Theme
      backgroundColor: Colors.grey.shade900,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            color: Colors.grey.shade800,
            shadowColor: Colors.black,
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
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Animal Dropdown
                  DropdownButtonFormField<String>(
                    dropdownColor: Colors.grey.shade800,
                    value: selectedAnimal,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade700,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hint: const Text("Choose Animal", style: TextStyle(color: Colors.white70)),
                    items: AnimalData.animals
                        .map(
                          (animal) => DropdownMenuItem<String>(
                            value: animal['name'],
                            child: Text(animal['name'], style: const TextStyle(color: Colors.white)),
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

                  // Save Button
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _saveRecord,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text(
                        "Save Record",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
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

  // Save Function
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

  // Dark Theme Input Field
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 2,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey.shade700,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
