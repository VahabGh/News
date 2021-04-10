import 'package:equatable/equatable.dart';
import 'package:news/page/home/model.dart';

abstract class NewsState extends Equatable{
  const NewsState();
}

class NewsInitial extends NewsState {

  const NewsInitial();

  @override
  List<Object> get props => [];

}

class NewsLoading extends NewsState {

  const NewsLoading();

  @override
  List<Object> get props => [];
}

class NewsLoaded extends NewsState {
  final List<NewsItem> allNews;

  NewsLoaded(this.allNews);

  @override
  List<Object> get props => [allNews];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object> get props => [message];
}
