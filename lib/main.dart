// ignore_for_file: sort_child_properties_last

//import 'dart:convert';
import 'package:flutter_application_11/models/config.dart';
import 'package:flutter_application_11/models/user.dart';
import 'package:flutter_application_11/screens/login.dart';
import 'package:flutter_application_11/screens/user_form.dart';
import 'package:flutter_application_11/screens/user_info.dart';
import 'screens/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User CRUD',
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();
  List<User> _userList = [];
  Future<void> getUser() async {
    var url = Uri.http(Configure.server, "user");
    var resp = await http.get(url);
    setState(() {
      _userList = userFromJson(resp.body);
      mainBody = showUser();
    });
    return;
  }

  Future<void> removeUser(user) async {
    var url = Uri.http(Configure.server, "user/${user.id}");
    var resp = await http.delete(url);
    print(resp.body);
    return;
  }

  Widget showUser() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        User user = _userList[index];
        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          child: Card(
            child: ListTile(
              title: Text("${user.fullname}"),
              subtitle: Text("${user.email}"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserInfo(),
                        settings: RouteSettings(arguments: user)));
              },
              trailing: IconButton(
                onPressed: () async {
                  String result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserForm(),
                          settings: RouteSettings(arguments: user)));
                  if (result == "refresh") {
                    getUser();
                  }
                },
                icon: Icon(Icons.edit),
              ),
            ),
          ),
          onDismissed: (direction) {
            removeUser(user);
          },
          background: Container(
            color: Colors.brown,
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.orange),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    User user = Configure.login;
    if (user.id != null) {
      getUser();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text("Home")),
      ),
      drawer: SideMenu(),
      body: mainBody,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserForm()));
          if (result == "refresh") {
            getUser();
          }
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
