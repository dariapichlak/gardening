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
          return Stack(
            children: [
              const BackgroundImage(),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 172, 172, 172),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => const Settings(
                            id: '',
                          ),
                        ));
                      },
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 240, 240, 240),
                ),
                body: Column(
                  children: [
                    Builder(builder: (context) {
                      if (state.status == Status.loading) {
                        return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 86, 133, 94),
                        );
                      }
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Builder(
                            builder: (context) {
                              if (weatherModel != null) {
                                return Column(
                                  children: [
                                    _SearchWeather(),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    _DisplayWeatherWidget(
                                        weatherModel: weatherModel),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  _SearchWeather(),
                                  const SizedBox(
                                    height: 90,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 254, 254, 254),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 25,
                                offset: Offset(0, 10),
                                color: Color.fromARGB(255, 75, 75, 75)),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Container(
                                color: Colors.transparent,
                                height: 400,
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
                                  todayTextStyle: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                  selectionDecoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 1.5,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/weatherimage.jpg'),
          fit: BoxFit.cover,
        ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              weatherModel.city,
              style: GoogleFonts.antic(
                  fontSize: 18, color: Colors.black, letterSpacing: 3),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              '${weatherModel.temperature} °C',
              style: GoogleFonts.antic(fontSize: 50, color: Colors.black),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              weatherModel.condition,
              style: GoogleFonts.dancingScript(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 320,
          height: 50,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 9,
                  spreadRadius: 0.5,
                  offset: Offset(0, 3)),
            ],
          ),
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              hintText: 'Search weather for city...',
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.grey,
                  onPressed: () {
                    context
                        .read<CalendarPageContentCubit>()
                        .getWeatherModel(city: _controller.text);
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
