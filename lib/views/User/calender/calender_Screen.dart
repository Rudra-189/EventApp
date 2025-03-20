import 'package:event_project_01/routes/appRoutes.dart';
import 'package:event_project_01/routes/appRoutesName.dart';
import 'package:event_project_01/views/User/calender/calenderControler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/eventmodel.dart';

class calenderScreen extends StatefulWidget {
  const calenderScreen({super.key});

  @override
  State<calenderScreen> createState() => _calenderScreenState();
}

class _calenderScreenState extends State<calenderScreen> {

  calenderControler controler = Get.put(calenderControler());

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _showCalender = false;

  @override
  void initState() {
    super.initState();
    controler.getEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green.shade600,
        title: GestureDetector(
          onTap: (){
            setState(() {
              if(_showCalender == false){
                _showCalender = true;
              }else{
                _selectedDay = null;
                _showCalender = false;
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("CALENDER",style: TextStyle(color: Colors.white,fontSize: 16,letterSpacing: 2),),
              _showCalender ? Icon(Icons.arrow_drop_down,color: Colors.white,) : Icon(Icons.arrow_drop_up,color: Colors.white,)
            ],
          ),
        ),
        centerTitle: true,
      ),
      body:Obx(() {
        if (controler.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Colors.green.shade600),
          );
        }

        final data = controler.calender;
        if (data.isEmpty) {
          return Center(
            child: Text("No events found!", style: TextStyle(color: Colors.white)),
          );
        }

        // Group events by date
        Map<String, List<eventDataModel>> groupedEvents = {};
        for (var event in data) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(event.date);
          if (!groupedEvents.containsKey(formattedDate)) {
            groupedEvents[formattedDate] = [];
          }
          groupedEvents[formattedDate]!.add(event);
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              _showCalender ? Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: TableCalendar(
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  eventLoader: (day) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(day);
                    return groupedEvents[formattedDate] ?? [];  // Return events for the date
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  availableCalendarFormats: {
                    CalendarFormat.month: 'Month'
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(color: Colors.green.shade600,fontSize: 16),
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                  ),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.green.shade600,
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    defaultTextStyle: TextStyle(color: Colors.white),
                    markerDecoration: BoxDecoration(
                      color: Colors.green.shade600, // Change event dot color here
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ) : SizedBox(),
              ListView.builder(
                itemCount: groupedEvents.keys.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, dateIndex) {
                  String dateKey = groupedEvents.keys.elementAt(dateIndex);
                  List<eventDataModel> events = groupedEvents[dateKey]!;

                  if (_showCalender && _selectedDay != null) {
                    String selectedDateKey = DateFormat('yyyy-MM-dd').format(_selectedDay!);
                    if (dateKey != selectedDateKey) {
                      return SizedBox(); // Hide other events
                    }
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    padding: EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        // Date Header
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('MMM').format(events.first.date),
                                    style: TextStyle(color: Colors.green.shade600, fontSize: 12),
                                  ),
                                  Text(
                                    DateFormat('dd').format(events.first.date),
                                    style: TextStyle(color: Colors.green.shade600, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          title: Text(
                            "${DateFormat('EEE').format(events.first.date).toUpperCase()}, "
                                "${DateFormat('d').format(events.first.date)} "
                                "${DateFormat('MMMM').format(events.first.date).toUpperCase()}, "
                                "${DateFormat('y').format(events.first.date)}",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 5),

                        // If only 1 event, show it in the original style
                        if (events.length == 1)
                          GestureDetector(
                            onTap: (){
                              Get.toNamed(
                                appRoutesName.eventDetailScreen,
                                arguments: {
                                  'id': events.first.id,
                                  'category':events.first.category
                                },
                              );
                            },
                            child: Container(
                              height: 75,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 50),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    events.first.img,
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                title: Text(
                                  events.first.title,
                                  style: TextStyle(color: Colors.white, fontSize: 16, overflow: TextOverflow.ellipsis),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  "₹ ${events.first.price.Economy}",
                                  style: TextStyle(color: Colors.green.shade600, fontSize: 14),
                                ),
                              ),
                            ),
                          )
                        else
                        // If multiple events, use a ListView to show all events
                          ListView.builder(
                            itemCount: events.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Get.toNamed(
                                    appRoutesName.eventDetailScreen,
                                    arguments: {
                                      'id': events[index].id,
                                      'category': events[index].category
                                    },
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10,left: 50),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        events[index].img,
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    title: Text(
                                      events[index].title,
                                      style: TextStyle(color: Colors.white, fontSize: 16, overflow: TextOverflow.ellipsis),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      "₹ ${events[index].price.Economy}",
                                      style: TextStyle(color: Colors.green.shade600, fontSize: 14),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        );
      })
    );
  }
}

