import 'package:consultations_app_test/application/domain/user/entities/user.dart';
import 'package:consultations_app_test/application/domain/user/repositories/user_repository.dart';
import 'package:consultations_app_test/application/domain/user/useCases/get_user_details.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

User mockUserObject = const User(id: 1, name: 'Test', image: 'url');

main() {
  late GetUserDetails useCase;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetUserDetails(userRepository: mockUserRepository);
  });

  test(
      'Use case return correct user if user is already loaded, And it does not call load User Method',
      () async {
    when(
      () => mockUserRepository.user,
    ).thenReturn(mockUserObject);
    final userOrFailure = await useCase.execute(
      const UserDetailsRequest(userId: 1),
    );
    expect(
      userOrFailure,
      Right(mockUserObject),
    );
    verify(
      () => mockUserRepository.user,
    ).called(2);
    verifyNever(
      () => mockUserRepository.loadUser(),
    );
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'Use case return correct user after loading user from data source if user is null initially',
      () async {
    int count = 0;
    when(
      () => mockUserRepository.user,
    ).thenAnswer(
      (invocation) {
        if (count == 0) {
          count++;
          return null;
        }
        count++;
        return mockUserObject;
      },
    );
    when(
      () => mockUserRepository.loadUser(),
    ).thenAnswer(
      (invocation) async => Future.value(),
    );
    final userOrFailure = await useCase.execute(
      const UserDetailsRequest(userId: 1),
    );
    expect(
      userOrFailure,
      Right(mockUserObject),
    );
    verify(
      () => mockUserRepository.user,
    ).called(3);
    verify(
      () => mockUserRepository.loadUser(),
    ).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'Use case returns correct Failure if there is error loading user from data source',
      () async {
    Exception mockException = Exception('mock');
    Failure mockFailure = Failure(
      error: mockException.toString(),
    );
    when(
      () => mockUserRepository.user,
    ).thenReturn(null);
    when(
      () => mockUserRepository.loadUser(),
    ).thenThrow(mockException);
    final userOrFailure = await useCase.execute(
      const UserDetailsRequest(userId: 1),
    );
    expect(
      userOrFailure,
      Left(mockFailure),
    );
    verify(
      () => mockUserRepository.user,
    ).called(1);
    verify(
      () => mockUserRepository.loadUser(),
    ).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test(
      'Use case returns User Not Available Failure if there is error loading user from data source',
      () async {
    Exception mockException = Exception('User Not Available');
    Failure mockFailure = Failure(
      error: mockException.toString(),
    );
    when(
      () => mockUserRepository.user,
    ).thenReturn(null);
    when(
      () => mockUserRepository.loadUser(),
    ).thenAnswer(
      (invocation) async => null,
    );
    final userOrFailure = await useCase.execute(
      const UserDetailsRequest(userId: 1),
    );
    expect(
      userOrFailure,
      Left(mockFailure),
    );
    verify(
      () => mockUserRepository.user,
    ).called(2);
    verify(
      () => mockUserRepository.loadUser(),
    ).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
