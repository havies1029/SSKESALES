import 'package:esalesapp/blocs/todo/todotimelinecrud_bloc.dart';
import 'package:esalesapp/blocs/todo/todotimelinelist_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/constance/enum_calendar_view.dart';
import 'package:esalesapp/pages/todo/calendar_app_bar.dart';
import 'package:esalesapp/pages/todo/calendar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_calendar_view/infinite_calendar_view.dart';

class TodoMain extends StatefulWidget {
  const TodoMain({super.key});

  @override
  State<TodoMain> createState() => _TodoMainState();
}

class _TodoMainState extends State<TodoMain> {
  EventsController eventsController = EventsController();
  var calendarMode = CalendarView.day;
  var darkMode = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar View',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.blue,
          primary: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(backgroundColor: Color(0xff2F2F2F)),
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.blueAccent,
        ),
      ),
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      home: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 500,
          ),
          child: Scaffold(
            appBar: CustomCalendarAppBar(
              eventsController: eventsController,
              onChangeCalendarView: (calendarMode) {
                setState(() => this.calendarMode = calendarMode);    
                context.read<TodoTimelineListBloc>().add(
                      RefreshTodoTimelineListEvent(
                        tgl1: DateTime.now(),
                        calendarView: calendarMode.name,
                      ),
                    );

              },
              onChangeDarkMode: (darkMode) =>
                  setState(() => this.darkMode = darkMode),
            ),
            body: BlocListener<TodoTimelineCrudBloc, TodoTimelineCrudState>(
              listener: (context, state) {
                if (state.isSaved && !state.hasFailure) {                 
                  context.read<TodoTimelineListBloc>().add(
                        RefreshTodoTimelineListEvent(
                          tgl1: state.record?.tglTimeline ?? DateTime.now(),
                          calendarView: calendarMode.name,
                        ),
                      );
                } else if (state.hasFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error Saving Record")),
                  );
                }
              },
              child: BlocConsumer<TodoTimelineListBloc, TodoTimelineListState>(
                builder: (context, state) {
                  return CalendarViewWidget(
                      calendarMode: calendarMode,
                      controller: eventsController,
                      darkMode: darkMode);
                },
                listener: (BuildContext context, TodoTimelineListState state) {
                  if (state.status == ListStatus.success) {
                    if (state.items.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("No Data Available")),
                      );
                    } else {
                      eventsController.updateCalendarData((calendarData) {
                        calendarData.clearAll();
                        calendarData.addEvents(state.items);
                      });
                    }
                  } else if (state.status == ListStatus.failure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error Loading Data")),
                    );
                  }
                },
                buildWhen: (previous, current) {
                  return previous.status != current.status;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loadData() {
    context.read<TodoTimelineListBloc>().add(
          RefreshTodoTimelineListEvent(
            tgl1: DateTime.now(),
            calendarView: "day",
          ),
        );
  }
}
