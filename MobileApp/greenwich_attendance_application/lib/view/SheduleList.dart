import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Slot.dart';

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
                        leading: SizedBox(
                          width: 60,
                          height: 60,
                          child: Image.network(
                            'http://nqngoc.id.vn/images/default.png',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        title: Text(slots?[index].timeIn ?? 'Not Found'),
                        subtitle: Text(slots?[index].slotName ?? 'Not Found'),
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

