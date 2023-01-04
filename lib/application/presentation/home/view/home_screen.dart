import 'package:consultations_app_test/application/domain/appointments/entities/appointment.dart';
import 'package:consultations_app_test/application/domain/appointments/repositories/appointments_repository.dart';
import 'package:consultations_app_test/application/domain/appointments/useCases/create_appointment.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/repositories/doctors_repository.dart';
import 'package:consultations_app_test/application/domain/doctors/useCases/get_doctor_details.dart';
import 'package:consultations_app_test/application/domain/user/entities/user.dart';
import 'package:consultations_app_test/application/presentation/doctors/details/viewModels/doctor_details_view_model.dart';
import 'package:consultations_app_test/application/presentation/doctors/details/viewModels/view/doctor_details_screen.dart';
import 'package:consultations_app_test/application/presentation/home/view/widgets/home_screen_appointments_view.dart';
import 'package:consultations_app_test/application/presentation/home/view/widgets/home_screen_features_view.dart';
import 'package:consultations_app_test/application/presentation/home/view/widgets/home_screen_search_bar.dart';
import 'package:consultations_app_test/application/presentation/home/view/widgets/home_screen_top_doctors_view.dart';
import 'package:consultations_app_test/application/presentation/home/view/widgets/home_user_greeting_view.dart';
import 'package:consultations_app_test/application/presentation/home/viewModels/home_view_model.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onOpenChatScreen;

  const HomeScreen({super.key, required this.onOpenChatScreen});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<HomeViewModel>().init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Selector<HomeViewModel, User?>(
              selector: (_, viewModel) => viewModel.userDetails,
              builder: (context, value, child) {
                if (value == null) {
                  return const SizedBox();
                }
                return HomeUserGreetingView(user: value);
              },
            ),
          ),
          SliverAppBar(
            pinned: true,
            titleSpacing: 12,
            toolbarHeight: 68,
            backgroundColor: AppTheme.scaffoldBackgroundColor,
            title: HomeScreenSearchBar(
              onSearchChanged: (searchText) {},
            ),
          ),
          SliverToBoxAdapter(
            child: HomeScreenFeaturesView(
              onSelected: (feature) {},
            ),
          ),
          Selector<HomeViewModel, bool>(
            builder: (context, value, child) {
              if (value) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            },
            selector: (_, viewModel) => viewModel.loading,
          ),
          SliverToBoxAdapter(
            child: Selector<HomeViewModel, List<Appointment>?>(
              builder: (context, value, child) {
                if (value == null || value.isEmpty) {
                  return const SizedBox();
                }
                return HomeScreenAppointmentsView(
                  list: value,
                  seeAllClicked: () {},
                  onChatClicked: () {
                    widget.onOpenChatScreen();
                  },
                );
                // return
              },
              selector: (_, viewModel) => viewModel.currentAppointments,
            ),
          ),
          Selector<HomeViewModel, List<Doctor>?>(
            selector: (_, viewModel) => viewModel.topDoctors,
            builder: (context, value, child) {
              if (value == null || value.isEmpty) {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              }
              return SliverToBoxAdapter(
                child: HomeScreenTopDoctorsView(
                  list: value,
                  seeAllClicked: () {},
                  onDoctorSelected: (doctor) {
                    _openDoctorDetailsScreen(doctor);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future<void> _openDoctorDetailsScreen(Doctor doctor) async {
    HomeViewModel viewModel = context.read<HomeViewModel>();
    DoctorsRepository doctorsRepository = context.read<DoctorsRepository>();
    AppointmentsRepository appointmentsRepository =
        context.read<AppointmentsRepository>();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            Provider<GetDoctorDetails>(
              create: (context) => GetDoctorDetails(
                doctorsRepository,
              ),
            ),
            Provider<CreateAppointment>(
              create: (context) => CreateAppointment(
                appointmentsRepository: appointmentsRepository,
              ),
            ),
            ChangeNotifierProvider<DoctorDetailsViewModel>(
              create: (context) => DoctorDetailsViewModel(
                getDoctorDetails: context.read<GetDoctorDetails>(),
                createAppointment: context.read<CreateAppointment>(),
              ),
            )
          ],
          child: DoctorDetailsScreen(doctorId: doctor.id),
        ),
      ),
    );
    viewModel.init();
  }
}
