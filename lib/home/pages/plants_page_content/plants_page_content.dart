import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/details/details_content/details_content.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/add_plant_page.dart';
import 'package:gardening/home/pages/plants_page_content/cubit/plants_page_content_cubit.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantsPageContent extends StatelessWidget {
  const PlantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 172, 172, 172),
            ),
            onPressed: () {},
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0))),
        backgroundColor: const Color.fromARGB(255, 242, 242, 242),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(
                Icons.add,
                color: Color.fromARGB(255, 172, 172, 172),
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
                  Container(
                    width: 340,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromARGB(255, 203, 203, 203),
                            blurRadius: 6,
                            spreadRadius: 0.3,
                            offset: Offset(0, 6)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 242, 242, 242),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                        ),
                      ),
                      child: ListView(
                        children: [
                          const SizedBox(height: 0),
                          for (final plantModel in plantModels) ...[
                            Dismissible(
                              background: const DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 325.0),
                                  child: Icon(Icons.delete),
                                ),
                              ),
                              key: ValueKey(plantModel.id),
                              confirmDismiss: (direction) async {
                                return direction == DismissDirection.endToStart;
                              },
                              onDismissed: (_) {
                                context.read<PlantsPageContentCubit>().remove(
                                      documentID: plantModel.id,
                                    );
                              },
                              child: InkWell(
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
                                    height: 180,
                                    width: 150,
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      bottom: 12,
                                      top: 12,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // Image here
                                              Text(
                                                plantModel.plantName,
                                                style: GoogleFonts.antic(
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    plantModel.daysToWatering(),
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Text(
                                                    ' days to watering',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                plantModel
                                                    .relaseDateFormatted(),
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: const [Text('')],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
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
