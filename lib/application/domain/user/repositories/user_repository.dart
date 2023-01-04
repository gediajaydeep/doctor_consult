import '../../user/entities/user.dart';

abstract class UserRepository {
  User? get user;

  Future loadUser();
}
