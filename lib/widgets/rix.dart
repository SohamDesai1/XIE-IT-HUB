// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables,prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SubjectList(),
  ));
}

class SubjectList extends StatefulWidget {
  const SubjectList({super.key});

  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  final TextEditingController _subjectController = TextEditingController();
  final List<String> _subjects = [];
  void _addSubject() {
    final String subject = _subjectController.text;
    setState(() {
      if (_subjectController.text.isNotEmpty) {
        _subjects.add(subject);
      }
    });
    _subjectController.clear();
  }

  void _deleteSubject(int index) {
    setState(() {
      _subjects.removeAt(index);
    });
  }

  Future _opendialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Subject"),
            content: TextField(),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit"))
            ],
          ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subject List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _subjectController,
            decoration: InputDecoration(
              labelText: 'Subject Name',
              hintText: 'Enter the name of the subject',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _addSubject,
            child: Text('Add Subject'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _subjects.length,
              itemBuilder: (BuildContext context, int index) {
                final String subject = _subjects[index];
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: 400,
                      child: ListTile(
                        title: Text(subject),
                        trailing: PopupMenuButton(
                          // Callback that sets the selected popup menu item.
                          onSelected: (result) {
                            if (result == 0) {
                              _deleteSubject(index);
                            }
                            if (result == 1) {
                              _opendialog();
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: 0,
                              child: Text("Delete"),
                            ),
                            PopupMenuItem(
                              value: 1,
                              child: Text("Edit"),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
