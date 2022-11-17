import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/plants_page_content/cubit/plants_page_content_cubit.dart';
import 'package:gardening/home/plants_page_content/plant_card/plant_card.dart';

class PlantsPageContent extends StatelessWidget {
  const PlantsPageContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.green,
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
                                color: Colors.lightBlue,
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
            return const Center(child: Text('List is Empty'));
          },
        ),
      ),
    );
  }
}
