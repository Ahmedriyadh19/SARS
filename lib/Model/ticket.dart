import 'dart:io';

class Ticket {
  String userId;
  String type;
  String description;
  String? location;
  int status;
  DateTime dateTime;
  List<File>? images;
  File? video;

  Ticket({
    required this.userId,
    required this.dateTime,
    required this.status,
    required this.type,
    required this.description,
    this.location,
    this.images,
    this.video,
  });

  @override
  String toString() {
    return 'Ticket(userId: $userId, type: $type, description: $description, location: $location, status: $status, dateTime: $dateTime, images: $images, video: $video)';
  }
}
