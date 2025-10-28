class AnimalData {
  static List<Map<String, dynamic>> animals = [];

  static void addAnimal({
    required String name,
    required String breed,
    required String gender,
    required String birth,
    dynamic image,
  }) {
    animals.add({
      'name': name,
      'breed': breed,
      'gender': gender,
      'birth': birth,
      'image': image,
    });
  }
}
