part of 'add_notes_page_cubit.dart';

@immutable
class AddNotesPageState {
  final bool save;
  final String errorMessage;

  const AddNotesPageState({
    this.save = false,
    this.errorMessage = '',
  });
}
