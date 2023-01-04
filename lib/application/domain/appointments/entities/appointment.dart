import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/user/entities/user.dart';

class Appointment {
  final User user;
  final Doctor doctor;
  final int time;

  Appointment({required this.user, required this.doctor, required this.time});
}
