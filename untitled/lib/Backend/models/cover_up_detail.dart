class CoverUpDetail {
  final int id;
  final String date;
  final String leaveType;
  final String time;
  final String reason;
  final String extra;
  final String? attachment;

  CoverUpDetail({
    required this.id,
    required this.date,
    required this.leaveType,
    required this.time,
    required this.reason,
    required this.extra,
    this.attachment,
  });

  factory CoverUpDetail.fromJson(Map<String, dynamic> json) {
    return CoverUpDetail(
      id: json['id'],
      date: json['date'],
      leaveType: json['leaveType'],
      time: json['time'],
      reason: json['reason'],
      extra: json['extra'],
      attachment: json['attachment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'leaveType': leaveType,
      'time': time,
      'reason': reason,
      'extra': extra,
      'attachment': attachment,
    };
  }
}
