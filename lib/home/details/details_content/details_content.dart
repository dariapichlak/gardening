import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/details/cubit/details_cubit.dart';

import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsContent extends StatelessWidget {
  const DetailsContent({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
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
                Icons.more_horiz,
                color: Colors.grey,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            DetailsCubit(PlantsRepository())..getPlantWithID(id),
        child:
            BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
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
            return const Center(child: Text('Empty'));
          }
          return Center(
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
                          Container(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
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
          );
        }),
      ),
    );
  }
}




//           Padding(
//             padding: const EdgeInsets.only(
//               left: 20.0,
//               bottom: 20,
//               top: 20,
//             ),
//             child: ListView(
//               children: [
//                 Container(
//                   height: 125,
//                   padding: const EdgeInsets.only(
//                     left: 12,
//                     bottom: 12,
//                     top: 12,
//                   ),
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 5,
//                     vertical: 10,
//                   ),
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(70),
//                       bottomLeft: Radius.circular(70),
//                     ),
//                     color: Color.fromARGB(255, 223, 224, 216),
//                     boxShadow: [
//                       BoxShadow(
//                           color: Color.fromARGB(255, 203, 203, 203),
//                           blurRadius: 5,
//                           spreadRadius: 1,
//                           offset: Offset(0, 5)),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CircleAvatar(
//                         backgroundImage: AssetImage('images/plant1.jpg'),
//                         radius: 50,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(plantModel.plantName),
//                           const SizedBox(
//                             height: 12,
//                           ),
//                           Row(
//                             children: [
//                               const Icon(Icons.water_drop_outlined),
//                               const Text(
//                                 '  ',
//                               ),
//                               Text(
//                                 plantModel.daysToWatering(),
//                                 style: const TextStyle(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Text(
//                                 ' days to watering',
//                                 style: TextStyle(
//                                   fontSize: 10,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Text(
//                             plantModel.relaseDateFormatted(),
//                             style: const TextStyle(
//                               fontSize: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Column(
//                         children: const [Text('')],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }


 //   elevation: 5,
        //   shape: const RoundedRectangleBorder(
        //       borderRadius: BorderRadius.only(
        //           bottomLeft: Radius.circular(35),
        //           bottomRight: Radius.circular(35))),
        //   backgroundColor: const Color.fromARGB(255, 86, 133, 94),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //       child: IconButton(
        //         icon: const Icon(Icons.add),
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //             builder: (_) => const AddPlantPage(),
        //             fullscreenDialog: true,
        //           ));
        //         },
        //       ),
        //     ),
        //   ],
        // ),