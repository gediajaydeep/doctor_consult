import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';
import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';

import '../dataSources/appointments_local_data_source.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsLocalDataSource _localDataSource;

  AppointmentsRepositoryImpl(
      {required AppointmentsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<void> createAppointment(int userId, int doctorId, int time) async {
    await _localDataSource.saveAppointment(userId, doctorId, time);
    return;
  }

  @override
  Future<List<Appointment>> getUserAppointments(int userId) async {
    return (await _localDataSource.getUserAppointmentList(userId))
        .map(
          (e) => e.toAppointment(),
        )
        .toList();
  }
}
