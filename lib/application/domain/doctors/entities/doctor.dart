import 'package:consultations_app_test/application/domain/doctors/entities/schedule.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  const Doctor({
    required this.id,
    this.name,
    this.specialization,
    this.totalReviews,
    this.ratings,
    this.image,
    this.description,
    this.experience,
    this.totalPatients,
    this.schedule,
  });

  final int id;
  final String? name;
  final String? specialization;
  final int? totalReviews;
  final double? ratings;
  final String? image;
  final String? description;
  final int? experience;
  final int? totalPatients;
  final Schedule? schedule;

  @override
  List<Object?> get props => [
        id,
        name,
        specialization,
        totalReviews,
        ratings,
        image,
        description,
        experience,
        totalPatients,
        schedule
      ];
}
