import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/details/details_content/details_content.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/add_plant_page.dart';
import 'package:gardening/home/pages/plants_page_content/cubit/plants_page_content_cubit.dart';
import 'package:gardening/home/settings/settings.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantsPageContent extends StatelessWidget {
  const PlantsPageContent({
    Key? key,
  }) : super(key: key);

  // ???

  @override
  Widget build(BuildContext context) {
    // Color getColor() {
    //   if (??? < 1) {
    //     return Color.fromARGB(255, 255, 138, 130);
    //   } else {
    //     return Color.fromARGB(255, 103, 159, 105);
    //   }
    // }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        elevation: 0,
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
                      )));
            },
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        backgroundColor: const Color.fromARGB(255, 254, 254, 254),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 86, 133, 94),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => const AddPlantPage(),
                  fullscreenDialog: true,
                ));
              },
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            PlantsPageContentCubit(PlantsRepository())..start(),
        child: BlocBuilder<PlantsPageContentCubit, PlantsPageContentState>(
          builder: (context, state) {
            if (state.errorMessage.isNotEmpty) {
              return const Center(child: Text('Error'));
            }
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 86, 133, 94),
                ),
              );
            }
            if (state.documents.isNotEmpty) {
              final plantModels = state.documents;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My plants',
                          style: GoogleFonts.antic(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 254, 254, 254),
                        ),
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 20,
                          children: [
                            for (final plantModel in plantModels) ...[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => DetailsContent(
                                        id: plantModel.id,
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Container(
                                    height: 190,
                                    width: 160,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromARGB(
                                                255, 203, 203, 203),
                                            blurRadius: 6,
                                            spreadRadius: 0.3,
                                            offset: Offset(0, 6)),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Column(
                                            children: [
                                              Container(
                                                width: 160,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25),
                                                    topRight:
                                                        Radius.circular(25),
                                                  ),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                      plantModel.imageURL,
                                                    ),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      color: Color.fromARGB(
                                                          255, 135, 191, 144),
                                                      // getColor(),
                                                    ),
                                                    width: 32,
                                                    height: 32,
                                                    child: Center(
                                                      child: Text(
                                                        plantModel
                                                            .daysToWatering(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Container(
                                                        width: 100,
                                                        color:
                                                            Colors.transparent,
                                                        child: Center(
                                                          child: Text(
                                                            plantModel
                                                                .plantName,
                                                            style: GoogleFonts
                                                                .antic(
                                                                    fontSize:
                                                                        18),
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Text(
                                                        'days to watering',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              // Text(
                                              //   plantModel
                                              //       .relaseDateFormatted(),
                                              //   style: const TextStyle(
                                              //     fontSize: 10,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text('Add Plants',
                  style: GoogleFonts.dancingScript(
                      fontSize: 35, color: Colors.black)),
            );
          },
        ),
      ),
    );
  }
}
