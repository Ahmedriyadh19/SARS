import 'dart:convert';

import 'package:flutter/foundation.dart';

class Report {
  String type;
  String description;
  DateTime dateTime;
  String status;
  List<String> images;
  String video;
  String userId;
  
  Report({
    required this.type,
    required this.description,
    required this.dateTime,
    required this.status,
    required this.images,
    required this.video,
    required this.userId,
  });

  Report copyWith({
    String? type,
    String? description,
    DateTime? dateTime,
    String? status,
    List<String>? images,
    String? video,
    String? userId,
  }) {
    return Report(
      type: type ?? this.type,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      images: images ?? this.images,
      video: video ?? this.video,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'status': status,
      'images': images,
      'video': video,
      'userId': userId,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      type: map['type'] ?? '',
      description: map['description'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      status: map['status'] ?? '',
      images: List<String>.from(map['images']),
      video: map['video'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(type: $type, description: $description, dateTime: $dateTime, status: $status, images: $images, video: $video, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Report &&
      other.type == type &&
      other.description == description &&
      other.dateTime == dateTime &&
      other.status == status &&
      listEquals(other.images, images) &&
      other.video == video &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return type.hashCode ^
      description.hashCode ^
      dateTime.hashCode ^
      status.hashCode ^
      images.hashCode ^
      video.hashCode ^
      userId.hashCode;
  }
}
