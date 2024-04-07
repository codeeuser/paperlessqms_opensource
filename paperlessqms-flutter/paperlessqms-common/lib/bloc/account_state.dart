part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

class AccountLoadingState extends AccountState {
  AccountLoadingState();
}

class AccountLoadedState extends AccountState {
  final AccountModel? account;
  AccountLoadedState({
    this.account,
  });
}

class AccountOneLoadedState extends AccountState {
  final AccountModel account;
  AccountOneLoadedState({
    required this.account,
  });
}

class AccountSuccessState extends AccountState {}

class AccountErrorState extends AccountState {
  final ServerErrorModel error;
  AccountErrorState({
    required this.error,
  });
}