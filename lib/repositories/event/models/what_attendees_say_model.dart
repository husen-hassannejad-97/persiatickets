import '../../base/base_model.dart';

class WhatAttendeesSayModel implements BaseModel {
  final String averageScore;
  final List<CommentModel> comments;

  WhatAttendeesSayModel({
    required this.averageScore,
    required this.comments
  });
}

class CommentModel implements BaseModel {
  final String? image;
  final String? name;
  final double? score;
  final DateTime date;
  final String comment;
  final CommentModel? organizerResponse;

  CommentModel({
    required this.image,
    required this.name,
    required this.score,
    required this.date,
    required this.comment,
    this.organizerResponse,
  });
}
