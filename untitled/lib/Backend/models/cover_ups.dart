class CoverUp {
  final String id;
  final String name;

  CoverUp({required this.id, required this.name});

  factory CoverUp.fromJson(Map<String, dynamic> json) {
    return CoverUp(
      id: json['value'],
      name: json['text'],
    );
  }

  static List<CoverUp> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CoverUp.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

