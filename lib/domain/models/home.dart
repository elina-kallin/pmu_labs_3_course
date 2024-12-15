import 'package:pmu_labs/domain/models/card.dart';

class HomeData {
  final List<CardPostData>? data;
  final int? nextPage;

  HomeData({this.data, this.nextPage});
}
