import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/useCases/use_case.dart';

class CreateAppointment extends UseCase<CreateAppointmentRequest, bool> {
  final AppointmentsRepository _appointmentsRepository;

  CreateAppointment({required AppointmentsRepository appointmentsRepository})
      : _appointmentsRepository = appointmentsRepository;

  @override
  Future<Either<Failure, bool>> execute(
      CreateAppointmentRequest request) async {
    try {
      await _appointmentsRepository.createAppointment(
          request.userId, request.doctorId, request.time);
      return const Right(true);
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
      ));
    }
  }
}

class CreateAppointmentRequest {
  final int userId;
  final int doctorId;
  final int time;

  CreateAppointmentRequest({
    required this.userId,
    required this.doctorId,
    required this.time,
  });
}
