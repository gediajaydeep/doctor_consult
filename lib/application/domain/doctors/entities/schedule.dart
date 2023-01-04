import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  const Schedule({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  final Day? sunday;
  final Day? monday;
  final Day? tuesday;
  final Day? wednesday;
  final Day? thursday;
  final Day? friday;
  final Day? saturday;

  @override
  List<Object?> get props =>
      [sunday, monday, tuesday, thursday, friday, saturday];

  List<int> getSlots(int weekDay, {int? fromHour}) {
    if (weekDay < 0 || weekDay > 6) {
      return [];
    }
    Day day = [
      sunday,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday
    ][weekDay]!;
    List<int> slots = day.availableSlots ?? [];
    slots.sort(
      (a, b) => a - b,
    );
    if (fromHour != null) {
      int index = slots.indexWhere(
        (element) => element >= fromHour,
      );
      return index == -1 ? [] : slots.sublist(index);
    }
    return slots;
  }
}

class Day {
  Day({
    this.availableSlots,
  });

  final List<int>? availableSlots;
}
