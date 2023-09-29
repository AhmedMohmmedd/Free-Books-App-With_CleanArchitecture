import 'package:bookly2/Features/home/domain/entities/book_entity.dart';
import 'package:bookly2/core/errors/faliure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either< Faliuer , List<BookEntity>>> fetchFeaturedBooks();
  Future<Either< Faliuer , List<BookEntity>>> fetchNewestBooks();
}
