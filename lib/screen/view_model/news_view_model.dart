import 'package:newsapiapp/model/newschannelheadklinemodel.dart';
import 'package:newsapiapp/repository/news_repository.dart';

class NewsViewModel {
  final _repo = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewChannelHeadlinesApi() async {
    final response = await _repo.fetchNewsChannelHeadlinesAPi();
    return response;
  }
}
