import 'dart:convert';

import 'package:flutter/material.dart';
import '/components/bottom_navigation.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Future<List<User>>? _users;

  void _fetchUsers() {
    setState(() {
      _users = null;
    });
    try {
      var userData = fetchFakeUsers();
      setState(() {
        _users = userData;
      });
    } catch (e) {
      print('Something really unknown: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: _users != null ? Alignment.topCenter : Alignment.center,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _fetchUsers(),
                  child: Text('Get Users'),
                ),
                FutureBuilder(
                  future: _users,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData) {
                      var users = snapshot.data!;
                      return buildUsers(users);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }

                    return Text('There are no user data');
                  },
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigation(index: 1),
    );
  }
}

class User {
  final int id;
  final String name;

  const User({
    required this.id,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
      } =>
        User(id: id, name: name),
      _ => throw const FormatException('Failed to load users')
    };
  }
}

Future<List<User>> fetchFakeUsers() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    var users = body.map((item) => User.fromJson(item));
    return users.toList();
  } else {
    throw Exception('Failed to load users');
  }
}

Widget buildUsers(List<User> users) {
  return GridView.count(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 2,
    children: List.generate(
      users.length,
      (index) => Center(
        child: Text(users[index].name),
      ),
    ),
  );
}
