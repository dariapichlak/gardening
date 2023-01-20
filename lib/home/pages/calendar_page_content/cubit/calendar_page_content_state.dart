part of 'calendar_page_content_cubit.dart';

class CalendarPageContentState {
  final WeatherModel? model;
  final Status status;
  final String? errorMessage;

  CalendarPageContentState({
    this.model,
    this.status = Status.initial,
    this.errorMessage,
  });
}
