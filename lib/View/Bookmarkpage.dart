import 'package:db_box/Controller/DBHelper.dart';
import 'package:db_box/MixinFun.dart';
import 'package:flutter/material.dart';
import '../Model/TODOModel.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> with GlobalFun {
  final DBHelper _dbHelper = DBHelper();
  List<Todo> _favoriteTodos = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteTodos();
  }

  Future<void> _fetchFavoriteTodos() async {
    final todos = await _dbHelper.getTodos();
    setState(() {
      _favoriteTodos = todos.where((todo) => todo.isFavorite).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text1('Bookmarked TODOs', 15, FontWeight.bold),
      ),
      body: _favoriteTodos.isEmpty
          ? Center(child: Text1('No bookmarked TODOs', 20, FontWeight.bold))
          : ListView.builder(
              itemCount: _favoriteTodos.length,
              itemBuilder: (context, index) {
                final todo = _favoriteTodos[index];
                return ListTile(
                  title: Text1(todo.title, 14, FontWeight.normal),
                  subtitle: Text1(todo.description, 12, FontWeight.normal),
                );
              },
            ),
    );
  }
}
