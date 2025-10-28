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
        title: const Text('Animal Profiles'),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.blue.shade50,
      body: animals.isEmpty
          ? const Center(
              child: Text(
                'No animals added yet 🐮',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: animals.length,
              itemBuilder: (context, index) {
                final animal = animals[index];
                return Card(
                  margin: const EdgeInsets.all(12),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: animal['image'] != null
                          ? FileImage(animal['image'])
                          : null,
                      child: animal['image'] == null
                          ? const Icon(Icons.pets, size: 30)
                          : null,
                    ),
                    title: Text(
                      animal['name'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "Breed: ${animal['breed']}\nGender: ${animal['gender']}\nBirth: ${animal['birth']}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
