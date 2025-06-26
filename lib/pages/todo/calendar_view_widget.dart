
import 'package:esalesapp/constance/enum_calendar_view.dart';
import 'package:esalesapp/pages/todo/views/events_months_view.dart';
import 'package:esalesapp/pages/todo/views/events_planner_one_day_view.dart';
import 'package:flutter/material.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';

class CalendarViewWidget extends StatelessWidget {
  const CalendarViewWidget({
    super.key,
    required this.calendarMode,
    required this.controller,
    required this.darkMode,
  });

  final CalendarView calendarMode;
  final EventsController controller;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return switch (calendarMode) {      
      CalendarView.day => EventsPlannerOneDayView(
          key: UniqueKey(),
          controller: controller,
          isDarkMode: darkMode,
        ),      
      CalendarView.month => EventsMonthsView(
          controller: controller,
        ),
    };
  }
}
