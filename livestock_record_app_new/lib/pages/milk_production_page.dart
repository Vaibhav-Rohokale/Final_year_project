import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/animal_data.dart';
import '../data/milk_data.dart';
import 'home_page.dart';

class MilkProductionPage extends StatefulWidget {
  const MilkProductionPage({super.key});

  @override
  State<MilkProductionPage> createState() => _MilkProductionPageState();
}

class _MilkProductionPageState extends State<MilkProductionPage> {
  String? selectedAnimal;
  DateTime? selectedDate;
  final TextEditingController litresController = TextEditingController();

  void _saveRecord() {
    if (selectedAnimal == null ||
        selectedDate == null ||
        litresController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Please fill all fields before saving."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final litres = double.tryParse(litresController.text);
    if (litres == null || litres <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("⚠️ Please enter a valid milk quantity."),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // ✅ Save the milk record globally
    MilkData.records.add({
      'animalName': selectedAnimal!,
      'date': selectedDate!,
      'litres': litres,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("✅ Milk record added successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    // ✅ Go back to home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animals = AnimalData.animals;

    return Scaffold(
      appBar: AppBar(
        title: const Text("🥛 Milk Production & Quality"),
        backgroundColor: Colors.deepPurple,
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
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: selectedAnimal,
                    hint: const Text("Choose Animal"),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: animals
                        .map((animal) => DropdownMenuItem<String>(
                              value: animal['name'],
                              child: Text(animal['name']),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedAnimal = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Select Date",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: _pickDate,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.deepPurple, width: 1.2),
                      ),
                      child: Text(
                        selectedDate == null
                            ? "📅 Choose Date"
                            : DateFormat('dd MMM yyyy').format(selectedDate!),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "Milk Produced (in Litres)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: litresController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      hintText: "Enter milk quantity",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.deepPurple, width: 2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
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
}
