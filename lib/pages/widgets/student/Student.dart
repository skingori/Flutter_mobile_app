class Student {
  String id;
  String firstName;
  String lastName;

  Student({this.id, this.firstName, this.lastName});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }
}
