class NewUser {
  NewUser({this.name, this.job, this.id, this.createdAt, this.updatedAt});

  NewUser.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    job = json['job'] as String?;
    id = json['id'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  String? name;
  String? job;
  String? id;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['job'] = job;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
