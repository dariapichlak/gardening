class PlantModel {
  PlantModel({
    required this.plantName,
    required this.id,
    required this.releaseDate,
  });

  final String plantName;
  final String id;
  final DateTime releaseDate;

  String daysToWatering() {
    return '7';
  }
}
