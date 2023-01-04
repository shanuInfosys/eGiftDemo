import 'dart:convert';

RegisterModal clientFromJson(String str) {
  final jsonData = json.decode(str);
  return RegisterModal.fromMap(jsonData);
}

String clientToJson(RegisterModal data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class RegisterModal {
  late String name, email, password;

  RegisterModal(
      {required this.email, required this.name, required this.password});

  factory RegisterModal.fromMap(Map<String, dynamic> json) => RegisterModal(
        email: json["email"],
        name: json["name"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "name": name,
        "password": password,
      };
}
