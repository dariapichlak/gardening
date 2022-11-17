part of 'add_notes_page_cubit.dart';

@immutable
class AddNotesPageContentState {
  final bool save;
  final String errorMessage;

  const AddNotesPageContentState({
    this.save = false,
    this.errorMessage = '',
  });
}
