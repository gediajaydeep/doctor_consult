import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../repositories/appointments_repository.dart';

class GetAppointmentList
    extends UseCase<AppointmentListRequest, List<Appointment>> {
  final AppointmentsRepository _appointmentsRepository;

  GetAppointmentList({required AppointmentsRepository appointmentsRepository})
      : _appointmentsRepository = appointmentsRepository;

  @override
  Future<Either<Failure, List<Appointment>>> execute(
      AppointmentListRequest request) async {
    try {
      return Right(
        await _appointmentsRepository.getUserAppointments(request.userId),
      );
    } catch (e) {
      return Left(
        Failure(
          error: e.toString(),
        ),
      );
    }
  }
}

class AppointmentListRequest extends Equatable {
  final int userId;

  const AppointmentListRequest({required this.userId});

  @override
  List<Object?> get props => [userId];
}
