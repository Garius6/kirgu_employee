class WtaEvent {
  final DateTime date;

  WtaEvent({required this.date});

  WtaEvent.fromJson(Map<String, dynamic> json)
      : date = DateTime.parse(json['date']);

  Map<String, dynamic> toJson() => {'date': date.toIso8601String()};
}
