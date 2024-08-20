class Subordinate {
  final String id;
  final String name;
  final String designation;

  Subordinate({
    required this.id,
    required this.name,
    required this.designation,
  });

  factory Subordinate.fromJson(Map<String, dynamic> json) {
    return Subordinate(
      id: json['id'].toString(),  // Assuming 'id' is returned as an int or string
      name: json['preferred_name'], // Adjusted to match your actual API field name
      designation: json['designation'],
    );
  }
}
