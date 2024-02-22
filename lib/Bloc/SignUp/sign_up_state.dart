part of 'sign_up_cubit.dart';

abstract class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpProgress extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpFailure extends SignUpState {
  final String message;
  final String? image;

  SignUpFailure({
    required this.message,
    this.image,
  });
}
