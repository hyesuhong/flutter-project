import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/toon_model.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:flutter_application_1/styles/font.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToonModel> toons = [];
  bool isLoading = false;

  void getToonData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var data = await ApiService.getTodayToons();
      setState(() {
        toons = data;
      });
    } catch (error) {
      print('$error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getToonData();
  }

  @override
  Widget build(BuildContext context) {
    print(toons);
    print(isLoading);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black12,
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[600],
        elevation: 5,
        title: Text(
          'Today\'s toons',
          style: TextStyle(
            fontSize: 20,
            fontVariations: [NotoSansKRWeight.w500],
          ),
        ),
      ),
    );
  }
}
