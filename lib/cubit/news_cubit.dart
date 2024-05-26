// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsapplication/Api/news_apicall.dart';
// import 'package:newsapplication/Models/news_model.dart';

// class NewsCubit extends Cubit<List<NewsArticle>> {
//   final NewsApi newsApi;

//   NewsCubit(this.newsApi) : super([]);

//   Future<void> fetchArticles(category) async {
//     try {
//       final articles = await newsApi.fetchnews(category);
//       emit(articles);
//     } catch (e) {
//       print("error$e");
//       emit([]);
//     }
//   }
//    void toggleBookmark(NewsArticle article) {
//     final updatedArticles = state.map((a) {
//       return a == article ? a.copyWith(bookmark: !a.bookmark) : a;
//     }).toList();
//     emit(updatedArticles);
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapplication/Api/news_apicall.dart';
import 'package:newsapplication/Models/news_model.dart';
class NewsCubit extends Cubit<List<NewsArticle>> {
  final NewsApi newsApi;
  String _selectedCategory = 'business';
  int _currentPage = 1;
  bool _isFetching = false;

  NewsCubit(this.newsApi) : super([]);

  Future<void> fetchArticles(String category, {bool isLoadMore = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      if (category != _selectedCategory) {
        _selectedCategory = category;
        _currentPage = 1;
        emit([]);
      } else if (isLoadMore) {
        _currentPage++;
      } else {
        _currentPage = 1;
        emit([]);
      }

      final articles = await newsApi.fetchnews(_selectedCategory, _currentPage);
      if (isLoadMore) {
        emit(List.of(state)..addAll(articles));
      } else {
        emit(articles);
      }
    } catch (e) {
      print("error$e");
      emit([]);
    } finally {
      _isFetching = false;
    }
  }

  void toggleBookmark(NewsArticle article) {
    final updatedArticles = state.map((a) {
      return a == article ? a.copyWith(bookmark: !a.bookmark) : a;
    }).toList();
    emit(updatedArticles);
  }
}
