import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/plants_page_content/add_plant_page/add_plant_page.dart';
import 'package:gardening/home/plants_page_content/cubit/plants_page_content_cubit.dart';
import 'package:gardening/home/plants_page_content/plant_card/plant_card.dart';
import 'package:gardening/home/settings_page/settings_page.dart';
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
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddPlantPage()));
              },
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => PlantsPageContentCubit()..start(),
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
              final documents = state.documents;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    for (final document in documents) ...[
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
                        key: ValueKey(document.id),
                        confirmDismiss: (direction) async {
                          return direction == DismissDirection.endToStart;
                        },
                        onDismissed: (_) {
                          context.read<PlantsPageContentCubit>().remove(
                                documentID: document.id,
                              );
                        },
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PlantCard(),
                              ),
                            );
                          },
                          child: Container(
                              width: 350,
                              height: 125,
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 86, 133, 94),
                              ),
                              child: Row(
                                children: const [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/plantimage.jpg'),
                                    radius: 100,
                                  ),
                                  Text('Name Plant'),
                                ],
                              )),
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
