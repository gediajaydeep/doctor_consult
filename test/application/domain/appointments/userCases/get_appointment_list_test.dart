import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';
import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';
import 'package:consultations_app_test/application/domain/appointments/useCases/get_appointment_list.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/user/entities/user.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAppointmentRepository extends Mock implements AppointmentsRepository {
}

main() {
  late MockAppointmentRepository mockAppointmentRepository;
  late GetAppointmentList useCase;
  List<Appointment> tAppointmentList = _getTestAppointmentList();
  AppointmentListRequest request = const AppointmentListRequest(userId: 1);
  setUp(
    () {
      mockAppointmentRepository = MockAppointmentRepository();
      useCase =
          GetAppointmentList(appointmentsRepository: mockAppointmentRepository);
    },
  );

  test('Should call getUserAppointmentList mehtod when executed', () async {
    await useCase.execute(request);
    verify(
      () => mockAppointmentRepository.getUserAppointments(request.userId),
    ).called(1);
  });

  test('Should Return correct list when repository return list successfully',
      () async {
    when(
      () => mockAppointmentRepository.getUserAppointments(request.userId),
    ).thenAnswer((invocation) async => tAppointmentList);
    final listOrFailure = await useCase.execute(request);
    expect(
      listOrFailure,
      Right(tAppointmentList),
    );
  });

  test(
      'Should calReturn correct Failure when repository throws exception getting list',
      () async {
    Exception exception = Exception('error');
    Failure failure = Failure(
      error: exception.toString(),
    );
    when(
      () => mockAppointmentRepository.getUserAppointments(request.userId),
    ).thenThrow(exception);
    final listOrFailure = await useCase.execute(request);
    expect(
      listOrFailure,
      Left(failure),
    );
  });
}

List<Appointment> _getTestAppointmentList() {
  return [
    Appointment(
        user: const User(id: 1, name: 'John'),
        doctor: const Doctor(id: 1, name: 'Test Doctor'),
        time: 1122325),
    Appointment(
        user: const User(id: 1, name: 'John'),
        doctor: const Doctor(id: 2, name: 'Test Doctor 2'),
        time: 1122326)
  ];
}
