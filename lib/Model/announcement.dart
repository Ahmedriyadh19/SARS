import 'dart:convert';

class Announcement {
  DateTime dateTime;
  String contain;

  
  Announcement({
    required this.dateTime,
    required this.contain,
  });

  Announcement copyWith({
    DateTime? dateTime,
    String? contain,
  }) {
    return Announcement(
      dateTime: dateTime ?? this.dateTime,
      contain: contain ?? this.contain,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.millisecondsSinceEpoch,
      'contain': contain,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      contain: map['contain'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source));

  @override
  String toString() => 'Announcement(dateTime: $dateTime, contain: $contain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Announcement &&
        other.dateTime == dateTime &&
        other.contain == contain;
  }

  @override
  int get hashCode => dateTime.hashCode ^ contain.hashCode;
}
