part of 'settings_cubit.dart';

class SettingsState {
  final List<AllModel> allModel;
  final bool isLoading;
  final String errorMessage;

  SettingsState({
    required this.allModel,
    required this.errorMessage,
    required this.isLoading,
  });
}
