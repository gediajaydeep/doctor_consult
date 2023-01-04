import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';

abstract class AppointmentsRepository {
  Future<List<Appointment>> getUserAppointments(int userId);

  Future<void> createAppointment(int userId, int doctorId, int time);
}
