import 'dart:convert';

class Announcement {
  DateTime dateTime;
  String title;
  String contain;

  
  Announcement({
    required this.dateTime,
    required this.title,
    required this.contain,
  });

  Announcement copyWith({
    DateTime? dateTime,
    String? title,
    String? contain,
  }) {
    return Announcement(
      dateTime: dateTime ?? this.dateTime,
      title: title ?? this.title,
      contain: contain ?? this.contain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'title': title,
      'contain': contain,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      title: map['title'] ?? '',
      contain: map['contain'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source));

  @override
  String toString() => 'Announcement(dateTime: $dateTime, title: $title, contain: $contain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Announcement &&
      other.dateTime == dateTime &&
      other.title == title &&
      other.contain == contain;
  }

  @override
  int get hashCode => dateTime.hashCode ^ title.hashCode ^ contain.hashCode;
}
