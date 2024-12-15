// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mem_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemesDto _$MemesDtoFromJson(Map<String, dynamic> json) => MemesDto(
      (json['current'] as num?)?.toInt(),
      (json['next'] as num?)?.toInt(),
      (json['last'] as num?)?.toInt(),
      (json['prevPage'] as num?)?.toInt(),
      (json['pageSize'] as num?)?.toInt(),
      (json['memesCount'] as num?)?.toInt(),
      (json['pagesCount'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MemDataDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

MemDataDto _$MemDataDtoFromJson(Map<String, dynamic> json) => MemDataDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
