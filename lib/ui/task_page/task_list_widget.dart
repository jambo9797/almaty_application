import 'package:flutter/material.dart';

class _ListItem {
  _ListItem(this.value, {this.checked});

  final String value;
  bool checked;
}

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  static final _items = <String>[
    'Магазин “Белый ветер”',
    'Магазин “Технодом”',
    'Магазин “Ак Ниет”',
    'Магазин “Sulpak”',
    'Магазин “Аленушка”',
    'Магазин “Alser”',
    'Магазин “Белый ветер”',
    'Магазин “Технодом”',
    'Магазин “Ак Ниет”',
    'Магазин “Sulpak”',
    'Магазин “Аленушка”',
    'Магазин “Alser”',
  ].map((item) => _ListItem(item, checked: false)).toList();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w,
      height: h,
      child: Column(
        children: [
          Container(
            width: w,
            height: 48,
            padding: EdgeInsets.only(left: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('На сегодня ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.6)),),
                Text('(Выполнено 2 из 30)',  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black.withOpacity(0.6)),),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: w,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        key: Key(_items[index].value),
                        value: _items[index].checked ?? false,
                        onChanged: (bool newValue) {
                          setState(() => _items[index].checked = newValue);
                        },
                        title: Text('${_items[index].value}'),
                        subtitle: Text('г. Алматы, ул. Абая, 900'),
                        //secondary: const Icon(Icons.drag_handle),
                      ),
                      Divider(
                        height: 0,
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ],
                  );
                } ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
