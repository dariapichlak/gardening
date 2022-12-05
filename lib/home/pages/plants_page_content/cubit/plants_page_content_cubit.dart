import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'plants_page_content_state.dart';

class PlantsPageContentCubit extends Cubit<PlantsPageContentState> {
  PlantsPageContentCubit()
      : super(const PlantsPageContentState(
          documents: [],
          isLoading: false,
          errorMessage: '',
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      const PlantsPageContentState(
        documents: [],
        errorMessage: '',
        isLoading: true,
      ),
    );

    _streamSubscription = FirebaseFirestore.instance
        .collection('plants')
        .snapshots()
        .listen((data) {
      emit(
        PlantsPageContentState(
          documents: data.docs,
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
      await FirebaseFirestore.instance
          .collection('plants')
          .doc(documentID)
          .delete();
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
