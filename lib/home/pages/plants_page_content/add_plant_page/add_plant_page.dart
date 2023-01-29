import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  String? _imageUrl;
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
                      onPressed: _plantName == null ||
                              _releaseDate == null ||
                              _imageUrl == null
                          ? null
                          : () {
                              context.read<AddPlantPageCubit>().add(
                                    _plantName!,
                                    _releaseDate!,
                                    _imageUrl!,
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
                onImageUrlChanged: (newValue) {
                  setState(() {
                    _imageUrl = newValue;
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
    required this.onImageUrlChanged,
    Key? key,
  }) : super(key: key);
  final Function(String) onTitleChanged;
  final Function(DateTime?) onDateChanged;
  final String? selectedDateFormatted;
  final Function(String) onImageUrlChanged;

  @override
  State<_AddPlantPageBody> createState() => _AddPlantPageBodyState();
}

class _AddPlantPageBodyState extends State<_AddPlantPageBody> {
  File? file;
  String imageUrl = '';

  // CollectionReference reference =
  //     FirebaseFirestore.instance.collection('plants');

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
                        widget.onDateChanged(selectedDate);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.water_drop_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            widget.selectedDateFormatted ?? 'When watering?',
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
                                color: Colors.green),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(children: [
                              InkWell(
                                onTap: () async {
                                  widget.onImageUrlChanged;
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.gallery);
                                  // print('${file?.path}');
                                  if (file == null) return;

                                  final imageTemp = File(file.path);

                                  setState(() {
                                    this.file = imageTemp;
                                  });

                                  String fileName = DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString();

                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child('images');
                                  Reference referenceImageToUpload =
                                      referenceDirImages.child(fileName);
                                  try {
                                    await referenceImageToUpload
                                        .putFile(File(file.path));

                                    imageUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                  } catch (error) {
                                    throw ('Error: $error');
                                  }
                                },
                                splashColor: Colors.green,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.camera,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 10),
                                    Text('Gallery'),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              InkWell(
                                onTap: () async {
                                  widget.onImageUrlChanged;
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  // print('${file?.path}');
                                  if (file == null) return;

                                  final imageTemp = File(file.path);

                                  setState(() {
                                    this.file = imageTemp;
                                  });

                                  String fileName = DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString();

                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child('images');
                                  Reference referenceImageToUpload =
                                      referenceDirImages.child(fileName);
                                  try {
                                    await referenceImageToUpload
                                        .putFile(File(file.path));

                                    imageUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                  } catch (error) {
                                    throw ('Error: $error');
                                  }
                                },
                                splashColor: Colors.green,
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.image,
                                      color: Colors.green,
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
