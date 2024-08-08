// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      videoUrl: json['videoUrl'] as String,
      thumbnail: json['thumbnail'] as String,
      title: json['title'] as String,
      datepublished: json['datepublished'] as DateTime,
      views: json['views'] as int,
      videoId: json['videoId'] as String,
      usedId: json['usedId'] as String,
      likes: json['likes'] as List<dynamic>,
      type: json['type'] as String,
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'datepublished': instance.datepublished,
      'views': instance.views,
      'videoId': instance.videoId,
      'usedId': instance.usedId,
      'likes': instance.likes,
      'type': instance.type,
    };
