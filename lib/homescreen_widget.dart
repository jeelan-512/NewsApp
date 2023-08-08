import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/details_screen.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/news_response_model.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({Key? key}) : super(key: key);

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
  NewResponseModel? articalData;
  bool loading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: articalData?.articles?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(48.0),
                        child: Image.network(
                          articalData?.articles?[index].urlToImage ?? "",
                          fit: BoxFit.cover,
                          height: 100.0,
                          width: 100.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Title : ${articalData?.articles?[index].title ?? ""}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                                width: 200,
                                child: Text(
                                    'Author : ${articalData?.articles?[index].author ?? ""}'))
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              author:
                                  articalData?.articles?[index].author ?? "",
                              description:
                                  articalData?.articles?[index].content ?? "",
                            )),
                  );
                },
              );
            });
  }

  void fetchData() async {
    var url = Uri.parse(
        'https://newsapi.org/v2/everything?q=tesla&from=2023-07-07&sortBy=publishedAt&apiKey=21d467a28c7e4b5eabee6e1d058e0f68');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      NewResponseModel newResponseModel = NewResponseModel.fromJson(data);
      setState(() {
        articalData = newResponseModel;
        loading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}
