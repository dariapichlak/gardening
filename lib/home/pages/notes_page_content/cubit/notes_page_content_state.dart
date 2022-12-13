part of 'notes_page_content_cubit.dart';

class NotesPageContentState {
  final List<NoteModel> documents;
  final bool isLoading;
  final String errorMessage;
  final bool value;

  const NotesPageContentState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
    required this.value,
  });
}
