// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => VideoModel(
      description: json['description'] as String? ?? '',
      videoUrl: json['videoUrl'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      title: json['title'] as String? ?? '',
      datepublished: VideoModel._fromJson(json['datepublished'] as Timestamp? ?? Timestamp.now()),
      views: (json['views'] as num?)?.toInt() ?? 0,
      videoId: json['videoId'] as String? ?? '',
      usedId: json['usedId'] as String? ?? '',
      likes: json['likes'] as List<dynamic>? ?? [],
      type: json['type'] as String? ?? 'video',
    );

Map<String, dynamic> _$VideoModelToJson(VideoModel instance) =>
    <String, dynamic>{
      'videoUrl': instance.videoUrl,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'description': instance.description,
      'datepublished': VideoModel._toJson(instance.datepublished),
      'views': instance.views,
      'videoId': instance.videoId,
      'usedId': instance.usedId,
      'likes': instance.likes,
      'type': instance.type,
    };
