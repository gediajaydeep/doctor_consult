import 'package:consultations_app_test/application/domain/doctors/entities/schedule.dart';
import 'package:consultations_app_test/application/presentation/doctors/details/viewModels/doctor_details_view_model.dart';
import 'package:consultations_app_test/application/presentation/doctors/details/viewModels/view/widgets/description_text.dart';
import 'package:consultations_app_test/application/presentation/doctors/details/viewModels/view/widgets/schedule_selector.dart';
import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:consultations_app_test/core/utils/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorDetailsScreen extends StatefulWidget {
  final int doctorId;

  const DoctorDetailsScreen({super.key, required this.doctorId});

  @override
  State<StatefulWidget> createState() {
    return _DoctorDetailsScreenState();
  }
}

class _DoctorDetailsScreenState extends State<DoctorDetailsScreen> {
  @override
  void didChangeDependencies() {
    context.read<DoctorDetailsViewModel>().init(widget.doctorId);
    _addErrorListener();
    _addAppointmentCreationListener();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                height: 132,
                color: AppTheme.appBlue,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    foregroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    leading: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      'Detail Doctor',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 120,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    )),
              ),
            ),
            Consumer<DoctorDetailsViewModel>(
              builder: (context, viewModel, child) {
                if (viewModel.isLoadingDetails) {
                  return const Positioned(
                    left: 0,
                    right: 0,
                    top: 120,
                    bottom: 0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Positioned(
                  left: 0,
                  right: 0,
                  top: 96,
                  bottom: 0,
                  child: _buildDoctorDetailsContent(context, viewModel),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildDoctorDetailsContent(
      BuildContext context, DoctorDetailsViewModel viewModel) {
    return Column(
      children: [
        Center(
          child: _doctorImage(viewModel.doctorDetails!.image ?? ''),
        ),
        Text(
          viewModel.doctorDetails!.name!,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(viewModel.doctorDetails!.specialization!,
            style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(
          height: 12,
        ),
        _experienceAndRatings(
            context,
            viewModel.doctorDetails!.totalPatients ?? 0,
            viewModel.doctorDetails!.experience ?? 0,
            viewModel.doctorDetails!.ratings ?? 0),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                _doctorDescription(
                    context, viewModel.doctorDetails!.description),
                const SizedBox(
                  height: 16,
                ),
                _scheduleSelectionView(viewModel.doctorDetails?.schedule,
                    (selectedTime) {
                  viewModel.selectedTime = selectedTime;
                }),
                const SizedBox(
                  height: 16,
                ),
                _bookAppointmentButton(
                    viewModel.isCreatingAppointment, viewModel.bookAppointment),
              ],
            ),
          ),
        )
      ],
    );
  }

  _doctorImage(String image) {
    return SizedBox(
      height: 78,
      width: 78,
      child: CircleAvatar(
        backgroundColor: AppTheme.scaffoldBackgroundColor,
        child: ClipOval(
          child: Image.network(image),
        ),
      ),
    );
  }

  _experienceAndRatings(
      BuildContext context, int patients, int experience, double ratings) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 66,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppTheme.blueExtraLight),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: _expAndRatingDetailColumn(
                  context,
                  'Patients',
                  patients.toString(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: VerticalDivider(
                  thickness: 0.5,
                  color: AppTheme.greyLight,
                ),
              ),
              Expanded(
                child: _expAndRatingDetailColumn(
                  context,
                  'Experience',
                  '$experience \u1d67\u1d63\u209b',
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: VerticalDivider(
                  thickness: 0.5,
                  color: AppTheme.greyLight,
                ),
              ),
              Expanded(
                child: _expAndRatingDetailColumn(
                  context,
                  'Rating',
                  ratings.toStringAsFixed(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _expAndRatingDetailColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: AppTheme.greyLight),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: AppTheme.appBlue),
        )
      ],
    );
  }

  _doctorDescription(BuildContext context, String? description) {
    if (description == null || description.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Doctor',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
          const SizedBox(
            height: 12,
          ),
          DescriptionText(text: description),
        ],
      ),
    );
  }

  _scheduleSelectionView(Schedule? schedule, Function(int?) selectionChanged) {
    if (schedule == null) return const SizedBox();

    DateTime today = DateTime.now();

    List<DateTime> dateList = List.generate(
        7,
        (i) => today.add(
              Duration(days: i),
            ));
    List<ScheduleItem>? scheduleList = dateList.map((date) {
      return ScheduleItem(
        day: date.day,
        month: date.month,
        year: date.year,
        weekDay: date.format('EEE'),
        slots: schedule.getSlots(date.weekday,
            fromHour: (date.day == today.day) ? date.hour + 1 : null),
      );
    }).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Select Schedule',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        ScheduleSelector(
          scheduleList: scheduleList,
          onSelectionChanged: selectionChanged,
        ),
      ],
    );
  }

  _bookAppointmentButton(
    bool isCreatingAppointment,
    Function bookAppointment,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isCreatingAppointment
              ? null
              : () {
                  bookAppointment();
                },
          child:
              Text(isCreatingAppointment ? 'Booking Appointment...' : 'Book'),
        ),
      ),
    );
  }

  void _addErrorListener() {
    context.read<DoctorDetailsViewModel>().addListener(_errorListener);
  }

  void _errorListener() {
    String? error = context.read<DoctorDetailsViewModel>().error;
    if (error != null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[600],
            content: Text(error),
          ),
        );
    }
  }

  void _addAppointmentCreationListener() {
    context.read<DoctorDetailsViewModel>().addListener(_successListener);
  }

  void _successListener() {
    bool success =
        context.read<DoctorDetailsViewModel>().isAppointmentCreatedSuccessfully;
    if (success) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        Navigator.of(context).pop(true);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
