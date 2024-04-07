part of 'terminal_bloc.dart';

@immutable
sealed class TerminalEvent {}

class TerminalResetEvent extends TerminalEvent {}

class TerminalLoadAllEvent extends TerminalEvent {
  TerminalLoadAllEvent();
}

class TerminalLoadOneEvent extends TerminalEvent {
  final int id;
  TerminalLoadOneEvent({
    required this.id,
  });
}

class TerminalLoadByDepartmentEvent extends TerminalEvent {
  final QueueDepartmentModel department;
  final bool? enable;
  TerminalLoadByDepartmentEvent({
    required this.department,
    this.enable,
  });
}

class TerminalAddEvent extends TerminalEvent {
  final QueueTerminalModel terminal;
  TerminalAddEvent({
    required this.terminal,
  });
}

class TerminalUpdateEvent extends TerminalEvent {
  final QueueTerminalModel terminal;
  TerminalUpdateEvent({
    required this.terminal,
  });
}

class TerminalRemoveEvent extends TerminalEvent {
  final QueueTerminalModel terminal;
  TerminalRemoveEvent({
    required this.terminal,
  });
}

class TerminalSearchEvent extends TerminalEvent {
  final String text;
  TerminalSearchEvent({
    required this.text,
  });
}

class TerminalEnableEvent extends TerminalEvent {
  final QueueTerminalModel terminal;
  final bool enable;
  TerminalEnableEvent({
    required this.terminal,
    required this.enable,
  });
}

class TerminalSaveOrUpdateEvent extends TerminalEvent {
  final int? id;
  final String name;
  final QueueDepartmentModel department;
  TerminalSaveOrUpdateEvent({
    this.id,
    required this.name,
    required this.department,
  });
}
