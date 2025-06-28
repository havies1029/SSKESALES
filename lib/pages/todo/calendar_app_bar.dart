import 'package:esalesapp/constance/enum_calendar_view.dart';
import 'package:esalesapp/pages/todo/todotimelinecrud_main.dart';
import 'package:flutter/material.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';
import 'package:intl/intl.dart';
export 'calendar_app_bar.dart'  show showDialogToDoEvent;

class CustomCalendarAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomCalendarAppBar({
    super.key,
    required this.eventsController,
    this.onChangeDarkMode,
    this.onChangeCalendarView,
  });

  final EventsController eventsController;
  final void Function(bool darkMode)? onChangeDarkMode;
  final void Function(CalendarView calendarMode)? onChangeCalendarView;

  @override
  State<CustomCalendarAppBar> createState() => _CustomCalendarAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(60);
}

class _CustomCalendarAppBarState extends State<CustomCalendarAppBar> {
  var calendarMode = CalendarView.day;
  var darkMode = false;
  var appBarText = "";

  @override
  void initState() {
    super.initState();
    widget.eventsController.onFocusedDayChange = (day) {
      setState(() {
        appBarText = DateFormat("MMM yyyy").format(day);
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    var color =
        darkMode ? Colors.white : Theme.of(context).colorScheme.onPrimary;
    return AppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Planning List",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color,
                ),
          ),
          Text(
            appBarText,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: color,
                ),
          ),
        ],
      ),
      scrolledUnderElevation: 0.0,
      toolbarOpacity: 1,
      elevation: 0,
      centerTitle: false,
      leading: Icon(
        Icons.today,
        color: color,
      ),
      actions: [
        /*
        // change dark mode
        IconButton(
          onPressed: () {
            setState(() {
            darkMode = !darkMode;
            widget.onChangeDarkMode?.call(darkMode);
          });
          },
          icon: Icon(
            Icons.dark_mode,
            color: color,
          ),
        ),
        */

        IconButton(
          onPressed: () {            
            showDialogToDoEvent(context, "tambah", "");
          },
          icon: Icon(
            Icons.add,
            color: color,
          ),
        ),

        // change calendar mode
        PopupMenuButton(
          icon: Icon(calendarMode.icon),
          iconColor: color,
          onSelected: (value) => setState(() {
            calendarMode = value;
            widget.onChangeCalendarView?.call(value);
          }),
          itemBuilder: (BuildContext context) {
            return CalendarView.values.map((mode) {
              return PopupMenuItem(
                value: mode,
                child: ListTile(
                  leading: Icon(mode.icon),
                  title: Text(mode.text),
                ),
              );
            }).toList();
          },
        ),
      ],
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
