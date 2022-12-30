import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/notes_page_content/add_notes_page/cubit/add_notes_page_cubit.dart';
import 'package:gardening/repositories/notes_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageContentState();
}

var titleNote = '';

class _AddNotesPageContentState extends State<AddNotesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNotesPageContentCubit(NotesRepository()),
      child: BlocListener<AddNotesPageContentCubit, AddNotesPageContentState>(
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
        child: BlocBuilder<AddNotesPageContentCubit, AddNotesPageContentState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 242, 242, 242),
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 172, 172, 172),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                elevation: 0,
                backgroundColor: const Color.fromARGB(255, 242, 242, 242),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: IconButton(
                        color: Colors.grey,
                        onPressed: titleNote.isEmpty
                            ? null
                            : () {
                                context.read<AddNotesPageContentCubit>().add(
                                      titleNote,
                                    );
                              },
                        icon: const Icon(Icons.save)),
                  )
                ],
                title: const Text(''),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35))),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 15, offset: Offset(0, 10)),
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: TextField(
                                maxLines: null,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Notes...',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                onChanged: ((newValue) {
                                  setState(() {
                                    titleNote = newValue;
                                  });
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


//  onPressed: titleNote.isEmpty
//                     ? null
//                     : () {
//                         context.read<AddNotesPageContentCubit>().add(
//                               titleNote,
//                             );
//                       },