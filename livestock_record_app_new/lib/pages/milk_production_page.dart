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
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.grey,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: Colors.grey.shade900,
          ),
          child: child!,
        );
      },
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
        backgroundColor: Colors.grey.shade900,
        title: const Text(
          "🥛 Milk Production",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),

      backgroundColor: Colors.black,  // Dark theme background

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            child: Card(
              color: Colors.grey.shade900,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --------------------- Select Animal --------------------
                    const Text(
                      "Select Animal",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey.shade900,
                      value: selectedAnimal,
                      hint: const Text("Choose Animal",
                          style: TextStyle(color: Colors.white70)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade800,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                      items: animals
                          .map((animal) => DropdownMenuItem<String>(
                                value: animal['name'],
                                child: Text(
                                  animal['name'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAnimal = value;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    // --------------------- Select Date ---------------------
                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    InkWell(
                      onTap: _pickDate,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedDate == null
                              ? "📅 Choose Date"
                              : DateFormat('dd MMM yyyy')
                                  .format(selectedDate!),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ----------------------- Milk Input ---------------------
                    const Text(
                      "Milk Produced (Litres)",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextField(
                      controller: litresController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter milk quantity",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey.shade800,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade500, width: 2),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // --------------------- Save Button ----------------------
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _saveRecord,
                        icon: const Icon(Icons.save, color: Colors.white),
                        label: const Text(
                          "Save Record",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade700,
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
      ),
    );
  }
}
