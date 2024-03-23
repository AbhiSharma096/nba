import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "api.spoonacular.com";
  String test = "";

  // Define your API key here
  var apiKey = '2d2b541e534e42e8bae9f9243a2f15bb';

  Future<void> getTeams() async {
    var uri = Uri.https(url, '/recipes/random', {'apiKey': apiKey});

    var response = await http.get(uri);

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      setState(() {
        test = jsonResponse['recipes'][0]['title'];
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Recipe App",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text(test),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTeams,
        child: const Text('A'),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Recpie App',
        style: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: const Color(0xffF7F8F8),
              borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/icons/ArrowLeft.svg',
            height: 20,
            width: 20,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xffF7F8F8),
                borderRadius: BorderRadius.circular(10)),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5,
              width: 5,
            ),
          ),
        ),
      ],
    );
  }
}
