part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class AccountResetEvent extends AccountEvent {}

class AccountLoadAllEvent extends AccountEvent {
  AccountLoadAllEvent();
}

class AccountLoadOneEvent extends AccountEvent {
  final String login;
  AccountLoadOneEvent({
    required this.login,
  });
}

class AccountAddEvent extends AccountEvent {
  final RegisterModel register;
  AccountAddEvent({
    required this.register,
  });
}

class AccountUpdateEvent extends AccountEvent {
  final AccountModel account;
  AccountUpdateEvent({
    required this.account,
  });
}

class AccountRemoveEvent extends AccountEvent {
  final AccountModel account;
  AccountRemoveEvent({
    required this.account,
  });
}

class AccountSearchEvent extends AccountEvent {
  final String text;
  AccountSearchEvent({
    required this.text,
  });
}

class ChangePasswordEvent extends AccountEvent {
  final ChangePasswordModel changePassword;
  ChangePasswordEvent({
    required this.changePassword,
  });
}

class ResetPasswordEvent extends AccountEvent {
  final String body;
  ResetPasswordEvent({
    required this.body,
  });
}

class CheckAccountEvent extends AccountEvent {
  CheckAccountEvent();
}

class RegisterEvent extends AccountEvent {
  final String body;
  RegisterEvent({
    required this.body,
  });
}

class AuthEvent extends AccountEvent {
  final String body;
  AuthEvent({
    required this.body,
  });
}