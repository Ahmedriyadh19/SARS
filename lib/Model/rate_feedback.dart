import 'dart:convert';

class RateFeedback {
  String ticketId;
  int rate;
  String feedback;
  
  RateFeedback({
    required this.ticketId,
    required this.rate,
    required this.feedback,
  });

  RateFeedback copyWith({
    String? ticketId,
    int? rate,
    String? feedback,
  }) {
    return RateFeedback(
      ticketId: ticketId ?? this.ticketId,
      rate: rate ?? this.rate,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ticketId': ticketId,
      'rate': rate,
      'feedback': feedback,
    };
  }

  factory RateFeedback.fromMap(Map<String, dynamic> map) {
    return RateFeedback(
      ticketId: map['ticketId'] ?? '',
      rate: map['rate']?.toInt() ?? 0,
      feedback: map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RateFeedback.fromJson(String source) => RateFeedback.fromMap(json.decode(source));

  @override
  String toString() => 'RateFeedback(ticketId: $ticketId, rate: $rate, feedback: $feedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RateFeedback &&
      other.ticketId == ticketId &&
      other.rate == rate &&
      other.feedback == feedback;
  }

  @override
  int get hashCode => ticketId.hashCode ^ rate.hashCode ^ feedback.hashCode;
}
