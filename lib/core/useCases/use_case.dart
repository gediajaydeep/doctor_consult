import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

abstract class UseCase<Request, Response> {
  Future<Either<Failure, Response>> execute(Request request);
}

class EmptyRequest extends Equatable {
  const EmptyRequest();

  @override
  List<Object?> get props => [];
}
