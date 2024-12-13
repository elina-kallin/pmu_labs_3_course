import 'package:dio/dio.dart';
import 'package:pmu_labs/data/dtos/mem_dto.dart';
import 'package:pmu_labs/data/mappers/mem_mapper.dart';
import 'package:pmu_labs/data/repositories/api_interface.dart';
import 'package:pmu_labs/domain/models/home.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PotterRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  // static const String _baseUrl = "https://api.humorapi.com";
  // static const String _apiKey = "?api-key=1e19895aa83e49a8b08a4186b0a39416";

  // static const String _baseUrl = 'https://random-d.uk/api/v2';
  // static const String _baseUrl = 'https://random.dog/woof.json?ref=public_apis&utm_medium=website';
  static const String _baseUrl = 'https://mem-api.ekallin.ru/api';

  @override
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    String? q,
    int page = 0,
    int pageSize = 5
  }) async {
    // try {
      const String url = "$_baseUrl/memes";

      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'name': q,
          'pageNumber': page,
          'pageSize': pageSize
        },
      );

      final MemesDto dto = MemesDto.fromJson(response.data as Map<String, dynamic>);
      final HomeData data = dto.toDomain();
      return data; // Вернуть список после завершения всех запросов
    // } on DioException catch (e) {
     // onError?.call(e.response?.statusMessage);
     // return null;
      // }
      // data.add(CardPostData(
      //   description:
      //       "Не удалось загрузить данные, показано статическое изображение.",
      //   imageUrl:
      //       "https://i.pinimg.com/736x/1d/a6/b4/1da6b436eaea738125e3bdba0c4f74b6.jpg",
      // ));
    // }
  }
}
