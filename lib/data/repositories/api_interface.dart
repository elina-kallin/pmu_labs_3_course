import 'package:pmu_labs/domain/models/home.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<HomeData?> loadData({OnErrorCallback? onError});
}
