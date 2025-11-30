import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:intl/intl.dart';

import '../data/nutrition_data.dart';
import '../data/animal_data.dart';
import 'home_page.dart';

class AddNutritionPage extends StatefulWidget {
  const AddNutritionPage({super.key});

  @override
  State<AddNutritionPage> createState() => _AddNutritionPageState();
}

class _AddNutritionPageState extends State<AddNutritionPage> {
  String? selectedAnimal;
  String? selectedFeedType;
  final TextEditingController quantityController = TextEditingController();
  String? selectedFeedingTime;
  final TextEditingController waterController = TextEditingController();
  final TextEditingController supplementsController = TextEditingController();
  String? selectedPurpose;
  DateTime selectedDate = DateTime.now();
  final TextEditingController notesController = TextEditingController();

  final List<String> feedTypes = [
    'Green Fodder',
    'Dry Fodder',
    'Silage',
    'Concentrate',
    'Minerals',
    'Supplements'
  ];

  final List<String> feedingTimes = ['Morning', 'Afternoon', 'Evening', 'Night'];
  final List<String> purposes = ['Maintenance', 'Growth', 'Lactation', 'Recovery', 'Pregnancy'];

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(now.year - 3),
      lastDate: DateTime(now.year + 1),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.grey,
              onPrimary: Colors.white,
              surface: Color(0xFF121212),
              onSurface: Colors.white70,
            ),
            dialogBackgroundColor: const Color(0xFF0F0F0F),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _save() {
    if (selectedAnimal == null ||
        selectedFeedType == null ||
        quantityController.text.isEmpty ||
        selectedFeedingTime == null ||
        waterController.text.isEmpty ||
        selectedPurpose == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all required fields'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    final qty = double.tryParse(quantityController.text);
    final water = double.tryParse(waterController.text);

    if (qty == null || qty <= 0 || water == null || water < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid numeric values'), backgroundColor: Colors.redAccent),
      );
      return;
    }

    final record = {
      'animalName': selectedAnimal!,
      'date': selectedDate,
      'feedType': selectedFeedType!,
      'quantityKg': qty,
      'feedingTime': selectedFeedingTime!,
      'waterLitres': water,
      'supplements': supplementsController.text.trim(),
      'purpose': selectedPurpose!,
      'notes': notesController.text.trim(),
    };

    NutritionData.addRecord(record);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Nutrition record saved'), backgroundColor: Colors.green),
    );

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
  }

  @override
  void dispose() {
    quantityController.dispose();
    waterController.dispose();
    supplementsController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animals = AnimalData.animals;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      // -------------------------
      // UPDATED APPBAR WITH WHITE BACK ARROW + WHITE TITLE
      // -------------------------
      appBar: AppBar(
        backgroundColor: const Color(0xFF161616),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),   // WHITE BACK ARROW
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '🧾 Add Nutrition',
          style: TextStyle(color: Colors.white),   // TITLE IN WHITE
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FadeInUp(
          child: Card(
            color: const Color(0xFF121212),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ========= ANIMAL DROPDOWN =========
                  const Text('Select Animal', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedAnimal,
                    hint: const Text('Choose Animal'),
                    dropdownColor: const Color(0xFF1A1A1A),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: animals.map<DropdownMenuItem<String>>((animal) {
                      final name = animal['name'] ?? animal['title'] ?? animal.toString();
                      return DropdownMenuItem(
                        value: name,
                        child: Text(name, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => selectedAnimal = v),
                  ),

                  const SizedBox(height: 12),

                  // ========= DATE SELECTOR =========
                  const Text('Date', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  InkWell(
                    onTap: _pickDate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F0F0F),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade800),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd MMM yyyy').format(selectedDate),
                              style: const TextStyle(color: Colors.white)),
                          const Icon(Icons.calendar_month, color: Colors.white70)
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ========= FEED TYPE + QUANTITY =========
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Feed Type', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            DropdownButtonFormField<String>(
                              value: selectedFeedType,
                              dropdownColor: const Color(0xFF1A1A1A),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF0F0F0F),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: feedTypes
                                  .map((f) => DropdownMenuItem(
                                      value: f,
                                      child: Text(f, style: const TextStyle(color: Colors.white))))
                                  .toList(),
                              onChanged: (v) => setState(() => selectedFeedType = v),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Quantity (kg)', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            TextField(
                              controller: quantityController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'e.g. 3.5',
                                hintStyle: const TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: const Color(0xFF0F0F0F),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ========= FEEDING TIME + WATER =========
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Feeding Time',
                                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            DropdownButtonFormField<String>(
                              value: selectedFeedingTime,
                              dropdownColor: const Color(0xFF1A1A1A),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: const Color(0xFF0F0F0F),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              items: feedingTimes
                                  .map((t) => DropdownMenuItem(
                                      value: t,
                                      child: Text(t, style: const TextStyle(color: Colors.white))))
                                  .toList(),
                              onChanged: (v) => setState(() => selectedFeedingTime = v),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Water (L)', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),

                            TextField(
                              controller: waterController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'e.g. 20',
                                hintStyle: const TextStyle(color: Colors.white38),
                                filled: true,
                                fillColor: const Color(0xFF0F0F0F),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ========= SUPPLEMENTS =========
                  const Text('Supplements (optional)',
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  TextField(
                    controller: supplementsController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'e.g. Mineral mix, Calcium',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ========= PURPOSE =========
                  const Text('Purpose', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedPurpose,
                    dropdownColor: const Color(0xFF1A1A1A),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    items: purposes
                        .map((p) =>
                            DropdownMenuItem(value: p, child: Text(p, style: const TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (v) => setState(() => selectedPurpose = v),
                  ),

                  const SizedBox(height: 12),

                  // ========= NOTES =========
                  const Text('Notes', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),

                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Any special instruction / vet advice',
                      hintStyle: const TextStyle(color: Colors.white38),
                      filled: true,
                      fillColor: const Color(0xFF0F0F0F),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ========= SAVE BUTTON =========
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save, color: Colors.white),
                      label: const Text('Save Nutrition',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E1E1E),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
