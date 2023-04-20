import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/details/cubit/details_cubit.dart';

import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsContent extends StatefulWidget {
  const DetailsContent({
    required this.id,
    Key? key,
  }) : super(key: key);
  final String id;

  @override
  State<DetailsContent> createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsCubit(PlantsRepository())..getPlantWithID(widget.id),
      child: BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
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
        final plantModel = state.plantModel;
        if (plantModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 242, 242, 242),
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0))),
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 242, 242, 242),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    context
                        .read<DetailsCubit>()
                        .remove(documentID: plantModel.id);

                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 190,
                  child: Container(
                    width: 395,
                    height: 600,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 100.0, left: 40, right: 40),
                      child: ListView(
                        children: [
                          Text(
                            plantModel.plantName,
                            style: GoogleFonts.antic(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Description of a plant',
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 0.1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3.5),
                                        color: Colors.grey),
                                  ],
                                  color: Color.fromARGB(255, 242, 242, 242),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Color.fromARGB(255, 86, 134, 87),
                                    ),
                                    Text(
                                      'Next Watering',
                                    ),
                                    Icon(
                                      Icons.water_drop_outlined,
                                      color: Color.fromARGB(255, 86, 134, 87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ExpansionTile(
                            leading: const Icon(Icons.edit),
                            title: Text(
                              'Diary',
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 86, 133, 94),
                              ),
                            ),
                            children: const [
                              ListTile(
                                title: TextField(
                                  maxLines: null,
                                  decoration: InputDecoration.collapsed(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 7,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 0.1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                            color: Colors.grey),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 130.0,
                      backgroundImage: NetworkImage(plantModel.imageURL),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
