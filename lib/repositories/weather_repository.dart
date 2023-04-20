import 'package:gardening/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:gardening/models/weather_model.dart';

class WeatherRopository {
  WeatherRopository(this._weatherRemoteDataSource);

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    final responseData =
        await _weatherRemoteDataSource.getWeatherData(city: city);
    if (responseData == null) {
      return null;
    }
    final name = responseData['location']['name'] as String;
    final temp = (responseData['current']['temp_c'] + 0.0) as double;
    final condition = responseData['current']['condition']['text'] as String;

    return WeatherModel(
      city: name,
      temperature: temp,
      condition: condition,
    );
  }
}
