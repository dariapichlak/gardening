import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/core/enum.dart';
import 'package:gardening/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:gardening/home/pages/calendar_page_content/cubit/calendar_page_content_cubit.dart';
import 'package:gardening/home/settings/settings.dart';
import 'package:gardening/models/weather_model.dart';
import 'package:gardening/repositories/weather_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPageContent extends StatefulWidget {
  const CalendarPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarPageContent> createState() => _CalendarPageContentState();
}

class _CalendarPageContentState extends State<CalendarPageContent> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalendarPageContentCubit(
          WeatherRopository(WeatherRemoteDataSource())),
      child: BlocConsumer<CalendarPageContentCubit, CalendarPageContentState>(
        listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unknown error';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final weatherModel = state.model;
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 86, 133, 94),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const Settings()));
                  },
                ),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              elevation: 0,
              backgroundColor: const Color.fromARGB(255, 86, 133, 94),
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                children: [
                  Container(
                    width: 240,
                    height: 240,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 86, 133, 94),
                      borderRadius: BorderRadius.all(Radius.circular(140)),
                    ),
                    child: Builder(builder: (context) {
                      if (state.status == Status.loading) {
                        return const Text('Weather is loading');
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (weatherModel != null)
                            _DisplayWeatherWidget(weatherModel: weatherModel),
                          _SearchWeather(),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SfCalendar(
                          view: CalendarView.month,
                          initialSelectedDate: DateTime.now(),
                          cellBorderColor: Colors.transparent,
                          showNavigationArrow: true,
                          headerHeight: 70,
                          headerStyle: const CalendarHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Antic',
                                letterSpacing: 5,
                                color: Color.fromARGB(255, 86, 133, 94),
                                fontWeight: FontWeight.w400),
                          ),
                          todayHighlightColor:
                              const Color.fromARGB(255, 86, 133, 94),
                          selectionDecoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color.fromARGB(255, 86, 133, 94),
                              width: 1.5,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DisplayWeatherWidget extends StatelessWidget {
  const _DisplayWeatherWidget({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarPageContentCubit, CalendarPageContentState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              weatherModel.city,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '${weatherModel.temperature} °C',
              style: GoogleFonts.roboto(fontSize: 60, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              weatherModel.condition,
              style: GoogleFonts.roboto(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}

class _SearchWeather extends StatelessWidget {
  _SearchWeather({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('City'),
              hintText: 'City',
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              context
                  .read<CalendarPageContentCubit>()
                  .getWeatherModel(city: _controller.text);
            },
            child: const Text('Get'))
      ],
    );
  }
}
