import 'dart:ui';

class EventRenewalModel {
  String eventName;
  DateTime eventFrom;
  DateTime eventTo;
  String sppaNo;
  String theInsured;
  DateTime polisStart;
  DateTime polisEnd;
  double premi;
  String cobNama;
  String curr;  
  Color? background;

  EventRenewalModel({
    required this.eventName,
    required this.eventFrom,
    required this.eventTo,
    required this.sppaNo,
    required this.theInsured,
    required this.polisStart,
    required this.polisEnd,
    required this.premi,
    required this.cobNama,
    required this.curr,
    this.background
  });

  factory EventRenewalModel.fromJson(Map<String, dynamic> data) {
    return EventRenewalModel(
        eventName: data['eventName'] ?? '',
        eventFrom: DateTime.parse(data['eventFrom'].toString()),
        eventTo: DateTime.parse(data['eventTo'].toString()),
        sppaNo: data['sppaNo'] ?? '',
        theInsured: data['theInsured'] ?? '',
        polisStart: DateTime.parse(data['polisStart'].toString()),
        polisEnd: DateTime.parse(data['polisEnd'].toString()),
        premi: double.tryParse(data['premi'].toString()) ?? 0,
        curr: data['curr'] ?? '', 
        cobNama: data['cobNama'] ?? '');
  }

  Map<String, dynamic> toJson() => {
      'eventName': eventName,
      'eventFrom': eventFrom.toIso8601String(),
      'eventTo': eventTo.toIso8601String(),
      'sppaNo': sppaNo,
      'theInsured': theInsured,
      'polisStart': polisStart.toIso8601String(),
      'polisEnd': polisEnd.toIso8601String(),
      'premi': premi.toString(),
      'curr': curr,
      'cobNama': cobNama
    };
}
