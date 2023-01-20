import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/cubit/add_plant_page_cubit.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  String? _plantName;
  DateTime? _releaseDate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPlantPageCubit(PlantsRepository()),
      child: BlocListener<AddPlantPageCubit, AddPlantPageState>(
        listener: (context, state) {
          if (state.save) {
            Navigator.of(context).pop();
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<AddPlantPageCubit, AddPlantPageState>(
          builder: (context, state) {
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
                        Icons.save,
                        color: Colors.grey,
                      ),
                      onPressed: _plantName == null || _releaseDate == null
                          ? null
                          : () {
                              context.read<AddPlantPageCubit>().add(
                                    _plantName!,
                                    _releaseDate!,
                                  );
                            },
                    ),
                  ),
                ],
              ),
              body: _AddPlantPageBody(
                onTitleChanged: (newValue) {
                  setState(() {
                    _plantName = newValue;
                  });
                },
                onDateChanged: (newValue) {
                  setState(() {
                    _releaseDate = newValue;
                  });
                },
                selectedDateFormatted: _releaseDate == null
                    ? null
                    : DateFormat.yMMMEd().format(_releaseDate!),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AddPlantPageBody extends StatelessWidget {
  const _AddPlantPageBody({
    required this.onTitleChanged,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    Key? key,
  }) : super(key: key);
  final Function(String) onTitleChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 190,
            child: Container(
              width: 395,
              height: 600,
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
              ], color: Colors.white, borderRadius: BorderRadius.circular(35)),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 40, right: 40),
                child: ListView(
                  children: [
                    TextField(
                      onChanged: onTitleChanged,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Plant Name',
                        hintStyle: GoogleFonts.antic(
                            textStyle: const TextStyle(
                          fontSize: 25,
                        )),
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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 113, 169, 122),
                        ),
                      ),
                      onPressed: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 10),
                          ),
                        );
                        onDateChanged(selectedDate);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            selectedDateFormatted ?? 'When watering?',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                        ],
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
              child: const CircleAvatar(
                radius: 130.0,
                backgroundImage: AssetImage('images/plantimage.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0),
//           child: ElevatedButton(
//             style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all<Color>(
//                 const Color.fromARGB(255, 113, 169, 122),
//               ),
//             ),
//             onPressed: () async {
//               final selectedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime.now(),
//                 firstDate: DateTime.now(),
//                 lastDate: DateTime.now().add(
//                   const Duration(days: 365 * 10),
//                 ),
//               );
//               onDateChanged(selectedDate);
//             },
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Icon(
//                   Icons.water_drop_outlined,
//                   color: Colors.white,
//                 ),
//                 Text(
//                   selectedDateFormatted ?? 'When watering?',
//                   style: const TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 const Icon(
//                   Icons.calendar_month_outlined,
//                   color: Colors.white,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 40.0),
//           child: ExpansionTile(
//             leading: const Icon(Icons.edit),
//             title: Text(
//               'Diary',
//               style: GoogleFonts.roboto(
//                 fontSize: 15,
//                 fontWeight: FontWeight.bold,
//                 color: const Color.fromARGB(255, 86, 133, 94),
//               ),
//             ),
//             children: const [
//               ListTile(
//                 title: TextField(
//                   maxLines: null,
//                   decoration: InputDecoration.collapsed(
//                     hintText: '...',
//                     hintStyle: TextStyle(
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//                 // title: Text(
//                 //   'Day 1 - planting',
//                 //   style: GoogleFonts.roboto(
//                 //     fontSize: 14,
//                 //   ),
//                 // ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
