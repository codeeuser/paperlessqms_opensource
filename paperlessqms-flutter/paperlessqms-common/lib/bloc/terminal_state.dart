part of 'terminal_bloc.dart';

@immutable
sealed class TerminalState {}

class TerminalLoadingState extends TerminalState {
  TerminalLoadingState();
}

class TerminalLoadedState extends TerminalState {
  final List<QueueTerminalModel> terminals;
  TerminalLoadedState({
    required this.terminals,
  });
}

class TerminalOneLoadedState extends TerminalState {
  final QueueTerminalModel terminal;
  TerminalOneLoadedState({
    required this.terminal,
  });
}

class TerminalSuccessState extends TerminalState {}

class TerminalMissingBizState extends TerminalState {}

class TerminalTransferedState extends TerminalState {}

class TerminalErrorState extends TerminalState {
  final ServerErrorModel error;
  TerminalErrorState({
    required this.error,
  });
}