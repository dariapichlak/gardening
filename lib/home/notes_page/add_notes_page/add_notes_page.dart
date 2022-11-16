import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/notes_page/add_notes_page/cubit/add_notes_page_cubit.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

var titleNote = '';

class _AddNotesPageState extends State<AddNotesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNotesPageCubit(),
      child: BlocListener<AddNotesPageCubit, AddNotesPageState>(
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
        child: BlocBuilder<AddNotesPageCubit, AddNotesPageState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: ListView(
                  children: [
                    TextField(
                      decoration: const InputDecoration(hintText: 'Title'),
                      onChanged: ((newValue) {
                        setState(() {
                          titleNote = newValue;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: () {
                  context.read<AddNotesPageCubit>().add(
                        titleNote,
                      );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
