

class AppExceptions implements Exception{

  final _message;
  final _prefix;

  AppExceptions([this._message, this._prefix]);

  @override
  String toString(){
    return '$_prefix\n$_message';
  }
}

class InternetException extends AppExceptions{

  InternetException([String? message]): super(message, 'No Internet Connection');

}

class RequestTimeOut extends AppExceptions{

  RequestTimeOut([String? message]): super(message, 'Request Timed Out');

}

class ServerError extends AppExceptions{

  ServerError([String? message]): super(message, 'Internal Server Error');

}

class UnknownError extends AppExceptions{

  UnknownError([String? message]): super(message, 'An Unknown Error Occurred');

}