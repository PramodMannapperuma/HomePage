import 'dart:convert';

class LeaveType {
  final int value;
  final String text;
  final Map<String, dynamic> additionalData;

  LeaveType({
    required this.value,
    required this.text,
    required this.additionalData,
  });

  factory LeaveType.fromJson(Map<String, dynamic> json) {
    return LeaveType(
      value: json['value'],
      text: json['text'],
      additionalData: json['data'] is String
          ? jsonDecode(json['data']) as Map<String, dynamic>
          : json['data'] as Map<String, dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'text': text,
      'data': jsonEncode(additionalData),
    };
  }

  static List<LeaveType> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeaveType.fromJson(json as Map<String, dynamic>)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<LeaveType> leaveTypes) {
    return leaveTypes.map((leaveType) => leaveType.toJson()).toList();
  }
}
