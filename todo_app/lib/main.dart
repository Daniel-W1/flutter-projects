import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';

void main() async {
  // initialise the hive
  await Hive.initFlutter();

  // open the box
  var myBox = await Hive.openBox("myTodo");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final myController = TextEditingController();
  late PageController myPageController;
  late Database db;

  @override
  void initState() {
    super.initState();
    db = Database();
    myPageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  void addTodo() {
    setState(() {
      String todo = myController.text;
      if (todo == "") return;
      db.myTodos.add(todo);
      db.updateDB();
      myController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: const Text('My TODOs'),
        ),
        body: PageView(
          controller: myPageController,
          onPageChanged: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text(
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        'ALL TODOs',
                      ),
                      TextField(
                        controller: myController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'add a todo..'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          addTodo();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.greenAccent),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: const Text('ADD'),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: db.myTodos.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, index) {
                                      return ListTile(
                                        title: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        db.myTodos[index])),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        db.completedTodos.add(
                                                            db.myTodos[index]);

                                                        db.myTodos
                                                            .removeAt(index);

                                                        db.updateDB();
                                                      });
                                                    },
                                                    icon:
                                                        const Icon(Icons.done)),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        db.myTodos
                                                            .removeAt(index);
                                                        db.updateDB();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: db.myTodos.length,
                                  )
                                : const Center(
                                    child: Text(
                                    'No todos yet!',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.greenAccent),
                                  )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: db.completedTodos.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, index) {
                                      return ListTile(
                                        title: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        db.completedTodos[
                                                            index])),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: db.completedTodos.length,
                                  )
                                : const Center(
                                    child: Text(
                                    'No Completed TODOs yet!',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.greenAccent),
                                  )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: db.myTodos.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, index) {
                                      return ListTile(
                                        title: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        db.myTodos[index])),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: db.myTodos.length,
                                  )
                                : const Center(
                                    child: Text(
                                    'No todos yet!',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.greenAccent),
                                  )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                currentIndex = value;
              });
              myPageController.jumpToPage(currentIndex);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.task), label: 'Completed'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.pending), label: 'Pending'),
            ],
            currentIndex: currentIndex),
      ),
    );
  }
}
