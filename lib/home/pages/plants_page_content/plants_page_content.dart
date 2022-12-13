import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/details/details_content/details_content.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/add_plant_page.dart';
import 'package:gardening/home/pages/plants_page_content/cubit/plants_page_content_cubit.dart';
import 'package:gardening/home/pages/plants_page_content/plant_card/plant_card.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantsPageContent extends StatelessWidget {
  const PlantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 254, 254),
      appBar: AppBar(
        elevation: 5,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {},
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35))),
        backgroundColor: const Color.fromARGB(255, 86, 133, 94),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: const Icon(Icons.add),
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
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  bottom: 20,
                  top: 20,
                ),
                child: ListView(
                  children: [
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
                          child: Container(
                            height: 125,
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
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(70),
                                // topRight: Radius.circular(70),
                                bottomLeft: Radius.circular(70),
                              ),

                              // bottomRight: Radius.circular(70)),
                              color: Color.fromARGB(255, 223, 224, 216),
                              boxShadow: [
                                BoxShadow(
                                    color: Color.fromARGB(255, 203, 203, 203),
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 5)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/plant1.jpg'),
                                  radius: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(plantModel.plantName),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.water_drop_outlined),
                                        const Text(
                                          '  ',
                                        ),
                                        Text(
                                          plantModel.daysToWatering(),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
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
                                      plantModel.relaseDateFormatted(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: const [Text('')],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
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
