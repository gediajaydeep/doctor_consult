import 'package:consultations_app_test/application/domain/appointments/useCases/get_appointment_list.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_top_doctors_list.dart';
import 'package:consultations_app_test/application/domain/user/useCases/get_user_details.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/appointments/entities/appointment.dart';
import '../../../domain/user/entities/user.dart';

class HomeViewModel extends ChangeNotifier {
  final GetUserDetails _getUserDetails;
  final GetAppointmentList _getAppointmentList;
  final GetTopDoctorsList _getTopDoctorsList;

  late bool loading;
  User? userDetails;
  List<Appointment>? currentAppointments;
  List<Doctor>? topDoctors;
  String? error;

  HomeViewModel(
      {required GetUserDetails getUserDetails,
      required GetAppointmentList getAppointmentList,
      required GetTopDoctorsList getTopDoctorsList})
      : _getUserDetails = getUserDetails,
        _getAppointmentList = getAppointmentList,
        _getTopDoctorsList = getTopDoctorsList {
    loading = true;
  }

  Future<void> init() async {
    if (await _loadUserDetails()) {
      _loadUserAppointments();
      _loadTopDoctors();
    }
  }

  _loadUserDetails() async {
    Either<Failure, User> userOrFailure = await _getUserDetails.execute(
      const UserDetailsRequest(userId: 1),
    );
    userOrFailure.fold(
      (l) => _setError(l),
      (r) => _setUser(r),
    );
    bool success = userOrFailure.isRight();
    return success;
  }

  _setError(Failure failure) {
    loading = false;
    error = failure.getMessage();
    notifyListeners();
  }

  _setUser(User user) {
    loading = false;
    userDetails = user;
    notifyListeners();
  }

  Future<void> _loadUserAppointments() async {
    AppointmentListRequest request =
        AppointmentListRequest(userId: userDetails!.id);
    Either<Failure, List<Appointment>> failureOrAppointments =
        await _getAppointmentList.execute(request);

    failureOrAppointments.fold(
      (l) => _setError(l),
      (r) => _setAppointmentList(r),
    );
  }

  Future<void> _loadTopDoctors() async {
    Either<Failure, List<Doctor>> failureOrTopDoctors =
        await _getTopDoctorsList.execute(
      const EmptyRequest(),
    );
    failureOrTopDoctors.fold(
      (l) => _setError(l),
      (r) => _setTopDoctorsList(r),
    );
  }

  _setAppointmentList(List<Appointment> appointmentList) {
    loading = false;
    currentAppointments = appointmentList;
    notifyListeners();
  }

  _setTopDoctorsList(List<Doctor> topDoctorsList) {
    loading = false;
    topDoctors = topDoctorsList;
    notifyListeners();
  }
}
