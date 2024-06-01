class User {
  User({this.id, this.email, this.firstName, this.lastName, this.avatar});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    email = json['email'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    avatar = json['avatar'] as String?;
  }

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}
