import 'dart:convert';

class ApprovalItem {
  final String item;
  final String employee;
  final String designation;
  final String code;

  ApprovalItem({
    required this.item,
    required this.employee,
    required this.designation,
    required this.code,
  });

  factory ApprovalItem.fromJson(Map<String, dynamic> json) {
    return ApprovalItem(
      item: json['item'] as String,
      employee: json['employee'] as String,
      designation: json['designation'] as String,
      code: json['code'] as String,
    );
  }
}
