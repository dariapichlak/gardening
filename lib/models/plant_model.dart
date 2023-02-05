import 'package:intl/intl.dart';

class PlantModel {
  PlantModel({
    required this.plantName,
    required this.id,
    required this.releaseDate,
    required this.imageURL,
  });

  final String plantName;
  final String id;
  final DateTime releaseDate;
  final String imageURL;

  String daysToWatering() {
    return releaseDate.difference(DateTime.now()).inDays.toString();
  }

  String relaseDateFormatted() {
    return DateFormat.yMMMEd().format(releaseDate);
  }
}
