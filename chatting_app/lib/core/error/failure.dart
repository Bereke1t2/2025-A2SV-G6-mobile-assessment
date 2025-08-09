
class Failure {
  final String message;

  Failure(this.message);
}


class TestFailure extends Failure {
 TestFailure(super.message);
}

class  LoginFailure extends Failure {
  LoginFailure(super.message);
}