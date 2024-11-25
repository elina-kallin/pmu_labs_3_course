// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemesDto _$MemesDtoFromJson(Map<String, dynamic> json) => MemesDto(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MemDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MemDataDto _$MemDataDtoFromJson(Map<String, dynamic> json) => MemDataDto(
      url: json['url'] as String?,
      fileSizeBytes: (json['fileSizeBytes'] as num?)?.toInt(),
    );
