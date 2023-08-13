import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Slot.dart';
import 'AddStudent.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _ScheduleList(),
    );
  }
}

class _ScheduleList extends StatefulWidget {
  const _ScheduleList({super.key});

  @override
  State<_ScheduleList> createState() => _ScheduleListState();
}

class _ScheduleListState extends State<_ScheduleList> {
  late Future<List<Slot>> futureSlots;

  @override
  void initState() {
    super.initState();
    futureSlots = fetchSlots();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      futureSlots = fetchSlots();
    });
  }
  int selectedSlot = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Schedule List"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStudents,
        child: Center(
          child: FutureBuilder(
            future: futureSlots,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Retrieve Failed');
              } else if (snapshot.hasData) {
                final slots = snapshot.data;
                return ListView.builder(
                  itemCount: slots?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 16),
                        leading: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                        title: Text('Slot ${slots?[index].slotName}' ?? 'Not Found'),
                        subtitle: Text('${slots?[index].timeIn} -> ${slots?[index].timeOut}' ?? 'Not Found'),
                      ),
                    );

                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              DateTime currentDate = DateTime.now();
              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: 200,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        DropdownButton<int>(
                          value: selectedSlot,
                          onChanged: (int? newValue) {
                            setState(() {
                              selectedSlot = newValue!;
                            });
                          },
                          items: List<DropdownMenuItem<int>>.generate(
                            8,
                                (index) => DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text('Slot ${index + 1}',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            ),
                          ),
                        ),
                        Text(
                          "${currentDate.day}/${currentDate.month}/${currentDate.year}",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nút "Create" được nhấn
                            print("Create button pressed for $selectedSlot");
                          },
                          child: const Text('Create'),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                },
              );
            },
          );



        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Slot> parseSlots(String response){
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Slot>((json) => Slot.fromJson(json)).toList();
  }

  Future<List<Slot>> fetchSlots() async {
    const url = "http://www.nqngoc.id.vn/get_Schedule.php";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseSlots(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }
}

