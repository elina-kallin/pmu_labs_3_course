import 'package:pmu_labs/data/dtos/mem_dto.dart';
import 'package:pmu_labs/domain/models/card.dart';

extension MemDataDtoToModel on MemDataDto{
  CardPostData toDomain() => CardPostData(
    description: fileSizeBytes.toString() ?? "А описания нет",
    imageUrl: url,
  );
}