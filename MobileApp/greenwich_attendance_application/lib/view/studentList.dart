import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:greenwich_attendance_application/model/Student.dart';

void main() {
  runApp(const StudentList());
}

class StudentList extends StatelessWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _StudentList(),
    );
  }
}

class _StudentList extends StatefulWidget {
  const _StudentList({Key? key}) : super(key: key);

  @override
  State<_StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<_StudentList> {
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  Future<void> _refreshStudents() async {
    setState(() {
      futureStudents = fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshStudents,
        child: Center(
          child: FutureBuilder(
            future: futureStudents,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Retrieve Failed');
              } else if (snapshot.hasData) {
                final todos = snapshot.data;
                return ListView.builder(
                  itemCount: todos?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(todos?[index].name ?? 'Not Found'),
                      subtitle: Text(todos?[index].studentCode ?? 'Not Found'),
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

  List<Student> parseStudents(String response){
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Student>((json) => Student.fromJson(json)).toList();
  }

  Future<List<Student>> fetchStudents() async {
    const url = "http://www.nqngoc.id.vn/get_StudentInfomation.php";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseStudents(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }
}

