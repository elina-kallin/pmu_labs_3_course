import 'package:pmu_labs/data/dtos/mem_dto.dart';
import 'package:pmu_labs/domain/models/card.dart';

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
      description: isValidImageUrl(url) ? name.toString() : "эх, изображения не будет, жержите вот такое",
      imageUrl: isValidImageUrl(url)
          ? url!
          : "https://i.pinimg.com/736x/1d/a6/b4/1da6b436eaea738125e3bdba0c4f74b6.jpg",
    );
  }
}
