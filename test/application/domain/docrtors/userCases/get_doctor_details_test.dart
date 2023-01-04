import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/schedule.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_doctor_details.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoctorsRepository extends Mock implements DoctorsRepository {}

Doctor tDoctor = _getTestDoctorDetails();

main() {
  late MockDoctorsRepository mockDoctorsRepository;
  late GetDoctorDetails useCase;

  setUp(() {
    mockDoctorsRepository = MockDoctorsRepository();
    useCase = GetDoctorDetails(mockDoctorsRepository);
  });

  test(
      'Should call getDoctorDetails with correct parameters from repository when executed',
      () async {
    await useCase.execute(
      const DoctorDetailsRequest(id: 1),
    );
    verify(
      () => mockDoctorsRepository.getDoctorDetails(1),
    ).called(1);
  });

  test(
      'Should return correct doctor details if it is loaded successfully from repository',
      () async {
    when(
      () => mockDoctorsRepository.getDoctorDetails(1),
    ).thenAnswer(
      (invocation) async => Future.value(tDoctor),
    );

    final doctorOrFailure = await useCase.execute(
      const DoctorDetailsRequest(id: 1),
    );

    expect(
      doctorOrFailure,
      Right(tDoctor),
    );
  });

  test(
      'Should return correct Failure if repository throws error loading doctor details',
      () async {
    Exception mockException = Exception('mock error');
    Failure tFailure = Failure(
      error: mockException.toString(),
    );
    when(
      () => mockDoctorsRepository.getDoctorDetails(1),
    ).thenThrow(mockException);

    final doctorOrFailure = await useCase.execute(
      const DoctorDetailsRequest(id: 1),
    );

    expect(
      doctorOrFailure,
      Left(tFailure),
    );
  });
}

Doctor _getTestDoctorDetails() {
  return Doctor(
    id: 1,
    name: 'Doctor 1',
    specialization: 'Specialization 1',
    totalReviews: 100,
    totalPatients: 500,
    ratings: 5.0,
    image: 'testImage',
    experience: 10,
    description: 'Test Description',
    schedule: Schedule(
      sunday: null,
      monday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
      tuesday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
      wednesday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
      thursday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
      friday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
      saturday: Day(
        availableSlots: [9, 10, 11, 12],
      ),
    ),
  );
}
