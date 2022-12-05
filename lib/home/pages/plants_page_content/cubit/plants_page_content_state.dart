part of 'plants_page_content_cubit.dart';


@immutable
class PlantsPageContentState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final bool isLoading;
  final String errorMessage;

  const PlantsPageContentState({
    required this.documents,
    required this.isLoading,
    required this.errorMessage,
  });
}