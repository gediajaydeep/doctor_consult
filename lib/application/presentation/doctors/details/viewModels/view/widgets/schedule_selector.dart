import 'package:consultations_app_test/core/theme/app_theme.dart';
import 'package:consultations_app_test/core/utils/date_time_extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleSelector extends StatefulWidget {
  final List<ScheduleItem> scheduleList;
  final Function(int?) onSelectionChanged;

  const ScheduleSelector(
      {super.key,
      required this.scheduleList,
      required this.onSelectionChanged});

  @override
  State<StatefulWidget> createState() {
    return _ScheduleSelectorState();
  }
}

class _ScheduleSelectorState extends State<ScheduleSelector> {
  late ScheduleItem selectedDay;
  int? selectedHour;

  @override
  void initState() {
    selectedDay = widget.scheduleList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildScheduleDayList(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Time',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        _buildScheduleTimeSlotList(),
      ],
    );
  }

  _buildScheduleDayList() {
    return SizedBox(
      height: 98,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.scheduleList.length,
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        itemBuilder: (context, index) =>
            _daySelectionItem(widget.scheduleList[index]),
      ),
    );
  }

  _buildScheduleTimeSlotList() {
    return SizedBox(
      height: 64,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: selectedDay.slots.length,
        padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
        itemBuilder: (context, index) =>
            _slotSelectionItem(selectedDay.slots[index]),
      ),
    );
  }

  _daySelectionItem(ScheduleItem scheduleItem) {
    bool selected = selectedDay == scheduleItem;
    Color backgroundColor =
        selected ? AppTheme.appBlue : AppTheme.blueExtraLight;
    Color dayTextColor = selected ? Colors.white : Colors.black;
    Color weekDayTextColor = selected ? Colors.white : AppTheme.greyDark;
    EdgeInsets contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    double elevation = selected ? 8 : 0;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          _selectDay(scheduleItem);
        },
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          elevation: elevation,
          child: Padding(
            padding: contentPadding,
            child: Column(
              children: [
                Text(
                  scheduleItem.weekDay,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: weekDayTextColor),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  NumberFormat("00").format(scheduleItem.day),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: dayTextColor),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDay(ScheduleItem scheduleItem) {
    if (selectedDay != scheduleItem) {
      setState(() {
        selectedDay = scheduleItem;
        selectedHour = null;
      });
      widget.onSelectionChanged(null);
    }
  }

  _slotSelectionItem(int slot) {
    bool selected = selectedHour != null && selectedHour == slot;
    Color backgroundColor =
        selected ? AppTheme.appBlue : AppTheme.blueExtraLight;
    Color textColor = selected ? Colors.white : Colors.black;
    EdgeInsets contentPadding =
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12);
    double elevation = selected ? 8 : 0;

    String hour = DateTime(selectedDay.year, 1, 1, slot).format('hh.mm a');

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          _selectSlot(slot);
        },
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          elevation: elevation,
          child: Padding(
            padding: contentPadding,
            child: Text(
              hour,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }

  void _selectSlot(int slot) {
    if (slot != selectedHour) {
      setState(() {
        selectedHour = slot;
      });
      widget.onSelectionChanged(DateTime(selectedDay.year, selectedDay.month,
              selectedDay.day, selectedHour!)
          .millisecondsSinceEpoch);
    }
  }
}

class ScheduleItem extends Equatable {
  final int day;
  final int month;
  final int year;
  final String weekDay;
  final List<int> slots;

  const ScheduleItem(
      {required this.day,
      required this.month,
      required this.year,
      required this.weekDay,
      required this.slots});

  @override
  List<Object?> get props => [day, month, year, weekDay, slots];
}
