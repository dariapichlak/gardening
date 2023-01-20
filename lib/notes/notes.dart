// Text(
                                              //   plantModel
                                              //       .relaseDateFormatted(),
                                              //   style: const TextStyle(
                                              //     fontSize: 10,
                                              //   ),
                                              // ),



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