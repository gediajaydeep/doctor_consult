import 'package:consultations_app_test/application/domain/doctors/entities/doctor.dart';
import 'package:consultations_app_test/application/domain/doctors/entities/schedule.dart';

class DoctorModel {
  int? id;
  String? name;
  String? specialization;
  int? totalReviews;
  double? ratings;
  String? image;
  String? description;
  int? experience;
  int? totalPatients;
  ScheduleModel? schedule;

  DoctorModel({
    this.id,
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

  DoctorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String?;
    specialization = json['specialization'] as String?;
    totalReviews = (json['totalReviews'] as num?)?.toInt();
    ratings = (json['ratings'] as num?)?.toDouble();
    image = json['image'] as String?;
    description = json['description'] as String?;
    experience = (json['experience'] as int?)?.toInt();
    totalPatients = (json['totalPatients'] as int?)?.toInt();
    schedule = (json['schedule'] as Map<String, dynamic>?) != null
        ? ScheduleModel.fromJson(json['schedule'] as Map<String, dynamic>)
        : null;
  }

  Doctor toDoctor() {
    return Doctor(
      id: id!,
      name: name,
      description: description,
      experience: experience,
      image: image,
      ratings: ratings,
      specialization: specialization,
      totalPatients: totalPatients,
      totalReviews: totalReviews,
      schedule: schedule?.getSchedule(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['specialization'] = specialization;
    json['totalReviews'] = totalReviews;
    json['ratings'] = ratings;
    json['image'] = image;
    json['description'] = description;
    json['experience'] = experience;
    json['totalPatients'] = totalPatients;
    json['schedule'] = schedule?.toJson();
    return json;
  }

  @override
  String toString() {
    return 'id : $id, name : $name , ratings : $ratings';
  }
}

class ScheduleModel {
  DayModel? sunday;
  DayModel? monday;
  DayModel? tuesday;
  DayModel? wednesday;
  DayModel? thursday;
  DayModel? friday;
  DayModel? saturday;

  ScheduleModel({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  Schedule getSchedule() {
    return Schedule(
      sunday: sunday?.getDay(),
      monday: monday?.getDay(),
      tuesday: tuesday?.getDay(),
      wednesday: wednesday?.getDay(),
      thursday: thursday?.getDay(),
      friday: friday?.getDay(),
      saturday: saturday?.getDay(),
    );
  }

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    sunday = (json['sunday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['sunday'] as Map<String, dynamic>)
        : null;
    monday = (json['monday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['monday'] as Map<String, dynamic>)
        : null;
    tuesday = (json['tuesday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['tuesday'] as Map<String, dynamic>)
        : null;
    wednesday = (json['wednesday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['wednesday'] as Map<String, dynamic>)
        : null;
    thursday = (json['thursday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['thursday'] as Map<String, dynamic>)
        : null;
    friday = (json['friday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['friday'] as Map<String, dynamic>)
        : null;
    saturday = (json['saturday'] as Map<String, dynamic>?) != null
        ? DayModel.fromJson(json['saturday'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['sunday'] = sunday?.toJson();
    json['monday'] = monday?.toJson();
    json['tuesday'] = tuesday?.toJson();
    json['wednesday'] = wednesday?.toJson();
    json['thursday'] = thursday?.toJson();
    json['friday'] = friday?.toJson();
    json['saturday'] = saturday?.toJson();
    return json;
  }
}

class DayModel {
  List<int>? availableSlots;

  DayModel({
    this.availableSlots,
  });

  Day getDay() {
    return Day(availableSlots: availableSlots);
  }

  DayModel.fromJson(Map<String, dynamic> json) {
    availableSlots = (json['availableSlots'] as List?)
        ?.map((dynamic e) => e as int)
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['availableSlots'] = availableSlots;
    return json;
  }
}
