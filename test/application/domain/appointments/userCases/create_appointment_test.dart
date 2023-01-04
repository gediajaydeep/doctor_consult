import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';
import 'package:consultations_app_test/application/domain/appointments/useCases/create_appointment.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppointmentRepository extends Mock implements AppointmentsRepository {
}

main() {
  late MockAppointmentRepository mockAppointmentRepository;
  late CreateAppointment useCase;
  CreateAppointmentRequest request =
      CreateAppointmentRequest(userId: 1, doctorId: 1, time: 100033);
  setUp(() {
    mockAppointmentRepository = MockAppointmentRepository();
    useCase =
        CreateAppointment(appointmentsRepository: mockAppointmentRepository);
  });

  test('Should call createAppointment method when executed', () async {
    await useCase.execute(request);
    verify(
      () => mockAppointmentRepository.createAppointment(
          request.userId, request.doctorId, request.time),
    ).called(1);
  });

  test(
    'Should return true without errors when repository creates appointment successfully',
    () async {
      when(
        () => mockAppointmentRepository.createAppointment(
            request.userId, request.doctorId, request.time),
      ).thenAnswer(
        (invocation) => Future.value(),
      );

      final successOrFailure = await useCase.execute(request);

      expect(
        successOrFailure,
        const Right(true),
      );
    },
  );

  test(
    'Should return correct Failure repository throws error creating appointment',
    () async {
      Exception exception = Exception('error');
      Failure failure = Failure(
        error: exception.toString(),
      );
      when(
        () => mockAppointmentRepository.createAppointment(
            request.userId, request.doctorId, request.time),
      ).thenThrow(exception);

      final successOrFailure = await useCase.execute(request);

      expect(
        successOrFailure,
        Left(failure),
      );
    },
  );
}
