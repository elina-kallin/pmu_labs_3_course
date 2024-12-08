import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pmu_labs/data/repositories/potter_repository.dart';
import 'package:pmu_labs/presentation/home_page/bloc/events.dart';
import 'package:pmu_labs/presentation/home_page/bloc/state.dart';

class HomeBlock extends Bloc<HomeEvent, HomeState>{

  final PotterRepository repository;
  HomeBlock(this.repository) : super(const HomeState()){
    on<HomeLoadDataEvent>(_onLoadData);
  }

  void _onLoadData(HomeLoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData()));
  }
}