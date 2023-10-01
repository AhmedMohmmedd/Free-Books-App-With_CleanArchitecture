import 'package:bookly2/Features/home/data/data_sources/home_local_data_source.dart';
import 'package:bookly2/Features/home/data/data_sources/home_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import 'package:bookly2/core/errors/faliure.dart';

import 'package:bookly2/Features/home/domain/entities/book_entity.dart';
import 'package:dio/dio.dart';

import '../../domain/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeRemoteDatsSource homeRemoteDatsSource;
  final HomeLocalDatsSource homeLocalDatsSource;

  HomeRepoImpl(
      {required this.homeRemoteDatsSource, required this.homeLocalDatsSource});

  @override
  Future<Either<Faliuer, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> books;

      books = homeLocalDatsSource.fetchFeaturedBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDatsSource.fetchFeaturedBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
        return left(ServerFailure(e.toString()));
      
    }
  }

  @override
  Future<Either<Faliuer, List<BookEntity>>> fetchNewestBooks() async {
    try {
      List<BookEntity> books;

      books = homeLocalDatsSource.fetchNewestBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDatsSource.fetchNewestBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
        return left(ServerFailure(e.toString()));
      
    }
  }
}
