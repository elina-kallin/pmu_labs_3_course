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
  final int? width;
  final int? height;
  final String? description;
  final String? url;
  final String? type;
  final double? ratio;

  const MemDataDto({this.id, this.description, this.url, this.type, this.width, this.height, this.ratio});

  factory MemDataDto.fromJson(Map<String, dynamic> json) =>
      _$MemDataDtoFromJson(json);
}
