import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/app_bar.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime today = DateTime.now();

  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventController = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvents;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDate)) {
      setState(() {
        _selectedDay = selectedDate;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDate);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Attendance', showActions: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text(
                    "Add Event",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _eventController,
                      decoration: InputDecoration(
                        hintText: "Enter event name",
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_eventController.text.isNotEmpty) {
                          events.addAll({
                            _selectedDay!: [Event(_eventController.text)]
                          });
                          _eventController
                              .clear(); // Clear the text field content
                          Navigator.of(context).pop();
                          _selectedEvents.value =
                              _getEventsForDay(_selectedDay!);
                        } else {
                          // Show an error message if the text field is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please enter an event name"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Text("Submit"),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            child: TableCalendar(
              rowHeight: 45,
              headerStyle: HeaderStyle(
                // formatButtonVisible: false,
                titleCentered: true,
              ),
              focusedDay: _focusedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: _onDaySelected,
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              firstDay: DateTime.utc(2023, 01, 01),
              lastDay: DateTime.utc(3030, 12, 31),
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
              ),
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
          ),
          SizedBox(height: 10.0,),
          Text('Selected Date = ' + today.toString().split(" ")[0], style: TextStyle(fontSize: 16),),
          SizedBox(
            height: 8.0,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (Context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(),
                          ),
                          child: ListTile(
                            onTap: () => print(''),
                            title: Text('${value[index].title}'),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  Event(this.title);
}
