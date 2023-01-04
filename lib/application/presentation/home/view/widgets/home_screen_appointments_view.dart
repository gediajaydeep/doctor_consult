import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:consultations_app_test/core/utils/date_time_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../domain/appointments/entities/appointment.dart';

class HomeScreenAppointmentsView extends StatelessWidget {
  final List<Appointment> list;
  final VoidCallback seeAllClicked;
  final VoidCallback onChatClicked;

  const HomeScreenAppointmentsView(
      {super.key,
      required this.list,
      required this.seeAllClicked,
      required this.onChatClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointment Today',
                style: Theme.of(context).textTheme.headline3,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: AppTheme.appBlue),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 184,
          child: PageView(
            children: list
                .map(
                  (e) => _appointmentCard(context, e),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _appointmentCard(BuildContext context, Appointment appointment) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.appBlue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _doctorImage(appointment.doctor.image ?? ''),
                  _chatIcon(),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    appointment.doctor.name ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white),
                  ),
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(appointment.time)
                      .format('hh.mm a'),
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appointment.doctor.specialization ?? '',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(appointment.time)
                      .format('dd.MM.yyyy'),
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Colors.white.withOpacity(0.5),
                      ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  _doctorImage(String image) {
    return CircleAvatar(
      maxRadius: 24,
      backgroundColor: Colors.white.withOpacity(0.4),
      child: ClipOval(
        child: Image.network(
          image,
        ),
      ),
    );
  }

  _chatIcon() {
    return InkWell(
      onTap: onChatClicked,
      borderRadius: BorderRadius.circular(50),
      child: CircleAvatar(
        maxRadius: 24,
        backgroundColor: Colors.white.withOpacity(0.4),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(
              Icons.chat_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
