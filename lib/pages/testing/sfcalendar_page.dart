import 'package:esalesapp/blocs/calendar/eventrenewalcari_bloc.dart';
import 'package:esalesapp/common/constants.dart';
import 'package:esalesapp/common/loading_indicator.dart';
import 'package:esalesapp/models/calendar/event_renewal_model.dart';
import 'package:esalesapp/pages/testing/eventrenewal_cal.dart';
import 'package:esalesapp/pages/testing/monthagenda_cal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SFCalendarPage extends StatefulWidget {
  const SFCalendarPage({super.key});
  @override
  State<SFCalendarPage> createState() => _SFCalendarPageState();
}

class _SFCalendarPageState extends State<SFCalendarPage>
    with SingleTickerProviderStateMixin {
  late EventRenewalCariBloc cariBloc;
  late List<EventRenewalModel> listEvent;

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
        var x = state.items;
        return state.items.isNotEmpty
            ? DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.blueGrey[900],
                    bottom: const TabBar(
                      tabs: [
                        Tab(
                          icon: Icon(Icons.schedule),
                          text: "Schedule",
                        ),
                        Tab(
                          icon: Icon(Icons.calendar_month),
                          text: "Month Calendar",
                        ),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      Center(
                        child: RenewalEventPage(),
                      ),
                      Center(
                        child: MonthAgendaPage(),
                      ),
                    ],
                  ),
                ),
              )
            : const LoadingIndicator();
      },
      buildWhen: (previous, current) {
        return (current.status == ListStatus.success);
      },
      listener: (BuildContext context, EventRenewalCariState state) {
        if (state.status == ListStatus.success) {
          listEvent = state.items;
        }
      },
    );
  }

  void loadDataEvent() {
    cariBloc.add(RefreshEventRenewalCariEvent());
  }
}
