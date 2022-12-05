part of 'notes_page_content_cubit.dart';

@immutable
class NotesPageContentState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
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
