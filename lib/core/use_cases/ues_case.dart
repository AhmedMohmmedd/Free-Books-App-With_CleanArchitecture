import 'package:dartz/dartz.dart';

import '../errors/faliure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Faliuer, Type>> call([Param param]);
}

class NoParam {}
