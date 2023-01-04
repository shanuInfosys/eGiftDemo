class UserCredentials {
  late String username, password, type, name;
  UserCredentials(
      {required this.username,
      required this.password,
      required this.type,
      required this.name});

  UserCredentials.fromMap(Map<String, dynamic> result)
      : username = result['username'],
        password = result['password'],
        name = result['name'],
        type = result['type'];

  Map<String, Object?> toMap() {
    return {
      'username': username,
      'password': password,
      'type': type,
      'name': name
    };
  }
}
