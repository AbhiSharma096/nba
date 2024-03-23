import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Headlines',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsPage(),
    );
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<dynamic> articles = [];
  int index = 0;
  List<String> catagories = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];

  //final width = MediaQuery.sizeOf(context).width * 1;
  //final height = MediaQuery.sizeOf(context).height * 1;

  Future<void> getNewsHeadlines(String catagory) async {
    String apiKey = 'dca45442015e47b5b0e242af511c5536';
    String country = 'in';
    String category = catagory;

    String apiUrl =
        'https://newsapi.org/v2/top-headlines?country=$country&category=$category&apiKey=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      setState(() {
        articles = jsonDecode(response.body)['articles'];
      });
    } else {
      print('Failed to load news headlines');
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsHeadlines('business');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[0],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[1],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[2],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[3],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[4],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[5],
                ),
                const SizedBox(
                  width: 24,
                ),
                categoryButton(
                  catagories[6],
                ),
                const SizedBox(
                  width: 24,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                return Container(
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16)),
                    child: ListTile(
                      title: Text(article['title'] ?? ''),
                      subtitle: Text(article['description'] ?? ''),
                      leading: article['urlToImage'] != null
                          ? CircleAvatar(
                              backgroundImage:
                                  NetworkImage(article['urlToImage']),
                            )
                          : null,
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton categoryButton(String cat) {
    return ElevatedButton(
      onPressed: () {
        getNewsHeadlines(cat);
      },
      child: Text(cat),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
