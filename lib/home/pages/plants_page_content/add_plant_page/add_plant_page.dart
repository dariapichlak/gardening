import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/plants_page_content/add_plant_page/cubit/add_plant_page_cubit.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
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
  String? _imageURL;
  String? _temp;
  String? _sun;
  String? _water;

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
                      onPressed: _plantName == null ||
                              _temp == null ||
                              _sun == null ||
                              _water == null ||
                              _releaseDate == null ||
                              _imageURL == null
                          ? null
                          : () async {
                              context.read<AddPlantPageCubit>().add(
                                    _plantName!,
                                    _temp!,
                                    _sun!,
                                    _water!,
                                    _releaseDate!,
                                    _imageURL!,
                                  );
                            },
                    ),
                  ),
                ],
              ),
              body: _AddPlantPageBody(
                onImageURLChanged: (newValue) {
                  setState(() {
                    _imageURL = newValue;
                  });
                },
                onTitleChanged: (newValue) {
                  setState(() {
                    _plantName = newValue;
                  });
                },
                onTempChanged: (newValue) {
                  setState(() {
                    _temp = newValue;
                  });
                },
                onSunChanged: (newValue) {
                  setState(() {
                    _sun = newValue;
                  });
                },
                onWaterChanged: (newValue) {
                  setState(() {
                    _water = newValue;
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

class _AddPlantPageBody extends StatefulWidget {
  const _AddPlantPageBody({
    required this.onTitleChanged,
    required this.onDateChanged,
    required this.selectedDateFormatted,
    required this.onImageURLChanged,
    required this.onTempChanged,
    required this.onSunChanged,
    required this.onWaterChanged,
    Key? key,
  }) : super(key: key);
  final Function(String) onTitleChanged;
  final Function(String) onTempChanged;
  final Function(String) onSunChanged;
  final Function(String) onWaterChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final Function(String) onImageURLChanged;

  @override
  State<_AddPlantPageBody> createState() => _AddPlantPageBodyState();
}

class _AddPlantPageBodyState extends State<_AddPlantPageBody> {
  File? file;
  String imageURL = '';

  Future pickImage(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file == null) return;

      final imageTemporary = File(file.path);

      setState(() {
        this.file = imageTemporary;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (error) {
      print(error);
      Navigator.of(context).pop();
    }

    String uniqueNameFile = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectionImage = referenceRoot.child('imageURL');
    Reference referenceImageToUpload =
        referenceDirectionImage.child(uniqueNameFile);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageURL = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      print(error);
    }
  }

  Future pickImageC(ImageSource source) async {
    try {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file == null) return;

      final imageTemporary = File(file.path);

      setState(() {
        this.file = imageTemporary;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (error) {
      print(error);
      Navigator.of(context).pop();
    }

    String uniqueNameFile = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectionImage = referenceRoot.child('imageURL');
    Reference referenceImageToUpload =
        referenceDirectionImage.child(uniqueNameFile);

    try {
      await referenceImageToUpload.putFile(File(file!.path));
      imageURL = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      print(error);
    }
  }

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
                      onChanged: widget.onTitleChanged,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.green,
                        ),
                        hintText: 'plant name',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: widget.onTempChanged,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.thermostat,
                          color: Colors.green,
                        ),
                        hintText: '10-25 ℃',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: widget.onSunChanged,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.wb_sunny_outlined,
                          color: Colors.green,
                        ),
                        hintText: 'in the shade',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      onChanged: widget.onWaterChanged,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.water_drop_outlined,
                          color: Colors.green,
                        ),
                        hintText: '2 / week',
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 10),
                          ),
                          builder: (context, child) => Theme(
                            data: ThemeData().copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: Color.fromARGB(255, 113, 169, 122),
                                  onPrimary: Colors.white,
                                  surface: Color.fromARGB(255, 113, 169, 122),
                                ),
                                dialogBackgroundColor: Colors.black),
                            child: child!,
                          ),
                        );
                        widget.onDateChanged(selectedDate);
                      },
                      child: Container(
                        height: 50,
                        width: 330,
                        decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0.1,
                                  blurRadius: 7,
                                  offset: Offset(0, 3.5),
                                  color: Colors.grey),
                            ],
                            color: Color.fromARGB(255, 113, 169, 122),
                            borderRadius:
                                BorderRadius.all(Radius.circular(90))),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'When next watering?',
                                style: GoogleFonts.antic(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
              child: file != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.file(
                        file!,
                        width: 260,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const CircleAvatar(
                      radius: 130.0,
                      backgroundImage: AssetImage('images/imagetemp.jpg')),
            ),
          ),
          Positioned(
              top: 220,
              right: 8,
              child: RawMaterialButton(
                elevation: 10,
                fillColor: const Color.fromARGB(255, 113, 169, 122),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Choose option',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Color.fromARGB(255, 113, 169, 122),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(children: [
                              InkWell(
                                onTap: () {
                                  pickImage(ImageSource.gallery);
                                },
                                splashColor:
                                    const Color.fromARGB(255, 113, 169, 122),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.camera,
                                      color: Color.fromARGB(255, 113, 169, 122),
                                    ),
                                    SizedBox(width: 10),
                                    Text('Gallery'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () {
                                  pickImageC(ImageSource.camera);
                                },
                                splashColor:
                                    const Color.fromARGB(255, 113, 169, 122),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.image,
                                      color: Color.fromARGB(255, 113, 169, 122),
                                    ),
                                    SizedBox(width: 10),
                                    Text('Camera'),
                                  ],
                                ),
                              )
                            ]),
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ))
        ],
      ),
    );
  }
}
