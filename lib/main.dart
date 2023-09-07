import 'package:flutter/material.dart';
import 'package:to_do/to_do_item.dart';

void main() => runApp(const ToDoApp());

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ToDoHomePage(title: 'Daily ToDo'),
    );
  }
}

class ToDoHomePage extends StatefulWidget {
  const ToDoHomePage({super.key, required this.title});
  final String title;

  @override
  State<ToDoHomePage> createState() => _ToDoHomePageState();
}

class _ToDoHomePageState extends State<ToDoHomePage> {
  // int _counter = 0;
  List<ToDoItem> todoList = [
    ToDoItem(toDoTitle: 'Task 0', isDone: false),
    ToDoItem(toDoTitle: 'Task 1', isDone: true),
    ToDoItem(toDoTitle: 'Task 2', isDone: false),
    ToDoItem(toDoTitle: 'Task 3', isDone: true),
    ToDoItem(toDoTitle: 'Task 4', isDone: false),
    ToDoItem(toDoTitle: 'Task 5', isDone: true),
  ];


  void onCheck(List<ToDoItem> todoList, int index, bool? value) {
    setState(() {
      todoList[index].isDone = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.yellow[500],
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: todoList.length, // specify the total number of items
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[500],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListTile(
                title: Text(todoList[index].toDoTitle),
                trailing: Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    value: todoList[index].isDone,
                    onChanged: (value) {
                      onCheck(todoList, index, value);
                    }),
              ),
            ),
          );
        },
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {openDialog();},
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child:const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    
    );
  }

  final TextEditingController _controller = TextEditingController();
  
  void openDialog() =>showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("ToDo item"),
      content: TextField(
        cursorColor: Colors.green,
        decoration: const InputDecoration(
          hintText: "Enter a toDo",
          enabledBorder: UnderlineInputBorder(      borderSide: BorderSide(color: Colors.green),   ),  
          focusedBorder: UnderlineInputBorder(      borderSide: BorderSide(color: Colors.green),   ),
        ),
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: () { submit(_controller.text);},
          child: const Text("Add",style: TextStyle(color: Colors.green)))
      ],
    )
  );


  submit(String text) {
    setState((){
        todoList.add(ToDoItem(toDoTitle: text, isDone: false));
    });
    Navigator.of(context).pop();
  }

}