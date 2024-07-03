class AttendanceData {
  final String? amdIn;
  final String? recIn;
  final String? amdOut;
  final String? comment;
  final String? recOut;
  final String date;
  final String? status;

  AttendanceData({
    this.amdIn,
    this.recIn,
    this.amdOut,
    this.comment,
    this.recOut,
    required this.date,
    this.status,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      amdIn: json['data']['amd_in'],
      recIn: json['data']['rec_in'],
      amdOut: json['data']['amd_out'],
      comment: json['data']['comment'],
      recOut: json['data']['rec_out'],
      date: json['date'],
      status: json['status'],
    );
  }
}