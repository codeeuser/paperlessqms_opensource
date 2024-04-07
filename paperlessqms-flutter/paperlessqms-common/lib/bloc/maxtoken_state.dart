part of 'maxtoken_bloc.dart';

@immutable
sealed class MaxtokenState {}

class MaxtokenLoadingState extends MaxtokenState {
  MaxtokenLoadingState();
}

class MaxtokenLoadedState extends MaxtokenState {
  final List<MaxtokenModel> maxtokens;
  MaxtokenLoadedState({
    required this.maxtokens,
  });
}

class MaxtokenOneLoadedState extends MaxtokenState {
  final MaxtokenModel maxtoken;
  MaxtokenOneLoadedState({
    required this.maxtoken,
  });
}

class MaxtokenSuccessState extends MaxtokenState {}

class MaxtokenMissingBizState extends MaxtokenState {}

class MaxtokenErrorState extends MaxtokenState {
  final ServerErrorModel error;
  MaxtokenErrorState({
    required this.error,
  });
}