import 'package:bloc/bloc.dart';
import 'package:gardening/core/enum.dart';
import 'package:gardening/models/weather_model.dart';
import 'package:gardening/repositories/weather_repository.dart';

part 'calendar_page_content_state.dart';

class CalendarPageContentCubit extends Cubit<CalendarPageContentState> {
  CalendarPageContentCubit(this._weatherRopository)
      : super(CalendarPageContentState());
  final WeatherRopository _weatherRopository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(CalendarPageContentState(status: Status.loading));
    try {
      final weatherModel = await _weatherRopository.getWeatherModel(
        city: city,
      );
      emit(CalendarPageContentState(
        model: weatherModel,
        status: Status.success,
      ));
    } catch (error) {
      emit(CalendarPageContentState(
        status: Status.error,
        errorMessage: error.toString(),
      ));
    }
  }
}
