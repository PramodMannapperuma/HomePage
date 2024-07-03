class AttendanceData {
  final String? amdIn;
  final String? recIn;
  final String? amdOut;
  final String? comment;
  final String? recOut;
  final String? date;
  final String? status;

  AttendanceData({
    this.amdIn,
    this.recIn,
    this.amdOut,
    this.comment,
    this.recOut,
    this.date,
    this.status,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return AttendanceData(
      amdIn: data['amd_in'],
      recIn: data['rec_in'],
      amdOut: data['amd_out'],
      comment: data['comment'],
      recOut: data['rec_out'],
      date: json['date'],
      status: json['status'],
    );
  }
}