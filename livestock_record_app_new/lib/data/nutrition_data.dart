class NutritionData {
  // Each record: {
  //   'animalName': String,
  //   'date': DateTime,
  //   'feedType': String,
  //   'quantityKg': double,
  //   'feedingTime': String,
  //   'waterLitres': double,
  //   'supplements': String,
  //   'purpose': String,
  //   'notes': String,
  // }
  static List<Map<String, dynamic>> records = [];

  static void addRecord(Map<String, dynamic> record) {
    records.add(record);
  }
}
