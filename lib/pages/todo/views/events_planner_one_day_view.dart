import 'package:esalesapp/blocs/todo/todotimelinelist_bloc.dart';
import 'package:esalesapp/pages/todo/todotimelinecrud_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsPlannerOneDayView extends StatefulWidget {
  const EventsPlannerOneDayView({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  final EventsController controller;
  final bool isDarkMode;

  @override
  State<EventsPlannerOneDayView> createState() =>
      _EventsPlannerOneDayViewState();
}

class _EventsPlannerOneDayViewState extends State<EventsPlannerOneDayView> {
  GlobalKey<EventsPlannerState> oneDayViewKey = GlobalKey<EventsPlannerState>();
  late DateTime selectedDay;

  @override
  void initState() {
    super.initState();
    selectedDay = widget.controller.focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    var heightPerMinute = 1.0;
    var initialVerticalScrollOffset = heightPerMinute * 7 * 60;

    return Column(
      children: [
        const SizedBox(height: 8.0),
        tableCalendar(),
        const SizedBox(height: 4.0),
        Divider(
          color: Theme.of(context).colorScheme.outlineVariant,
          height: 2,
        ),
        Expanded(
          child: EventsPlanner(
            key: oneDayViewKey,
            controller: widget.controller,
            daysShowed: 1,
            heightPerMinute: heightPerMinute,
            initialVerticalScrollOffset: initialVerticalScrollOffset,
            horizontalScrollPhysics: const PageScrollPhysics(),
            daysHeaderParam: DaysHeaderParam(
              daysHeaderVisibility: false,
              dayHeaderTextBuilder: (day) => DateFormat("E d").format(day),
            ),
            onDayChange: (firstDay) {
              setState(() {
                selectedDay = firstDay;
              });
              context.read<TodoTimelineListBloc>().add(RefreshTodoTimelineListEvent(tgl1: firstDay, calendarView: "day"));
            },
            dayParam: DayParam(
              dayEventBuilder: (event, height, width, heightPerMinute) {
                return DefaultDayEvent(
                  height: height,
                  width: width,
                  title: event.title,
                  description: event.description,
                  color: event.color,
                  textColor: event.textColor,
                  onTap: () {
                    showDialogToDoEvent(
                      context,
                      "ubah",
                      event.data.toString(),
                    );
                  },                  
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  TableCalendar tableCalendar() {
    return TableCalendar(
      firstDay: selectedDay.subtract(Duration(days: 365)),
      lastDay: selectedDay.add(Duration(days: 365)),
      focusedDay: selectedDay,
      calendarFormat: CalendarFormat.week,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
        });
        widget.controller.updateFocusedDay(selectedDay);        
        oneDayViewKey.currentState?.jumpToDate(selectedDay);
        context.read<TodoTimelineListBloc>().add(RefreshTodoTimelineListEvent(tgl1: selectedDay, calendarView: "day"));
      },
      headerVisible: false,
      weekNumbersVisible: true,
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        markerSize: 7,
        todayDecoration: BoxDecoration(
          color: Colors.blueGrey,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  void showDialogToDoEvent(BuildContext context, String viewMode, String recordId) {
		FocusScope.of(context).requestFocus(FocusNode());
		Navigator.push(
			context,
			MaterialPageRoute(builder: (context) {
				return TodoTimelineCrudMainPage(viewMode: viewMode, recordId: recordId);
			}),
		);

	}

}
