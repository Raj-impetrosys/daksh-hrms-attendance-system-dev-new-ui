import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'util.dart';

class BasicsCalander extends StatefulWidget {
  const BasicsCalander({Key? key}) : super(key: key);

  @override
  _BasicsCalanderState createState() => _BasicsCalanderState();
}

class _BasicsCalanderState extends State<BasicsCalander> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
  
      return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
      if (!isSameDay(_selectedDay, selectedDay)) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      }
        },
      ),
    );
  }
}
