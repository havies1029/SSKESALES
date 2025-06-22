import 'package:flutter/material.dart';

enum CalendarView {
  day("One Day", Icons.calendar_view_day_outlined),
  month("Month", Icons.calendar_month);

  const CalendarView(
    this.text,
    this.icon,
  );

  final String text;
  final IconData icon;
}
