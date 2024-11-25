import 'package:pmu_labs/domain/models/card.dart';

import 'api_interface.dart';

class MockRepository extends ApiInterface {
  @override
  Future<List<CardPostData>?> loadData() async {
    return [
      CardPostData(
          description: "Первая из списка карточек ыть",
          imageUrl: "https://random-d.uk/api/214.jpg"),
      CardPostData(
          description: "Вторая из списка карточек ыть",
          imageUrl: "https://random.dog/c34c4ba7-3fdc-4c4e-b57e-72394aef5d08.jpg"),
      // CardPostData(
      //     description: "Третья из списка каточек ыть",
      //     imageUrl: "https://random-d.uk/api/214.jpg"),
      // CardPostData(
      //     description: "нет, он не кловун",
      //     imageUrl: "https://random-d.uk/api/214.jpg"),
    ];
  }
}
