import 'package:pmu_labs/data/dtos/mem_dto.dart';
import 'package:pmu_labs/domain/models/card.dart';
import 'package:pmu_labs/domain/models/home.dart';

extension MemesDtoToModel on MemesDto {
  HomeData toDomain() => HomeData(data: data?.map((e) => e.toDomain()).toList(), nextPage: next);
}

extension MemDataDtoToModel on MemDataDto {
  CardPostData toDomain() {
    // Список допустимых расширений
    const allowedExtensions = ['jpg', 'jpeg', 'gif', 'png'];

    // Проверка на наличие допустимого расширения
    bool isValidImageUrl(String? url) {
      if (url == null) return false;
      final extension = url.split('.').last.toLowerCase();
      return allowedExtensions.contains(extension);
    }

    return CardPostData(
      description: isValidImageUrl(imageUrl)
          ? name.toString()
          : "эх, изображения не будет, жержите вот такое",
      imageUrl: isValidImageUrl(imageUrl) ? imageUrl! : "https://mem-api.ekallin.ru/images/2.png",
      id: id,
    );
  }
}
