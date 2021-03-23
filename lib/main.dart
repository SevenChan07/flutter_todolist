import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(TodoListDemo());
}


class TodoListDemo extends StatefulWidget {
  @override
  _TodoListDemoState createState() => new _TodoListDemoState();
}

class _TodoListDemoState extends State<TodoListDemo> {

  List items = [];

  // 控制 textField 的值
  TextEditingController _textController = TextEditingController();

  List<Widget> getUncheckedList() {
    List<Widget> childs = [];

    for (var item in items) {
      if (!item['value']) {
        childs.add(
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(item['name']),
            value: item['value'],
            onChanged: (value) {
              setState(() {
                item['value'] = value ;        
              });
            },
          )
        );
      }
    }

    return childs;
  }

  List<Widget> getCheckedList() {
    List<Widget> childs = [];

    for (var item in items) {
      if (item['value']) {
        childs.add(
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(item['name']),
            value: item['value'],
            onChanged: (value) {
              setState(() {
                item['value'] = value ;        
              });
            },
          )
        );
      }
    }

    return childs;
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              title: const Text('Todo List'),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "请输入",
              ),
              onSubmitted: (val) {
                this.setState(() {
                  this.items.add({
                    'name': val,
                    'value': false,
                  }); 
                  EasyLoading.showSuccess('Added Success!');
                });
                // 置空
                _textController.text = "";
              },
              controller: _textController,
            ),
            Divider(),
            Text(
              '未完成',
              textAlign: TextAlign.start, 
              style: TextStyle(color: Colors.blue[500]),
            ),
            Divider(),
            Card(
              child: Column(
                children: [
                  ...getUncheckedList(),
                ],
              ),
            ),
            Divider(),
            Text(
              '已完成',
              textAlign: TextAlign.start, 
            ),
            Divider(),
            Card(
              child: Column(
                children: [
                  ...getCheckedList(),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}

