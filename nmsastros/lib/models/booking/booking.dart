import 'dart:convert';

class Booking {
  String? id;
  String chartId;
  String userId;

  //método construtor
  Booking({
    this.id,
    required this.chartId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'chartId': chartId,
      'userId': userId,
    };
  }

  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'] as String,
      chartId: map['chartId'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Booking.fromJson(String source) =>
      Booking.fromMap(json.decode(source));

  @override
  String toString() => 'Booking(id: $id, chartId: $chartId, userId: $userId)';
}
