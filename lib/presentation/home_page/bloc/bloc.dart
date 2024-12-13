import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';

class HomeBlock extends Bloc<HomeEvent, HomeState> {
  final PotterRepository repository;

  HomeBlock(this.repository) : super(const HomeState()) {
    on<HomeLoadDataEvent>(_onLoadData);
  }

  Future<void> _onLoadData(
      HomeLoadDataEvent event, Emitter<HomeState> emit) async {
    if (event.nextPage == null) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isPaginationLoading: true));
    }

    final data =
        await repository.loadData(q: event.search, page: event.nextPage ?? 0);

    if(event.nextPage != null){
      data?.data?.insertAll(0, state.data?.data ?? []);
    }

    emit(state.copyWith(
      isLoading: false,
      isPaginationLoading: false,
      data: data,
    ));
  }
}
