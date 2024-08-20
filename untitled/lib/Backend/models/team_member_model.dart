class TeamMember {
  final int id;
  final String name;
  final String designation;
  final int supervisor;

  TeamMember({
    required this.id,
    required this.name,
    required this.designation,
    required this.supervisor,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      supervisor: json['supervisor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'supervisor': supervisor,
    };
  }
}
