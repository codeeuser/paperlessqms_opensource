part of 'openhour_bloc.dart';

@immutable
sealed class OpenhourState {}

class OpenhourLoadingState extends OpenhourState {
  OpenhourLoadingState();
}

class OpenhourLoadedState extends OpenhourState {
  final List<OpenhourModel> openhours;
  OpenhourLoadedState({
    required this.openhours,
  });
}

class OpenhourOneLoadedState extends OpenhourState {
  final OpenhourModel openhour;
  OpenhourOneLoadedState({
    required this.openhour,
  });
}

class OpenhourSuccessState extends OpenhourState {}

class OpenhourMissingBizState extends OpenhourState {}

class OpenhourErrorState extends OpenhourState {
  final ServerErrorModel error;
  OpenhourErrorState({
    required this.error,
  });
}