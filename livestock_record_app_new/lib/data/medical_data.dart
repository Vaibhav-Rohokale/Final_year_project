class MedicalData {
  static List<Map<String, dynamic>> records = [];

  static void addRecord({
    required String animalName,
    required String disease,
    required String treatment,
    required String vaccination,
    required String healthStatus,
  }) {
    records.add({
      'animalName': animalName,
      'disease': disease,
      'treatment': treatment,
      'vaccination': vaccination,
      'healthStatus': healthStatus,
      'date': DateTime.now().toString(),
    });
  }
}
