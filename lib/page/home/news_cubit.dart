import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:news/page/home/news_repository.dart';
import 'package:news/page/home/news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsRepository _newsRepository;

  NewsCubit(this._newsRepository) : super(NewsInitial());

  Future<Void> getAllNews() async {
    emit(NewsLoading());
    final allNews = await _newsRepository.getAllNews();
    if (allNews.isEmpty)
      emit(NewsError("there is no news at the moment"));
    else
      emit(NewsLoaded(allNews));
  }
}
