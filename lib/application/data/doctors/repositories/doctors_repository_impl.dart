import 'package:consultations_app_test/application/data/doctors/dataSources/doctors_local_data_source.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';

class DoctorsRepositoryImpl extends DoctorsRepository {
  final DoctorsLocalDataSource _localDataSource;

  DoctorsRepositoryImpl({required DoctorsLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Doctor> getDoctorDetails(int id) async {
    return (await _localDataSource.getDoctorDetails(id)).toDoctor();
  }

  @override
  Future<List<Doctor>> getDoctorsList() async {
    return (await _localDataSource.getDoctorsList())
        .map(
          (e) => e.toDoctor(),
        )
        .toList();
  }

  @override
  Future<List<Doctor>> getTopDoctorsList() async {
    return (await _localDataSource.getTopDoctorsList())
        .map(
          (e) => e.toDoctor(),
        )
        .toList();
  }
}
