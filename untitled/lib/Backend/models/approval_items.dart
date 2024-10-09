import 'dart:convert';

class ApprovalItem {
  final int id;
  final String item;
  final String employee;
  final String designation;
  final String code;

  ApprovalItem({
    required this.id,
    required this.item,
    required this.employee,
    required this.designation,
    required this.code,
  });

  factory ApprovalItem.fromJson(Map<String, dynamic> json) {
    return ApprovalItem(
      id: json['id'] as int,
      item: json['item'] as String,
      employee: json['employee'] as String,
      designation: json['designation'] as String,
      code: json['code'] as String,
    );
  }
}
