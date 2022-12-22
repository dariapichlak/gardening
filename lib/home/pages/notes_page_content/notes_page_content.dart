import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardening/home/pages/notes_page_content/add_notes_page/add_notes_page.dart';
import 'package:gardening/home/pages/notes_page_content/cubit/notes_page_content_cubit.dart';
import 'package:gardening/repositories/notes_repository.dart';
import 'package:google_fonts/google_fonts.dart';

class NotesPageContent extends StatefulWidget {
  const NotesPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesPageContent> createState() => _NotesPageContentState();
}

class _NotesPageContentState extends State<NotesPageContent> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: IconButton(
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 172, 172, 172),
            ),
            onPressed: () {},
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
                Icons.notes,
                color: Color.fromARGB(255, 172, 172, 172),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddNotesPage()));
              },
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => NotesPageContentCubit(NotesRepository())..start(),
        child: BlocBuilder<NotesPageContentCubit, NotesPageContentState>(
          builder: (context, state) {
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
            if (state.documents.isNotEmpty) {
              final noteModels = state.documents;
              return Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 2.0, bottom: 20, left: 25),
                          child: Text(
                            'Notes',
                            style: GoogleFonts.antic(fontSize: 30),
                          ),
                        ),
                      ],
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
                            const SizedBox(height: 40),
                            for (final noteModel in noteModels) ...[
                              Dismissible(
                                background: const DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 254, 254, 254),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 325.0),
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                                key: ValueKey(noteModel.id),
                                confirmDismiss: (direction) async {
                                  return direction ==
                                      DismissDirection.endToStart;
                                },
                                onDismissed: (_) {
                                  context.read<NotesPageContentCubit>().remove(
                                        documentID: noteModel.id,
                                      );
                                },
                                child: Container(
                                  width: 350,
                                  padding: const EdgeInsets.all(3),
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 254, 254, 254),
                                  ),
                                  child: Builder(builder: (context) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: CheckboxListTile(
                                        activeColor: const Color.fromARGB(
                                            255, 100, 200, 100),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: Text(
                                          noteModel.titleNote,
                                          style: GoogleFonts.roboto(
                                            textStyle:
                                                const TextStyle(fontSize: 15),
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: noteModel.value,
                                        onChanged: (bool? value) {
                                          context
                                              .read<NotesPageContentCubit>()
                                              .checked(
                                                value: value,
                                                documentID: noteModel.id,
                                              );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text('Add Notes',
                  style: GoogleFonts.dancingScript(
                      fontSize: 40, color: Colors.black)),
            );
          },
        ),
      ),
    );
  }
}
