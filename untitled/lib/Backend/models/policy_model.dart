class Policy {
  final int id;
  final String name;
  final String file;

  Policy({
    required this.id,
    required this.name,
    required this.file,
  });

  factory Policy.fromJson(Map<String, dynamic> json) {
    return Policy(
      id: json['id'],
      name: json['name'],
      file: json['file'],
    );
  }
}