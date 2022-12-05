import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/cubit/add_plant_page_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  var plantName = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPlantPageCubit(),
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
              appBar: AppBar(
                elevation: 5,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
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
                      icon: const Icon(Icons.save),
                      onPressed: () {
                        context.read<AddPlantPageCubit>().add(
                              plantName,
                            );
                      },
                    ),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/plantimage.jpg'),
                      radius: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      onChanged: (newValue) {
                        setState(() {
                          plantName = newValue;
                        });
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Plant Name',
                        hintStyle: GoogleFonts.dancingScript(
                            textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 218, 218, 218),
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.water_drop_outlined),
                            Text(
                              'Watering',
                              style: GoogleFonts.roboto(fontSize: 15),
                            ),
                            Text(
                              '27/11/2022',
                              style: GoogleFonts.roboto(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ExpansionTile(
                      title: Text(
                        'Diary',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 86, 133, 94),
                        ),
                      ),
                      children: [
                        ListTile(
                          title: Text(
                            'Day 1 - planting',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
