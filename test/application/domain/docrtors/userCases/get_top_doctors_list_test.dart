import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_top_doctors_list.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDoctorsRepository extends Mock implements DoctorsRepository {}

List<Doctor> tDoctorsList = _getTestDoctorsList();

main() {
  late MockDoctorsRepository mockDoctorsRepository;
  late GetTopDoctorsList useCase;

  setUp(() {
    mockDoctorsRepository = MockDoctorsRepository();
    useCase = GetTopDoctorsList(mockDoctorsRepository);
  });

  test('Should call getTopDoctorList from repository when executed', () async {
    await useCase.execute(
      const EmptyRequest(),
    );
    verify(mockDoctorsRepository.getTopDoctorsList);
  });

  test(
      'Should return correct doctors list if it is loaded successfully from repository',
      () async {
    when(
      () => mockDoctorsRepository.getTopDoctorsList(),
    ).thenAnswer(
      (invocation) async => Future.value(tDoctorsList),
    );

    final doctorsOrFailure = await useCase.execute(
      const EmptyRequest(),
    );

    expect(
      doctorsOrFailure,
      Right(tDoctorsList),
    );
  });

  test('Should return correct Failure if repository throws error loading list',
      () async {
    Exception mockException = Exception('mock error');
    Failure tFailure = Failure(
      error: mockException.toString(),
    );
    when(
      () => mockDoctorsRepository.getTopDoctorsList(),
    ).thenThrow(mockException);

    final doctorsOrFailure = await useCase.execute(
      const EmptyRequest(),
    );

    expect(
      doctorsOrFailure,
      Left(tFailure),
    );
  });
}

List<Doctor> _getTestDoctorsList() {
  return [
    const Doctor(
        id: 1,
        name: 'Doctor 1',
        specialization: 'Specialization 1',
        totalReviews: 100,
        totalPatients: 500,
        ratings: 5.0),
    const Doctor(
        id: 2,
        name: 'Doctor 2',
        specialization: 'Specialization 2',
        totalReviews: 520,
        totalPatients: 1000,
        ratings: 4.5),
    const Doctor(
        id: 3,
        name: 'Doctor 3',
        specialization: 'Specialization 3',
        totalReviews: 200,
        totalPatients: 600,
        ratings: 4.2)
  ];
}
