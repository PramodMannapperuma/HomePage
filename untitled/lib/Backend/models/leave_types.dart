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
      // Decode the data if it's a string
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

  // Convert a list of JSON maps into a list of LeaveType objects
  static List<LeaveType> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeaveType.fromJson(json as Map<String, dynamic>)).toList();
  }

  // Convert a list of LeaveType objects into a list of JSON maps
  static List<Map<String, dynamic>> toJsonList(List<LeaveType> leaveTypes) {
    return leaveTypes.map((leaveType) => leaveType.toJson()).toList();
  }
}

