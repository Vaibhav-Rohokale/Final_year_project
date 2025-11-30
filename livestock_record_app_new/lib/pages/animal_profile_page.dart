import 'package:flutter/material.dart';
import '../data/animal_data.dart';
import 'dart:io';

class AnimalProfilePage extends StatelessWidget {
  const AnimalProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final animals = AnimalData.animals;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "🐮 Animal Profiles",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),

      backgroundColor: Colors.grey.shade900,

      body: animals.isEmpty
          ? const Center(
              child: Text(
                'No animals added yet 🐮',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  color: Colors.grey.shade800, // valid shade
                  elevation: 3,
                  shadowColor: Colors.black54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(14),

                    // Profile Image
                    leading: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.grey.shade700,
                      backgroundImage: animal['image'] != null
                          ? FileImage(animal['image'])
                          : null,
                      child: animal['image'] == null
                          ? const Icon(Icons.pets, size: 28, color: Colors.white)
                          : null,
                    ),

                    // Main Details
                    title: Text(
                      animal['name'] ?? 'Unnamed',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        "Breed: ${animal['breed'] ?? '-'}\n"
                        "Gender: ${animal['gender'] ?? '-'}\n"
                        "Birth: ${animal['birth'] ?? '-'}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),
                    ),

                    // optional trailing (e.g., view/edit)
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                      onPressed: () {
                        // TODO: navigate to animal detail page if implemented
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
