import 'package:equatable/equatable.dart';
import 'package:pmu_labs/domain/models/card.dart';

class HomeState extends Equatable {
  final List<CardPostData>? data;
  final bool isLoading;

  const HomeState({this.data, this.isLoading = false});

  HomeState copyWith({List<CardPostData>? data, bool? isLoading}) => HomeState(
      data: data ?? this.data, isLoading: isLoading ?? this.isLoading);

  @override
  List<Object?> get props => [data, isLoading];
}
