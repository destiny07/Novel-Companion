import 'package:equatable/equatable.dart';

class ResponseMessage<T> extends Equatable {
  final bool isSuccess;
  final String? description;
  final T? data;

  const ResponseMessage({this.isSuccess = true, this.description, this.data});

  @override
  List<Object?> get props => [isSuccess, description, data];
}
