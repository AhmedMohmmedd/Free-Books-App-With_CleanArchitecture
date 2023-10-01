import 'package:bookly2/constants.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/book_entity.dart';

abstract class HomeLocalDatsSource {
  List<BookEntity> fetchFeaturedBooks();
  List<BookEntity> fetchNewestBooks();
}

class HomeLocalDatsSourceImpl extends HomeLocalDatsSource {
  @override
  List<BookEntity> fetchFeaturedBooks() {
    var bok = Hive.box<BookEntity>(kFeatuerdBox);
    return bok.values.toList();
  }

  @override
  List<BookEntity> fetchNewestBooks() {
    var bok = Hive.box<BookEntity>(kNewestBox);
    return bok.values.toList();
  }
}
