class AttApproval {
  final String date;
  final String amdIn;
  final String amdOut;
  final String amdComment;

  AttApproval({
    required this.date,
    required this.amdIn,
    required this.amdOut,
    required this.amdComment,
  });

  factory AttApproval.fromJson(Map<String, dynamic> json) {
    return AttApproval(
      date: json['date'] ?? 'N/A',
      amdIn: json['amdIn'] ?? 'N/A',
      amdOut: json['amdOut'] ?? 'N/A',
      amdComment: json['amdComment'] ?? 'N/A',
    );
  }
}
