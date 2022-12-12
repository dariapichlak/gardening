import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gardening/models/plant_model.dart';
import 'package:gardening/repositories/plants_repository.dart';
import 'package:meta/meta.dart';

part 'plants_page_content_state.dart';

class PlantsPageContentCubit extends Cubit<PlantsPageContentState> {
  PlantsPageContentCubit(this._plantsRepository)
      : super(const PlantsPageContentState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));

  final PlantsRepository _plantsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const PlantsPageContentState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = _plantsRepository.getPlantsStream().listen((data) {
      emit(
        PlantsPageContentState(
          documents: data,
          errorMessage: '',
          isLoading: false,
        ),
      );
    })
      ..onError(
        (error) {
          emit(
            PlantsPageContentState(
              documents: const [],
              errorMessage: error.toString(),
              isLoading: false,
            ),
          );
        },
      );
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _plantsRepository.delete(id: documentID);
    } catch (error) {
      emit(
        PlantsPageContentState(
          errorMessage: error.toString(),
          isLoading: false,
          documents: const [],
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
