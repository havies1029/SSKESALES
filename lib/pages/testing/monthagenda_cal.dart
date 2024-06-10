import 'dart:math';

import 'package:esalesapp/blocs/calendar/eventrenewalcari_bloc.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';
import 'package:esalesapp/models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthAgendaPage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const MonthAgendaPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  MonthAgendaPageState createState() => MonthAgendaPageState();
}

class MonthAgendaPageState extends State<MonthAgendaPage> {
  late _MeetingDataSource _events;
  final CalendarController _calendarController = CalendarController();  
  late SampleModel model;
  late EventRenewalCariBloc cariBloc;

  @override
  void initState() {
    model = SampleModel.instance;
    _calendarController.selectedDate = DateTime.now();    
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {      
      //_events = _MeetingDataSource(_getAppointments());
    });
  }


  @override
  Widget build(BuildContext context) {
    cariBloc = context.read<EventRenewalCariBloc>();
    
    return BlocConsumer<EventRenewalCariBloc, EventRenewalCariState>(
      builder: (context, state) {
        return state.items.isNotEmpty ? 
          Container(
            color: model.sampleOutputCardColor,
            child: _getAgendaViewCalendar(_onViewChanged, _calendarController),
            //child: Container()
          ): const LoadingIndicator();
      },
      listener: (BuildContext context, EventRenewalCariState state) {
      },
    );
  }

  List<EventRenewalModel> _getAppointments() {
    List<EventRenewalModel> data = cariBloc.state.items;

    final List<String> subjectCollection = <String>[];
    subjectCollection.add('General Meeting');
    subjectCollection.add('Plan Execution');
    subjectCollection.add('Project Plan');
    subjectCollection.add('Consulting');
    subjectCollection.add('Support');
    subjectCollection.add('Development Meeting');
    subjectCollection.add('Scrum');
    subjectCollection.add('Project Completion');
    subjectCollection.add('Release updates');
    subjectCollection.add('Performance Check');

    /// Creates the required appointment color details as a list.
    final List<Color> colorCollection = <Color>[];
    colorCollection.add(const Color(0xFF0F8644));
    colorCollection.add(const Color(0xFF8B1FA9));
    colorCollection.add(const Color(0xFFD20100));
    colorCollection.add(const Color(0xFFFC571D));
    colorCollection.add(const Color(0xFF36B37B));
    colorCollection.add(const Color(0xFF01A1EF));
    colorCollection.add(const Color(0xFF3D4FB5));
    colorCollection.add(const Color(0xFFE47C73));
    colorCollection.add(const Color(0xFF636363));
    colorCollection.add(const Color(0xFF0A8043));

    final List<EventRenewalModel> meetings = <EventRenewalModel>[];
    final Random random = Random();

    for (EventRenewalModel e in data) {
      meetings.add(EventRenewalModel(
        eventName: e.eventName,
        eventFrom: e.eventFrom,
        eventTo: e.eventTo,
        sppaNo: e.sppaNo,
        theInsured: e.theInsured,
        polisStart: e.polisStart,
        polisEnd: e.polisEnd,
        premi: e.premi,
        cobNama: e.cobNama,
        curr: e.curr,
        background: colorCollection[random.nextInt(9)],
      ));
    }

    return meetings;
  }

  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final DateTime currentViewDate = visibleDatesChangedDetails
          .visibleDates[visibleDatesChangedDetails.visibleDates.length ~/ 2];
      if (model.isWebFullView) {
        if (DateTime.now()
                .isAfter(visibleDatesChangedDetails.visibleDates[0]) &&
            DateTime.now().isBefore(visibleDatesChangedDetails.visibleDates[
                visibleDatesChangedDetails.visibleDates.length - 1])) {
          _calendarController.selectedDate = DateTime.now();
        } else {
          _calendarController.selectedDate =
              visibleDatesChangedDetails.visibleDates[0];
        }
      } else {
        if (currentViewDate.month == DateTime.now().month &&
            currentViewDate.year == DateTime.now().year) {
          _calendarController.selectedDate = DateTime.now();
        } else {
          _calendarController.selectedDate =
              DateTime(currentViewDate.year, currentViewDate.month);
        }
      }
    });
  }

  SfCalendar _getAgendaViewCalendar(
      [ViewChangedCallback? onViewChanged,
      CalendarController? controller]) {
        _events = _MeetingDataSource(_getAppointments());
    return SfCalendar(
      view: CalendarView.month,
      controller: controller,
      showDatePickerButton: true,
      showNavigationArrow: model.isWebFullView,
      onViewChanged: onViewChanged,
      dataSource: _events,
      monthViewSettings: MonthViewSettings(
          showAgenda: true, numberOfWeeksInView: model.isWebFullView ? 2 : 6),
      timeSlotViewSettings: const TimeSlotViewSettings(
          minimumAppointmentDuration: Duration(minutes: 60)),
      appointmentBuilder: appointmentBuilder,
    );
  }
}

Widget appointmentBuilder(BuildContext context,
    CalendarAppointmentDetails calendarAppointmentDetails) {
  final EventRenewalModel appointment =
      calendarAppointmentDetails.appointments.first;
  return Container(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        /*
            gradient: const LinearGradient(
                colors: [Colors.red, Colors.cyan],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft)
            */
      ),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(appointment.sppaNo,
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(" ${appointment.cobNama} ",
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ),
            ],
          ),
          Text(appointment.theInsured,
              textAlign: TextAlign.left,
              maxLines: 1,
              style: const TextStyle(
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12)),
          Row(
            children: [
              Text(
                  '${DateFormat('dd/MM/yyyy').format(appointment.polisStart)} - ${DateFormat('dd/MM/yyyy').format(appointment.polisEnd)}',
                  textAlign: TextAlign.left,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              Text(
                  "${appointment.curr} ${NumberFormat("#,###").format(appointment.premi)}",
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12)),
            ],
          ),
        ],
      ));
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<EventRenewalModel> source;

  @override
  List<EventRenewalModel> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].eventFrom;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].eventTo;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  String? getStartTimeZone(int index) {
    return null;
  }

  @override
  String? getEndTimeZone(int index) {
    return null;
  }

  @override
  Color getColor(int index) {
    return source[index].background ?? Colors.green;
  }

  @override
  String? getRecurrenceRule(int index) {
    return null;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class _Meetingx {
  _Meetingx(
      this.eventName,
      this.organizer,
      this.contactID,
      this.capacity,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.startTimeZone,
      this.endTimeZone,
      this.recurrenceRule);

  String eventName;
  String? organizer;
  String? contactID;
  int? capacity;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String? startTimeZone;
  String? endTimeZone;
  String? recurrenceRule;
}
