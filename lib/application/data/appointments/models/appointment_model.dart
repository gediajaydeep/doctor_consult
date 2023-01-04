import 'package:consultations_app_test/application/data/doctors/models/doctor_model.dart';
import 'package:consultations_app_test/application/data/user/models/user_model.dart';
import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';

class AppointmentModel {
  UserModel? user;
  DoctorModel? doctor;
  int? time;

  AppointmentModel({this.user, this.doctor, this.time});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    doctor =
        json['doctor'] != null ? DoctorModel.fromJson(json['doctor']) : null;
    time = json['time'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    data['time'] = time;
    return data;
  }

  Appointment toAppointment() {
    return Appointment(
        user: user!.toUser(), doctor: doctor!.toDoctor(), time: time!);
  }
}
