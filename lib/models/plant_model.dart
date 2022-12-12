import 'package:intl/intl.dart';

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
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String relaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
