import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? code;

  const Failure({this.code = 'unknown'});

  @override
  List<Object?> get props => [code];
}