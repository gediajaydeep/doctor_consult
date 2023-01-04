import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';
import 'package:consultations_app_test/application/domain/appointments/useCases/get_appointment_list.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/user/entities/user.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_top_doctors_list.dart';
import 'package:consultations_app_test/application/domain/user/useCases/get_user_details.dart';
import 'package:consultations_app_test/application/presentation/home/viewModels/home_view_model.dart';
import 'package:consultations_app_test/core/errors/failure.dart';
import 'package:consultations_app_test/core/useCases/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUserDetails extends Mock implements GetUserDetails {}

class MockGetAppointmentList extends Mock implements GetAppointmentList {}

class MockGetTopDoctorsList extends Mock implements GetTopDoctorsList {}

class MockAppointmentListRequest extends Mock
    implements AppointmentListRequest {}

class MockEmptyRequest extends Mock implements EmptyRequest {}

main() {
  late MockGetUserDetails mockGetUserDetails;
  late MockGetAppointmentList mockGetAppointmentList;
  late MockGetTopDoctorsList mockGetTopDoctorsList;
  Failure commonFailure = const Failure(error: 'error');
  late HomeViewModel viewModel;
  List<Appointment> tAppointmentList = _getTestAppointmentList();
  List<Doctor> tDoctorsList = _getTestDoctorsList();

  stubGetAppointmentSuccess() {
    registerFallbackValue(
      MockAppointmentListRequest(),
    );
    when(() => mockGetAppointmentList.execute(
          any(),
        )).thenAnswer(
      (invocation) async => Right(tAppointmentList),
    );
  }

  stubGetTopDoctorsSuccess() {
    registerFallbackValue(
      MockEmptyRequest(),
    );
    when(() => mockGetTopDoctorsList.execute(
          any(),
        )).thenAnswer(
      (invocation) async => Right(tDoctorsList),
    );
  }

  stubGetAppointmentFailure() {
    registerFallbackValue(
      MockAppointmentListRequest(),
    );
    when(() => mockGetAppointmentList.execute(
          any(),
        )).thenAnswer(
      (invocation) async => Left(commonFailure),
    );
  }

  stubGetTopDoctorsFailure() {
    registerFallbackValue(
      MockEmptyRequest(),
    );
    when(() => mockGetTopDoctorsList.execute(
          any(),
        )).thenAnswer(
      (invocation) async => Left(commonFailure),
    );
  }

  setUp(() {
    mockGetTopDoctorsList = MockGetTopDoctorsList();
    mockGetAppointmentList = MockGetAppointmentList();
    mockGetUserDetails = MockGetUserDetails();
    viewModel = HomeViewModel(
        getUserDetails: mockGetUserDetails,
        getAppointmentList: mockGetAppointmentList,
        getTopDoctorsList: mockGetTopDoctorsList);
  });

  test('Initially loading is true and the other values are null ', () {
    expect(
      viewModel.loading,
      equals(true),
    );
    expect(viewModel.userDetails, isNull);
    expect(viewModel.currentAppointments, isNull);
    expect(viewModel.topDoctors, isNull);
  });

  test('init method calls GetUserDetails execute method', () {
    when(
      () => mockGetUserDetails.execute(
        const UserDetailsRequest(userId: 1),
      ),
    ).thenAnswer((invocation) async => const Right(
          User(id: 1, name: 'User'),
        ));
    stubGetAppointmentSuccess();
    stubGetTopDoctorsFailure();
    viewModel.init();
    verify(() => mockGetUserDetails.execute(
          const UserDetailsRequest(userId: 1),
        )).called(1);
  });

  group('When User Details Loaded Successfully', () {
    UserDetailsRequest userDetailsRequest = const UserDetailsRequest(userId: 1);
    AppointmentListRequest appointmentListRequest =
        const AppointmentListRequest(userId: 1);
    EmptyRequest emptyRequest = const EmptyRequest();
    User user = const User(id: 1, name: 'User');
    setUp(() {
      when(
        () => mockGetUserDetails.execute(userDetailsRequest),
      ).thenAnswer(
        (invocation) async => Right(user),
      );
    });

    test('userDetails object is loaded correctly no error shown', () async {
      stubGetAppointmentSuccess();
      stubGetTopDoctorsSuccess();
      await viewModel.init();
      expect(
        viewModel.loading,
        equals(false),
      );
      expect(
        viewModel.userDetails,
        equals(user),
      );
      expect(viewModel.error, isNull);
    });

    test(
      'GetAppointmentList and GetTopDoctors are executed',
      () async {
        stubGetAppointmentSuccess();
        stubGetTopDoctorsSuccess();
        await viewModel.init();
        verify(
          () => mockGetAppointmentList.execute(appointmentListRequest),
        ).called(1);

        verify(
          () => mockGetTopDoctorsList.execute(emptyRequest),
        ).called(1);
      },
    );

    test(
        'Appointment List and Top doctors list set correctly when GetAppointmentList  and returns correct list',
        () async {
      stubGetAppointmentSuccess();
      stubGetTopDoctorsSuccess();
      await viewModel.init();
      await Future.value();
      expect(
        viewModel.loading,
        equals(false),
      );
      expect(
        viewModel.currentAppointments,
        equals(tAppointmentList),
      );
      expect(
        viewModel.topDoctors,
        equals(tDoctorsList),
      );
    });
    test(
        'Should set error and null Appointment List  when Get Appointment list returns failure;',
        () async {
      stubGetAppointmentFailure();
      stubGetTopDoctorsSuccess();
      await viewModel.init();
      await Future.value();
      expect(
        viewModel.loading,
        equals(false),
      );
      expect(viewModel.currentAppointments, isNull);
      expect(
        viewModel.error,
        commonFailure.getMessage(),
      );
      expect(
        viewModel.topDoctors,
        equals(tDoctorsList),
      );
    });
    test(
        'Should set error and null Doctors List  when Get Top Doctor list returns failure;',
        () async {
      stubGetAppointmentSuccess();
      stubGetTopDoctorsFailure();
      await viewModel.init();
      await Future.value();
      expect(
        viewModel.loading,
        equals(false),
      );
      expect(
        viewModel.currentAppointments,
        equals(tAppointmentList),
      );
      expect(
        viewModel.error,
        commonFailure.getMessage(),
      );
      expect(viewModel.topDoctors, isNull);
    });
    test(
        'Should set error and null Doctors List and Appointment List  when Get Top Doctor list and Get Appointment list returns failure;',
        () async {
      stubGetAppointmentFailure();
      stubGetTopDoctorsFailure();
      await viewModel.init();
      await Future.value();
      expect(
        viewModel.loading,
        equals(false),
      );
      expect(viewModel.currentAppointments, isNull);
      expect(
        viewModel.error,
        commonFailure.getMessage(),
      );
      expect(viewModel.topDoctors, isNull);
    });
  });

  group('When User Details Loading Fails', () {
    setUp(() {
      UserDetailsRequest userDetailsRequest =
          const UserDetailsRequest(userId: 1);
      when(
        () => mockGetUserDetails.execute(userDetailsRequest),
      ).thenAnswer(
        (invocation) async => Left(commonFailure),
      );
    });
    test(
        'error is set and no execute called for GetTopDoctorList or GetAppointments',
        () async {
      registerFallbackValue(
        MockAppointmentListRequest(),
      );
      registerFallbackValue(
        MockEmptyRequest(),
      );
      await viewModel.init();
      expect(
        viewModel.error,
        commonFailure.getMessage(),
      );
      verifyNever(
        () => mockGetAppointmentList.execute(
          any(),
        ),
      );
      verifyNever(
        () => mockGetTopDoctorsList.execute(
          any(),
        ),
      );
    });
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

List<Appointment> _getTestAppointmentList() {
  return [
    Appointment(
        user: const User(id: 1, name: 'John'),
        doctor: const Doctor(id: 1, name: 'Test Doctor'),
        time: 1122325),
    Appointment(
        user: const User(id: 1, name: 'John'),
        doctor: const Doctor(id: 2, name: 'Test Doctor 2'),
        time: 1122326)
  ];
}
