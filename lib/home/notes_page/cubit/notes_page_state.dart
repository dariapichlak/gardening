part of 'notes_page_cubit.dart';

@immutable
class NotesPageState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;
  final bool value;

  const NotesPageState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
    required this.value,
  });
}
