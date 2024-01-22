import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  const UsersPage({super.key, required this.title});

  final String title;

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
      body: Center(
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
  return ListView.builder(
    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    itemCount: users.length,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      final user = users[index];
      return Text(user.name);
    },
  );
}
