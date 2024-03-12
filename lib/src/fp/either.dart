// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class Either<L, R> {}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(
    this.value,
  );
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(
    this.value,
  );
}
