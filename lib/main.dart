import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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

  TextEditingController _taskController = TextEditingController();

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