import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String? name;
  final String? image;

  const User({required this.id, this.name, this.image});

  @override
  List<Object?> get props => [id, name, image];
}
