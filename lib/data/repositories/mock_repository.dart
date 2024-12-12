import 'package:pmu_labs/domain/models/card.dart';
import 'package:pmu_labs/domain/models/home.dart';

import 'api_interface.dart';

class MockRepository extends ApiInterface {
  @override
  Future<HomeData?> loadData({OnErrorCallback? onError}) async {
    return HomeData(data: [
      CardPostData(
          description: "Третья из списка каточек ыть",
          imageUrl: "https://random-d.uk/api/214.jpg"),
      CardPostData(
          description: "Третья из списка каточек ыть",
          imageUrl: "https://random-d.uk/api/214.jpg"),
      CardPostData(
          description: "Третья из списка каточек ыть",
          imageUrl: "https://random-d.uk/api/214.jpg"),
    ]);
  }
}
