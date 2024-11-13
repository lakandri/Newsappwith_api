import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapiapp/model/newschannelheadklinemodel.dart';

class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewsChannelHeadlinesAPi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=7177be55031f47098f7f59034a662868';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);
    }
    throw Exception('Error');
  }
}
