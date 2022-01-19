import 'dart:convert';

class RateFeedback {
  String reportId;
  int rate;
  String feedback;
  RateFeedback({
    required this.reportId,
    required this.rate,
    required this.feedback,
  });

  RateFeedback copyWith({
    String? reportId,
    int? rate,
    String? feedback,
  }) {
    return RateFeedback(
      reportId: reportId ?? this.reportId,
      rate: rate ?? this.rate,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reportId': reportId,
      'rate': rate,
      'feedback': feedback,
    };
  }

  factory RateFeedback.fromMap(Map<String, dynamic> map) {
    return RateFeedback(
      reportId: map['reportId'] ?? '',
      rate: map['rate']?.toInt() ?? 0,
      feedback: map['feedback'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RateFeedback.fromJson(String source) => RateFeedback.fromMap(json.decode(source));

  @override
  String toString() => 'RateFeedback(reportId: $reportId, rate: $rate, feedback: $feedback)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RateFeedback &&
      other.reportId == reportId &&
      other.rate == rate &&
      other.feedback == feedback;
  }

  @override
  int get hashCode => reportId.hashCode ^ rate.hashCode ^ feedback.hashCode;
}
