import 'package:flutter/material.dart';
import 'ToDoDAO.dart';
import 'ToDoDatabase.dart';
import 'ToDoItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 18.0, color: Colors.white),
          bodyText2: TextStyle(fontSize: 16.0, color: Colors.white70),
          headline6: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: const ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<ToDoItem> _items = [];
  final TextEditingController _controller = TextEditingController();
  late Future<ToDoDao> _myDAO;
  ToDoItem? _selectedItem;

  @override
  void initState() {
    super.initState();
    _myDAO = _initDatabase(); // Directly assign the Future
    _myDAO.then((dao) { // Use then() to handle the Future's result
      _fetchItems(dao); // Fetch items after the dao is ready
    });
  }

  Future<ToDoDao> _initDatabase() async {
    final database = await $FloorToDoDatabase.databaseBuilder('app_database.db').build();
    return database.toDoDao;
  }

  Future<void> _fetchItems(ToDoDao dao) async {
    final items = await dao.getAllItems();
    setState(() {
      _items = items;
    });
  }

  Future<void> _addItem(ToDoDao dao, String message) async {
    final newItem = ToDoItem(null, message);
    await dao.insertItem(newItem);
    await _fetchItems(dao);
    _controller.clear();
  }

  Future<void> _removeItem(ToDoDao dao, int id) async {
    await dao.deleteItem(_items.firstWhere((item) => item.id == id));
    await _fetchItems(dao);
    setState(() {
      _selectedItem = null; // Clear selection after deletion
    });
  }

  void _selectItem(ToDoItem item) {
    setState(() {
      _selectedItem = item;
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedItem = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ToDoDao>(
      future: _myDAO,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: Text('Database initialization failed')),
          );
        } else {
          final dao = snapshot.data!;
          var size = MediaQuery.of(context).size;
          var height = size.height;
          var width = size.width;

          if ((width > height) && (width > 720)) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('TODO LIST')
              ),
              body: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ToDoList(
                      items: _items,
                      controller: _controller,
                      dao: dao,
                      addItem: _addItem,
                      removeItem: _removeItem,
                      selectItem: _selectItem,
                    ),
                  ),
                  _selectedItem != null
                      ? Expanded(
                    flex: 2,
                    child: DetailsPage(
                      item: _selectedItem,
                      dao: dao,
                      removeItem: _removeItem,
                      clearSelection: _clearSelection,
                    ),
                  )
                      : Container(),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('To Do List'),
                leading: _selectedItem != null
                    ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _clearSelection,
                )
                    : null,
              ),
              body: _selectedItem == null
                  ? ToDoList(
                items: _items,
                controller: _controller,
                dao: dao,
                addItem: _addItem,
                removeItem: _removeItem,
                selectItem: _selectItem,
              )
                  : DetailsPage(
                item: _selectedItem,
                dao: dao,
                removeItem: _removeItem,
                clearSelection: _clearSelection,
              ),
            );
          }
        }
      },
    );
  }
}

class ToDoList extends StatelessWidget {
  final List<ToDoItem> items;
  final TextEditingController controller;
  final ToDoDao dao;
  final Future<void> Function(ToDoDao, String) addItem;
  final Future<void> Function(ToDoDao, int) removeItem;
  final void Function(ToDoItem) selectItem;

  const ToDoList({
    Key? key,
    required this.items,
    required this.controller,
    required this.dao,
    required this.addItem,
    required this.removeItem,
    required this.selectItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Enter a to-do item',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    addItem(dao, controller.text);
                  }
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(child: Text("There are no items in the list"))
              : ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => selectItem(items[index]),
                child: Card(
                  color: Colors.purple[600],
                  margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text('${index + 1}', style: TextStyle(color: Colors.black)),
                    ),
                    title: Text(items[index].message, style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class DetailsPage extends StatelessWidget {
  final ToDoItem? item;
  final ToDoDao dao;
  final Future<void> Function(ToDoDao, int) removeItem;
  final VoidCallback clearSelection;

  const DetailsPage({
    Key? key,
    required this.item,
    required this.dao,
    required this.removeItem,
    required this.clearSelection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item == null) {
      return Center(child: Text("No item selected"));
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Item: ${item!.message}", style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Text("ID: ${item!.id}", style: Theme.of(context).textTheme.bodyText2),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
              ),
              onPressed: () async {
                await removeItem(dao, item!.id!);
                clearSelection();
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );
    }
  }
}
