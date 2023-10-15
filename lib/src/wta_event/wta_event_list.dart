import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:kirgu_employee/src/wta_event/wta_event.dart';
import 'package:kirgu_employee/src/wta_event/wta_event_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EventListView extends StatelessWidget {
  const EventListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AsyncValue<List<WtaEvent>> events =
            ref.watch(wtaEventListProvider);

        return switch (events) {
          AsyncData(:final value) => WtaEventsCalendar(events: value),
          AsyncError() => const Center(
              child: Text("ERROR"),
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            )
        };
      },
    );
  }
}

class WtaEventsCalendar extends StatefulWidget {
  const WtaEventsCalendar({super.key, required this.events});

  final List<WtaEvent> events;
  static const routeName = "/events";

  @override
  State<WtaEventsCalendar> createState() => _WtaEventsCalendarState();
}

class _WtaEventsCalendarState extends State<WtaEventsCalendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<WtaEvent>? _events;
  late List<WtaEvent> _selectedDayEvents;

  @override
  void initState() {
    super.initState();

    _events = widget.events;
    _selectedDay = _focusedDay;
    _selectedDayEvents = _getEventsForDay(_selectedDay!);
  }

  List<WtaEvent> _getEventsForDay(DateTime day) {
    if (_events == null) {
      return [];
    } else {
      return _events!
          .where((element) => (element.date.day == day.day))
          .toList();
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedDayEvents = _getEventsForDay(_selectedDay!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<WtaEvent>(
            locale: "ru_RU",
            focusedDay: _focusedDay,
            firstDay: DateTime(_focusedDay.year, _focusedDay.month, 1),
            lastDay: DateTime(_focusedDay.year, _focusedDay.month + 1, 0),
            onDaySelected: _onDaySelected,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                // Call `setState()` when updating calendar format
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedDayEvents.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    title: Text(DateFormat("Hm")
                        .format(_selectedDayEvents[index].date)),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
