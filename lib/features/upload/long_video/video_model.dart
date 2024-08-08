import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoModel {
  final String videoUrl;
  final String thumbnail;
  final String title;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  final DateTime datepublished;
  final int views;
  final String videoId;
  final String usedId;
  final List<dynamic> likes;
  final String type;

  VideoModel({
    required this.videoUrl,
    required this.thumbnail,
    required this.title,
    required this.datepublished,
    required this.views,
    required this.videoId,
    required this.usedId,
    required this.likes,
    required this.type,
  });

  // From JSON
  factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$VideoModelToJson(this);

  static DateTime _fromJson(Timestamp timestamp) => timestamp.toDate();
  static Timestamp _toJson(DateTime date) => Timestamp.fromDate(date);
}
