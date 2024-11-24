import 'package:dio/dio.dart';
import 'package:pmu_labs/data/dtos/mem_dto.dart';
import 'package:pmu_labs/data/mappers/mem_mapper.dart';
import 'package:pmu_labs/data/repositories/api_interface.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PotterRepository extends ApiInterface{
  static final Dio _dio = Dio()
  ..interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true
  ));

  // static const String _baseUrl = "https://api.humorapi.com";
  // static const String _apiKey = "?api-key=1e19895aa83e49a8b08a4186b0a39416";

  static const String _baseUrl = 'https://random-d.uk/api/v2';


  @override
  Future<List<CardPostData>?> loadData() async {
    try{
        // const String url = '$_baseUrl/memes/random$_apiKey';
        const String url = '$_baseUrl/random';

        final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(url);

        final MemesDto dto = MemesDto.fromJson(response.data as Map<String, dynamic>);
        final List<CardPostData>? data = dto.data?.map((e) => e.toDomain()).toList();
        return data;
    } on DioException catch (e){
      return null;
    }
  }
}