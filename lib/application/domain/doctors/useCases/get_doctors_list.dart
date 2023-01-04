import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';

class GetDoctorsList extends UseCase<EmptyRequest, List<Doctor>> {
  final DoctorsRepository _doctorsRepository;

  GetDoctorsList(DoctorsRepository doctorsRepository)
      : _doctorsRepository = doctorsRepository;

  @override
  Future<Either<Failure, List<Doctor>>> execute(EmptyRequest request) async {
    try {
      return Right(
        await _doctorsRepository.getDoctorsList(),
      );
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
      ));
    }
  }
}
