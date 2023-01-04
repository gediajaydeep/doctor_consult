import '../entities/doctor.dart';

abstract class DoctorsRepository {
  Future<List<Doctor>> getDoctorsList();

  Future<List<Doctor>> getTopDoctorsList();

  Future<Doctor> getDoctorDetails(int id);
}
