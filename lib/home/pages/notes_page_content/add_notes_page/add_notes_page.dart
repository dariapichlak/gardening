import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/notes_page_content/add_notes_page/cubit/add_notes_page_cubit.dart';

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
      create: (context) => AddNotesPageContentCubit(),
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
              backgroundColor: const Color.fromARGB(255, 254, 254, 254),
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: IconButton(
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
                elevation: 5,
                backgroundColor: const Color.fromARGB(255, 86, 133, 94),
              ),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ListView(
                  children: [
                    TextField(
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