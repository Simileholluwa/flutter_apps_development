//sign up screen
class WeakPasswordAuthException implements Exception {}
class EmailAlreadyInUseAuthException implements Exception {}

//generic
class GenericAuthException implements Exception {}
class UserNotLoggedInAuthException implements Exception {}
class NetworkRequestFailedAuthException implements Exception {}
class UnknownAuthException implements Exception {}
class InvalidEmailAuthException implements Exception {}

//login screen
class UserNotFoundAuthException implements Exception {}
class WrongPasswordAuthException implements Exception {}
class TooManyRequestAuthException implements Exception {}
