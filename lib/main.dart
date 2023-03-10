import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {

    await const FirebaseOptions(
    apiKey: 'AIzaSyAvuwj2MolQ-5SdGvJAR9Hez3tfFjwPQh0',
    appId: '1:825681413946:web:4566d8696582d43dc67203',
    messagingSenderId: '825681413946',
    projectId: 'to-do-list-app-6869c',
    authDomain: 'to-do-list-app-6869c.firebaseapp.com',
    storageBucket: 'to-do-list-app-6869c.appspot.com',
    measurementId: 'G-MBXXFXH4JW',
);
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ToDoList(title: 'My To-Do List'),
    );
  }
}

class ToDoList extends StatefulWidget {
  ToDoList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> _tasks = [];

  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _taskController.clear();
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(_tasks[index]),
          onDismissed: (direction) {
            _removeTask(index);
          },
         child: Card(
          child: ListTile(
            title: Text(_tasks[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeTask(index);
      },
    ),
  ),
),
        );
      },
      itemCount: _tasks.length,
    );
  }

  Widget _buildAddTaskForm() {
    return TextField(
      controller: _taskController,
      decoration: InputDecoration(
        labelText: 'Add a new task',
      ),
      onSubmitted: (value) {
        _addTask(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildAddTaskForm(),
          ),
          Expanded(
            child: _buildTaskList(),
          ),
        ],
      ),
    );
  }
}