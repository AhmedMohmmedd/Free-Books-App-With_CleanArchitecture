import 'package:dartz/dartz.dart';

import '../../../../core/errors/faliure.dart';
import '../../../../core/use_cases/ues_case.dart';
import '../entities/book_entity.dart';
import '../repos/home_repo.dart';

class FeatchNewestBooksUseCase extends UseCase<List<BookEntity>, NoParam> {
  final HomeRepo homeRepo;

  FeatchNewestBooksUseCase(this.homeRepo);

  @override
  Future<Either<Faliuer, List<BookEntity>>> call([NoParam? param]) async {
    return await homeRepo.fetchNewestBooks();
  }
}