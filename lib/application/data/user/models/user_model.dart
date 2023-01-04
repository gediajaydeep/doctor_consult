import 'package:consultations_app_test/application/domain/user/entities/user.dart';

class UserModel {
  int? id;
  String? name;
  String? image;

  UserModel({required this.id, this.name, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'];
    image = json['image'];
  }

  toUser() {
    return User(id: id!, name: name, image: image);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
