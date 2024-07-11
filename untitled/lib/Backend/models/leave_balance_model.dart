// lib/Backend/models/leave_balance_model.dart

class LeaveBalanceData {
  final int entitled;
  final int utilized;
  final int pending;
  final int available;

  LeaveBalanceData({
    required this.entitled,
    required this.utilized,
    required this.pending,
    required this.available,
  });

  factory LeaveBalanceData.fromJson(Map<String, dynamic> json) {
    return LeaveBalanceData(
      entitled: json['Entitled'] ?? 0,
      utilized: json['Utilized'] ?? 0,
      pending: json['Pending'] ?? 0,
      available: json['Available'] ?? 0,
    );
  }
}
