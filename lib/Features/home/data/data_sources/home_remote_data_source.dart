import 'package:bookly2/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly2/core/utils/api_service.dart';
import 'package:hive/hive.dart';

import '../../../../constants.dart';
import '../../../../core/utils/functions/save_box.dart';
import '../../domain/entities/book_entity.dart';

abstract class HomeRemoteDatsSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRemoteDatsSourceImpl extends HomeRemoteDatsSource {
  final ApiService apiService;

  HomeRemoteDatsSourceImpl(this.apiService);

  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&subject=test&q=Flutter');
    List<BookEntity> books = getBooksList(data);

    saveDataToLocal(books, kFeatuerdBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&q=subject:Programming');
    List<BookEntity> books = getBooksList(data);
    saveDataToLocal(books, kNewestBox);
    return books;
  }

  List<BookEntity> getBooksList(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}

  //'volumes?Filtering=free-ebooks&subject=test&q=Flutter'