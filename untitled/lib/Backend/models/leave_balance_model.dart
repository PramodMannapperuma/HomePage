// lib/Backend/models/leave_balance_model.dart

class LeaveBalanceData {
  final String leave;
  final double total;
  final int leaveId;
  final double pending;
  final double utilized;
  final double available;

  LeaveBalanceData({
    required this.leave,
    required this.total,
    required this.leaveId,
    required this.pending,
    required this.utilized,
    required this.available,
  });

  factory LeaveBalanceData.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceData(
      leave: json['leave'],
      total: json['total'].toDouble(),
      leaveId: json['leaveId'],
      pending: json['pending'].toDouble(),
      utilized: json['utilized'].toDouble(),
      available: json['available'].toDouble(),
    );
  }
}
