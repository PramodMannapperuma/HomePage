class AttApproval {
  final int id;
  final String date;
  final String amdIn;
  final String amdOut;
  final String amdComment;

  AttApproval({
    required this.id,
    required this.date,
    required this.amdIn,
    required this.amdOut,
    required this.amdComment,
  });

  factory AttApproval.fromJson(Map<String, dynamic> json) {
    return AttApproval(
      id: json['id'] ?? 'N/A',
      date: json['date'] ?? 'N/A',
      amdIn: json['amdIn'] ?? 'N/A',
      amdOut: json['amdOut'] ?? 'N/A',
      amdComment: json['amdComment'] ?? 'N/A',
    );
  }
}
