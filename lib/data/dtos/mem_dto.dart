import 'package:json_annotation/json_annotation.dart';

part 'mem_dto.g.dart';

@JsonSerializable(createToJson: false)
class MemesDto {
  final int? current;
  final int? next;
  final int? last;
  final int? prevPage;
  final int? pageSize;
  final int? memesCount;
  final int? pagesCount;

  final List<MemDataDto>? data;

  const MemesDto(
      this.current,
      this.next,
      this.last,
      this.prevPage,
      this.pageSize,
      this.memesCount,
      this.pagesCount,
      {this.data});

  factory MemesDto.fromJson(Map<String, dynamic> json) =>
      _$MemesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class MemDataDto {
  final int? id;
  final String? name;
  final String? imageUrl;

  const MemDataDto({
    this.id,
    this.name,
    this.imageUrl,
  });

  factory MemDataDto.fromJson(Map<String, dynamic> json) =>
      _$MemDataDtoFromJson(json);
}
