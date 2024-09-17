import 'package:db_box/MixinFun.dart';
import 'package:db_box/View/Bookmarkpage.dart';
import 'package:db_box/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controller/DBHelper.dart';
import '../Controller/Themecontroller.dart';
import '../Model/TODOModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with GlobalFun {
  final DBHelper _dbHelper = DBHelper();
  List<Todo> _todos = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _todos = todos;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<ThemeController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text1('TODO List', 15, FontWeight.bold),
        actions: [
          IconButton(
              onPressed: () => themeController.toggleTheme(),
              icon: Icon(themeController.isDarkTheme
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined)),
          IconButton(onPressed: () => Fun(), icon: Icon(Icons.add)),
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BookmarkPage()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text1(todo.title, 14, FontWeight.normal),
                  subtitle: Text1(todo.description, 12, FontWeight.normal),
                  trailing: IconButton(
                    icon: Icon(
                      todo.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: todo.isFavorite ? Colors.red : null,
                    ),
                    onPressed: () => _toggleFavorite(todo),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTodo() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      Todo newTodo = Todo(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      await _dbHelper.addTodo(newTodo);
      _titleController.clear();
      _descriptionController.clear();
      _fetchTodos();
    }
  }

  Future<void> _toggleFavorite(Todo todo) async {
    Todo updatedTodo = Todo(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isFavorite: !todo.isFavorite,
    );
    await _dbHelper.updateTodo(updatedTodo);
    _fetchTodos();
  }

  Future Fun() {
    return showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addTodo,
                    child: Text('Add TODO'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
