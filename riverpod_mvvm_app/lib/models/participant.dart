// models/participant.dart
class Participant {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatarUrl;

  Participant({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar'],
    );
  }
}
