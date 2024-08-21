class LeaveApproval {
  final int id;
  final String leaveType;
  final String date;
  final String reason;
  final String time;

  LeaveApproval({
    required this.id,
    required this.leaveType,
    required this.date,
    required this.reason,
    required this.time,
  });

  factory LeaveApproval.fromJson(Map<String, dynamic> json) {
    return LeaveApproval(
      id: json['id'] ?? 'N/A',
      leaveType: json['leaveType'] ?? 'N/A',
      date: json['date'] ?? 'N/A',
      reason: json['reason'] ?? 'N/A',
      time: json['time'] ?? 'N/A',
    );
  }
}
