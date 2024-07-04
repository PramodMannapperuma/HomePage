class LeaveData {
  final String? amdIn;
  final String? recIn;
  final String? amdOut;
  final String? comment;
  final String? recOut;
  final String? date;
  final String? status;

  LeaveData({
    this.amdIn,
    this.recIn,
    this.amdOut,
    this.comment,
    this.recOut,
    this.date,
    this.status,
  });

  factory LeaveData.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return LeaveData(
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