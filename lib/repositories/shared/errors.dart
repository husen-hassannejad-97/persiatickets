import 'dart:core';

sealed class ResultError implements Exception {}

class BadRequestError extends ResultError {
  final String detail;
  BadRequestError({required this.detail});
}

class UnauthorizedError extends ResultError {}

class ConnectionError extends ResultError {}

class ServerError extends ResultError {
  final String message;
  ServerError({required this.message});
}

class NotFoundError extends ResultError {}

class UnexpectedError extends ResultError {
  final String message;
  UnexpectedError({required this.message});
}

class IOError extends ResultError {
  final String? message;
  IOError({required this.message});
}
