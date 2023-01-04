import 'package:consultations_app_test/application/domain/user/repositories/user_repository.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../user/entities/user.dart';

class GetUserDetails extends UseCase<UserDetailsRequest, User> {
  final UserRepository _userRepository;

  GetUserDetails({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Either<Failure, User>> execute(UserDetailsRequest request) async {
    try {
      if (_userRepository.user == null) {
        await _userRepository.loadUser();
        if (_userRepository.user == null) {
          throw Exception('User Not Available');
        }
      }
      return Right(_userRepository.user!);
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
      ));
    }
  }
}

class UserDetailsRequest extends Equatable {
  final int userId;

  const UserDetailsRequest({required this.userId});

  @override
  List<Object?> get props => [userId];
}
