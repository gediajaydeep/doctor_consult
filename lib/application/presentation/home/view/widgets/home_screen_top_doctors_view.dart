import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../domain/doctors/entities/doctor.dart';

class HomeScreenTopDoctorsView extends StatelessWidget {
  final List<Doctor> list;
  final VoidCallback seeAllClicked;
  final Function(Doctor) onDoctorSelected;

  const HomeScreenTopDoctorsView(
      {super.key,
      required this.list,
      required this.seeAllClicked,
      required this.onDoctorSelected});

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
                'Top Doctors for you',
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
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _TopDoctorListChild(
                doctor: list[index],
                onSelected: () {
                  onDoctorSelected(list[index]);
                });
          },
        ),
      ],
    );
  }
}

class _TopDoctorListChild extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback onSelected;

  const _TopDoctorListChild({required this.doctor, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: InkWell(
          onTap: onSelected,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    color: Colors.grey.withOpacity(0.2),
                    child: Image.network(
                      doctor.image ?? '',
                      height: 72,
                      width: 72,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor.specialization ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: AppTheme.greyDark),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(doctor.name ?? '',
                            style: Theme.of(context).textTheme.headline3),
                        const SizedBox(
                          height: 4,
                        ),
                        _reviews(context, doctor.ratings, doctor.totalReviews),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _reviews(BuildContext context, double? ratings, int? totalReviews) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Icon(
          Icons.star,
          size: 10,
          color: Colors.yellow,
        ),
        const SizedBox(
          width: 4,
        ),
        Text((ratings ?? 0).toStringAsFixed(1),
            style: Theme.of(context).textTheme.headline6),
        const SizedBox(
          width: 8,
        ),
        Text('• ${doctor.totalReviews ?? 0} Reviews',
            style: Theme.of(context).textTheme.headline6)
      ],
    );
  }
}
