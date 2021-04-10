import 'package:news/page/home/model.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getAllNews();
}

class NetworkNewsRepository extends NewsRepository {
  HomeNewsNetworkService homeNewsNetworkService = new HomeNewsNetworkService();

  @override
  Future<List<NewsItem>> getAllNews() async {
    return homeNewsNetworkService.callDirectly();
  }
}
