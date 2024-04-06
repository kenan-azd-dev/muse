import 'package:equatable/equatable.dart';
import './failure.dart';

class AuthFailure extends Equatable implements Failure {

  const AuthFailure({this.code = 'unknown'});

  @override
  final String code;

  @override
  List<Object?> get props => [code];

}