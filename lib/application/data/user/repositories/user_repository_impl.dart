import 'package:consultations_app_test/application/data/user/dataSources/user_local_data_source.dart';
import 'package:consultations_app_test/application/data/user/models/user_model.dart';
import 'package:consultations_app_test/application/domain/user/entities/user.dart';
import 'package:consultations_app_test/application/domain/user/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _localDataSource;

  UserRepositoryImpl(UserLocalDataSource userLocalDataSource)
      : _localDataSource = userLocalDataSource;

  UserModel? _userModel;

  @override
  Future loadUser() async {
    _userModel = await _localDataSource.getUser();
  }

  @override
  User? get user => _userModel?.toUser();
}
