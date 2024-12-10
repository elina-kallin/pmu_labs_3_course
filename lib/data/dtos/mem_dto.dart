import 'package:json_annotation/json_annotation.dart';

part 'mem_dto.g.dart';

@JsonSerializable(createToJson: false)
class MemesDto {
  final List<MemDataDto>? data;

  const MemesDto({this.data});

  factory MemesDto.fromJson(Map<String, dynamic> json) =>
      _$MemesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MemDataDto {
  final int? id;
  final String? name;
  final String? url;

  const MemDataDto(
      {
        this.id,
      this.name,
      this.url,
      });

  factory MemDataDto.fromJson(Map<String, dynamic> json) =>
      _$MemDataDtoFromJson(json);
}
