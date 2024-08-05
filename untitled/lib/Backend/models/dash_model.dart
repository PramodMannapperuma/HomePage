class DashboardData {
  Employee? employee;
  Attendance? attendance;
  List<Attendance6m>? attendance6m;

  DashboardData({this.employee, this.attendance, this.attendance6m});

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      employee: json['employee'] != null
          ? Employee.fromJson(json['employee'])
          : null,
      attendance: json['attendance'] != null
          ? Attendance.fromJson(json['attendance'])
          : null,
      attendance6m: json['attendance6m'] != null
          ? List<Attendance6m>.from(json['attendance6m']
          .map((item) => Attendance6m.fromJson(item)))
          : null,
    );
  }
}

class Employee {
  String? epf;
  String? code;
  String? name;
  String? email;
  String? image;
  String? location;
  String? department;
  String? designation;

  Employee({
    this.epf,
    this.code,
    this.name,
    this.email,
    this.image,
    this.location,
    this.department,
    this.designation,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      epf: json['epf'],
      code: json['code'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      location: json['location'],
      department: json['department'],
      designation: json['designation'],
    );
  }
}

class Attendance {
  Leave? leave;
  int? nopay;
  int? working;
  AttendanceDetails? attendance;

  Attendance({this.leave, this.nopay, this.working, this.attendance});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      leave: json['leave'] != null ? Leave.fromJson(json['leave']) : null,
      nopay: json['nopay']?.toInt(),
      working: json['working']?.toInt(),
      attendance: json['attendance'] != null
          ? AttendanceDetails.fromJson(json['attendance'])
          : null,
    );
  }
}

class Leave {
  int? active;
  int? pending;
  int? rejected;

  Leave({this.active, this.pending, this.rejected});

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      active: json['active']?.toInt(),
      pending: json['pending']?.toInt(),
      rejected: json['rejected']?.toInt(),
    );
  }
}

class AttendanceDetails {
  int? pending;
  int? rejected;
  int? attendance;
  int? incomplete;

  AttendanceDetails({this.pending, this.rejected, this.attendance, this.incomplete});

  factory AttendanceDetails.fromJson(Map<String, dynamic> json) {
    return AttendanceDetails(
      pending: json['pending']?.toInt(),
      rejected: json['rejected']?.toInt(),
      attendance: json['attendance']?.toInt(),
      incomplete: json['incomplete']?.toInt(),
    );
  }
}

class Attendance6m {
  Leave? leave;
  String? month;
  int? nopay;
  int? working;
  AttendanceDetails? attendance;

  Attendance6m({this.leave, this.month, this.nopay, this.working, this.attendance});

  factory Attendance6m.fromJson(Map<String, dynamic> json) {
    return Attendance6m(
      leave: json['leave'] != null ? Leave.fromJson(json['leave']) : null,
      month: json['month'],
      nopay: json['nopay']?.toInt(),
      working: json['working']?.toInt(),
      attendance: json['attendance'] != null
          ? AttendanceDetails.fromJson(json['attendance'])
          : null,
    );
  }
}

