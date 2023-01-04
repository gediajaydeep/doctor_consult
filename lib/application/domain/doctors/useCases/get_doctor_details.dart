import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetDoctorDetails extends UseCase<DoctorDetailsRequest, Doctor> {
  final DoctorsRepository _doctorsRepository;

  GetDoctorDetails(DoctorsRepository doctorsRepository)
      : _doctorsRepository = doctorsRepository;

  @override
  Future<Either<Failure, Doctor>> execute(DoctorDetailsRequest request) async {
    try {
      return Right(
        await _doctorsRepository.getDoctorDetails(request.id),
      );
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
      ));
    }
  }
}

class DoctorDetailsRequest extends Equatable {
  final int id;

  const DoctorDetailsRequest({required this.id});

  @override
  List<Object?> get props => [id];
}
