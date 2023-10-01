import 'package:bookly2/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly2/core/utils/api_service.dart';

import '../../domain/entities/book_entity.dart';

home_local_data_source.dart




class HomeRemoteDatsSourceImpl extends HomeRemoteDatsSource {
  final ApiService apiService;

  HomeRemoteDatsSourceImpl(this.apiService);


  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&subject=test&q=Flutter');
    List<BookEntity> books = getBooksList(data);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
     var data = await apiService.get(
        endPoint: 'volumes?Filtering=free-ebooks&q=subject:Programming');
    List<BookEntity> books = getBooksList(data);
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