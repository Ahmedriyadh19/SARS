import 'dart:convert';



class Notification {
  DateTime dateTime;
  String contain;
  
  Notification({
    required this.dateTime,
    required this.contain,
  });
  

  Notification copyWith({
    DateTime? dateTime,
    String? contain,
  }) {
    return Notification(
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

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
      contain: map['contain'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) => Notification.fromMap(json.decode(source));

  @override
  String toString() => 'Notification(dateTime: $dateTime, contain: $contain)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Notification &&
      other.dateTime == dateTime &&
      other.contain == contain;
  }

  @override
  int get hashCode => dateTime.hashCode ^ contain.hashCode;
}
