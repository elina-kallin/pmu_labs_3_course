import 'package:equatable/equatable.dart';
import 'package:pmu_labs/domain/models/card.dart';

class HomeState extends Equatable{
  final Future<List<CardPostData>?>? data;

  const HomeState({this.data});

  HomeState copyWith({Future<List<CardPostData>?>? data}) => HomeState(data: data ?? this.data);

  @override
  List<Object?> get props => [data];
}