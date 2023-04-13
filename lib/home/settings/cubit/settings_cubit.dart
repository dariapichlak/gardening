import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gardening/models/all_model.dart';
import 'package:gardening/repositories/all_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._allRepository)
      : super(SettingsState(
          allModel: [],
          errorMessage: '',
          isLoading: false,
        ));

  final AllRepository _allRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      SettingsState(
        errorMessage: '',
        isLoading: true,
        allModel: [],
      ),
    );

    _streamSubscription = _allRepository.getAllStream().listen((data) {
      emit(
        SettingsState(
          allModel: data,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError(
        (error) {
          emit(
            SettingsState(
              allModel: const [],
              errorMessage: error.toString(),
              isLoading: false,
            ),
          );
        },
      );
  }

  Future<void> remove() async {
    try {
      await _allRepository.deleteAll();
    } catch (error) {
      emit(
        SettingsState(
          errorMessage: error.toString(),
          isLoading: false,
          allModel: const [],
        ),
      );
      start();
    }
  }

  // @override
  // Future<void> close() {
  //   _streamSubscription?.cancel();
  //   return super.close();
  // }
}
