part of 'agent_bloc.dart';

@immutable
sealed class AgentEvent {}

class AgentResetEvent extends AgentEvent {}

class AgentLoadAllEvent extends AgentEvent {
  final bool? enable;
  AgentLoadAllEvent({
    this.enable,
  });
}

class AgentLoadOneEvent extends AgentEvent {
  final int id;
  AgentLoadOneEvent({
    required this.id,
  });
}

class AgentLoadByDepartmentEvent extends AgentEvent {
  final int departmentId;
  final bool? enable;
  AgentLoadByDepartmentEvent({
    required this.departmentId,
    this.enable,
  });
}

class AgentAddEvent extends AgentEvent {
  final AgentModel agent;
  AgentAddEvent({
    required this.agent,
  });
}

class AgentUpdateEvent extends AgentEvent {
  final AgentModel agent;
  AgentUpdateEvent({
    required this.agent,
  });
}

class AgentRemoveEvent extends AgentEvent {
  final AgentModel agent;
  AgentRemoveEvent({
    required this.agent,
  });
}

class AgentSearchEvent extends AgentEvent {
  final String text;
  AgentSearchEvent({
    required this.text,
  });
}

class AgentEnableEvent extends AgentEvent {
  final AgentModel agent;
  final bool enable;
  AgentEnableEvent({
    required this.agent,
    required this.enable,
  });
}

class AgentSaveOrUpdateEvent extends AgentEvent {
  final int? id;
  final String login;
  final bool enable;
  final QueueDepartmentModel queueDepartment;
  final QueueTerminalModel queueTerminal;
  AgentSaveOrUpdateEvent({
    this.id,
    required this.login,
    required this.enable,
    required this.queueDepartment,
    required this.queueTerminal,
  });
}
