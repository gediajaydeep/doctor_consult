import 'dart:convert';

import 'package:consultations_app_test/application/data/appointments/models/appointment_model.dart';
import 'package:consultations_app_test/application/data/user/models/user_model.dart';

import '../../../../core/dataManager/cached_data_manager.dart';
import '../../doctors/models/doctor_model.dart';

abstract class AppointmentsLocalDataSource {
  Future<List<AppointmentModel>> getUserAppointmentList(int userId);

  Future<void> saveAppointment(int userId, int doctorId, int time);
}

class AppointmentsLocalDataSourceImpl implements AppointmentsLocalDataSource {
  final CachedDataManager _cachedDataManager;

  AppointmentsLocalDataSourceImpl(
      {required CachedDataManager cachedDataManager})
      : _cachedDataManager = cachedDataManager;

  @override
  Future<void> saveAppointment(int userId, int doctorId, int time) async {
    _AppointmentFileModel appointment =
        _AppointmentFileModel(user: userId, doctor: doctorId, time: time);
    Set<_AppointmentFileModel> set = await _getAppointmentListFromJsonFile();
    if (set.contains(appointment)) {
      throw Exception('Duplicate Appointment');
    }
    set.add(appointment);
    _cachedDataManager.saveDataToCache(
      CachedDataType.appointments,
      jsonEncode(
        set.toList(),
      ),
    );
  }

  @override
  Future<List<AppointmentModel>> getUserAppointmentList(int userId) async {
    UserModel user = await _getUserFromJsonFile();
    List<DoctorModel> doctorsList = await _getDoctorListFromJsonFile();
    List<AppointmentModel> list = (await _getAppointmentListFromJsonFile())
        .map((_AppointmentFileModel e) {
      return AppointmentModel(
          user: user,
          doctor: doctorsList.firstWhere(
            (element) => (element.id == e.doctor),
          ),
          time: e.time);
    }).toList();
    return list;
  }

  Future<Set<_AppointmentFileModel>> _getAppointmentListFromJsonFile() async {
    String? appointments =
        await _cachedDataManager.readCachedData(CachedDataType.appointments);
    if (appointments.isEmpty) {
      throw Exception('No Data found');
    }
    Iterable iterable = jsonDecode(appointments);

    Set<_AppointmentFileModel> set = Set.from(
      iterable.map(
        (e) => _AppointmentFileModel.fromJson(e),
      ),
    );
    return set;
  }

  Future<List<DoctorModel>> _getDoctorListFromJsonFile() async {
    String? data =
        await _cachedDataManager.readCachedData(CachedDataType.doctors);
    if (data.isEmpty) {
      throw Exception('No Data found');
    }
    Iterable iterable = jsonDecode(data);

    List<DoctorModel> list = List<DoctorModel>.from(
      iterable.map(
        (element) => DoctorModel.fromJson(element),
      ),
    );
    return list;
  }

  _getUserFromJsonFile() async {
    String? data = await _cachedDataManager.readCachedData(CachedDataType.user);
    if (data.isEmpty) {
      throw Exception('No Data found');
    }
    return UserModel.fromJson(
      jsonDecode(data),
    );
  }
}

class _AppointmentFileModel {
  int? user;
  int? doctor;
  int? time;

  _AppointmentFileModel({this.user, this.doctor, this.time});

  _AppointmentFileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    doctor = json['doctor'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['doctor'] = doctor;
    data['time'] = time;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _AppointmentFileModel &&
          runtimeType == other.runtimeType &&
          user == other.user &&
          doctor == other.doctor &&
          time == other.time;

  @override
  int get hashCode =>
      runtimeType.hashCode ^ user.hashCode ^ doctor.hashCode ^ time.hashCode;
}
