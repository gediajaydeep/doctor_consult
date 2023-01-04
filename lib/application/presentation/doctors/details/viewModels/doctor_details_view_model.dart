import 'package:consultations_app_test/application/domain/appointments/useCases/create_appointment.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_doctor_details.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:flutter/foundation.dart';

import '../../../../domain/doctors/entities/doctor.dart';

class DoctorDetailsViewModel extends ChangeNotifier {
  final GetDoctorDetails _getDoctorDetails;
  final CreateAppointment _createAppointment;

  late bool isCreatingAppointment;
  late bool isLoadingDetails;
  bool isAppointmentCreatedSuccessfully = false;
  late int _doctorId;

  Doctor? doctorDetails;
  String? error;

  int? selectedTime;

  DoctorDetailsViewModel(
      {required GetDoctorDetails getDoctorDetails,
      required CreateAppointment createAppointment})
      : _getDoctorDetails = getDoctorDetails,
        _createAppointment = createAppointment {
    isCreatingAppointment = false;
    isLoadingDetails = true;
  }

  init(int doctorId) {
    _doctorId = doctorId;
    _loadDoctorDetails(_doctorId);
  }

  Future<void> _loadDoctorDetails(int doctorId) async {
    final failureOrDoctor = await _getDoctorDetails.execute(
      DoctorDetailsRequest(id: doctorId),
    );
    failureOrDoctor.fold(
      (l) => _setError(
        l.getMessage(),
      ),
      (r) => _setDoctor(r),
    );
  }

  _setError(String error) {
    isLoadingDetails = false;
    this.error = error;
    notifyListeners();
  }

  _setDoctor(Doctor doctor) {
    isLoadingDetails = false;
    error = null;
    doctorDetails = doctor;
    notifyListeners();
  }

  bookAppointment() async {
    if (selectedTime == null) {
      _setError('Please select a time slot');
      return;
    }
    _setCreatingAppointment();
    final failureOrAppointment = await _createAppointment.execute(
      CreateAppointmentRequest(
          userId: 1, doctorId: _doctorId, time: selectedTime!),
    );

    failureOrAppointment.fold(
      (l) => _setCreatingAppointmentError(l),
      (r) => _setCreatingAppointmentSuccess(),
    );
  }

  _setCreatingAppointment() {
    error = null;
    isCreatingAppointment = true;
    notifyListeners();
  }

  _setCreatingAppointmentSuccess() {
    error = null;
    isCreatingAppointment = false;
    isAppointmentCreatedSuccessfully = true;
    notifyListeners();
  }

  _setCreatingAppointmentError(Failure e) {
    isCreatingAppointment = false;
    error = e.getMessage();
    notifyListeners();
  }
}
