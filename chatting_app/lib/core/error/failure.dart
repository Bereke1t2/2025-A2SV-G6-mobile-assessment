
class Failure {
  final String message;

  Failure(this.message);
}


class TestFailure extends Failure {
 TestFailure(super.message);
}
