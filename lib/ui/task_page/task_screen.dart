import 'package:almaty_app/ui/task_page/task_list_widget.dart';
import 'package:almaty_app/ui/task_page/task_map_list_widget.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool _mapListChosen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Задание'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.list,
              color: !_mapListChosen
                  ? Colors.white
                  : Colors.white.withOpacity(0.40),
            ),
            onPressed: () {
              setState(() {
                _mapListChosen = false;
              });
            },
          ),
          IconButton(
              icon: Icon(
                Icons.map,
                color: _mapListChosen
                    ? Colors.white
                    : Colors.white.withOpacity(0.40),
              ),
            onPressed: () {
                setState(() {
                  _mapListChosen = true;
                });
            },
          ),
        ],
      ),
      body: _mapListChosen ? TaskMapList() : TaskList()
    );
  }
}
