import 'package:esalesapp/blocs/calendar/eventrenewalcari_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class RenewalEventPage extends StatefulWidget {  
  const RenewalEventPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RenewalEventPageState createState() => _RenewalEventPageState();
}

class _RenewalEventPageState extends State<RenewalEventPage> {
  late EventRenewalCariBloc cariBloc;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadDataEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    cariBloc = context.read<EventRenewalCariBloc>();
    return BlocConsumer<EventRenewalCariBloc, EventRenewalCariState>(
      builder: (context, state) {
        return state.items.isNotEmpty
            ? Scaffold(
                body: SfCalendar(
                view: CalendarView.schedule,
                //dataSource: MeetingDataSource(_getDataSource()),
                dataSource: MeetingDataSource(getEventRenewal(state.items)),
                scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
                appointmentBuilder: appointmentBuilder,

                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
                /*
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          */
              ))
            : const LoadingIndicator();
      },
      listener: (BuildContext context, EventRenewalCariState state) {},
      buildWhen: (previous, current) {
        debugPrint("buildWhen current.status : ${current.status}");
        return (current.status == ListStatus.success);
      },
    );
  }

  void loadDataEvent() {
    //cariBloc.add(RefreshEventRenewalCariEvent());
  }

  List<EventRenewalModel> getEventRenewal(List<EventRenewalModel> data) {
    debugPrint("getEventRenewal");

    final List<EventRenewalModel> meetings = <EventRenewalModel>[];

    for(EventRenewalModel e in data){
      debugPrint("e.eventName : ${e.eventName}");
      debugPrint("e.eventFrom : ${e.eventFrom}");
      debugPrint("e.eventTo : ${e.eventTo}");
      debugPrint("e.sppaNo : ${e.sppaNo}");
      debugPrint("e.theInsured : ${e.theInsured}");
      debugPrint("e.polisStart : ${e.polisStart}");
      debugPrint("e.polisEnd : ${e.polisEnd}");
      debugPrint("e.premi : ${e.premi}");
      debugPrint("e.curr : ${e.curr}");
      
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
          curr: e.curr));
          
    }

/*

    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 5));
    meetings.add(EventRenewalModel(
      sppaNo: 'SPPA-Q-23-000030',
      theInsured: 'PT SANTOS PREMIUM KRIMER',
      polisStart: startTime,
      polisEnd: endTime,
      //background: const Color(0xFF0F8644),
      cobNama: 'PAR',
      curr: 'IDR',
      premi: 71250000, eventName: '', eventFrom: startTime, eventTo: endTime,
      //isAllDay: false
    ));
    meetings.add(EventRenewalModel(
      sppaNo: 'SPPA-Q-23-000052',
      theInsured: 'PT XYZ',
      polisStart: startTime,
      polisEnd: endTime,
      //background: const Color(0xFF0F8644),
      cobNama: 'MV',
      curr: 'IDR',
      premi: 1250000, eventName: '', eventFrom: startTime, eventTo: endTime,
      //isAllDay: false
    ));
    meetings.add(EventRenewalModel(
      sppaNo: 'SPPA-23-002657',
      theInsured: 'TATAWIRIA KOLOPAKING',      
      polisStart: DateTime(2024, 8, 3, 9),
      polisEnd: DateTime(2024, 8, 3, 11),
      //background: const Color(0xFF0F8644),
      cobNama: 'PAR',
      curr: 'IDR',
      premi: 4417800.0, eventName: '', eventFrom: startTime, eventTo: endTime,
      //isAllDay: false
    ));
    */
    return meetings;
  }

  List<EventRenewalModel> _getDataSource() {
    final List<EventRenewalModel> meetings = <EventRenewalModel>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 5));
    meetings.add(EventRenewalModel(
      sppaNo: 'SPPA-Q-23-000030',
      theInsured: 'PT SANTOS PREMIUM KRIMER',
      polisStart: startTime,
      polisEnd: endTime,
      //background: const Color(0xFF0F8644),
      cobNama: 'PAR',
      curr: 'IDR',
      premi: 71250000, eventName: '', eventFrom: startTime, eventTo: endTime,
      //isAllDay: false
    ));
    meetings.add(EventRenewalModel(
      sppaNo: 'SPPA-Q-23-000052',
      theInsured: 'PT XYZ',
      polisStart: startTime,
      polisEnd: endTime,
      //background: const Color(0xFF0F8644),
      cobNama: 'MV',
      curr: 'IDR',
      premi: 1250000, eventName: '', eventFrom: startTime, eventTo: endTime,
      //isAllDay: false
    ));
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<EventRenewalModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).eventFrom;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).eventTo;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).theInsured;
  }

  @override
  Color getColor(int index) {
    return Colors.green;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

  EventRenewalModel _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final EventRenewalModel meetingData;
    if (meeting is EventRenewalModel) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class RenewalEventx {
  String sppaNo;
  String theInsured;
  DateTime polisStart;
  DateTime polisEnd;
  String cobName;
  String curr;
  double premi;
  Color background;
  bool isAllDay;

  RenewalEventx(
      {required this.sppaNo,
      required this.theInsured,
      required this.polisStart,
      required this.polisEnd,
      required this.cobName,
      required this.curr,
      required this.premi,
      required this.background,
      required this.isAllDay});
}

Widget scheduleViewBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthDate(details.date.month);
  return Stack(
    children: <Widget>[
      Image(
          image: ExactAssetImage('assets/images/month/$monthName.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height),
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          '$monthName ${details.date.year}',
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

String _getMonthDate(int month) {
  if (month == 01) {
    return 'January';
  } else if (month == 02) {
    return 'February';
  } else if (month == 03) {
    return 'March';
  } else if (month == 04) {
    return 'April';
  } else if (month == 05) {
    return 'May';
  } else if (month == 06) {
    return 'June';
  } else if (month == 07) {
    return 'July';
  } else if (month == 08) {
    return 'August';
  } else if (month == 09) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
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
