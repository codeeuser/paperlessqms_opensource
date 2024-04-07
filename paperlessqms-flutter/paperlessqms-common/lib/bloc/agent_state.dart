part of 'agent_bloc.dart';

@immutable
sealed class AgentState {}

class AgentLoadingState extends AgentState {
  AgentLoadingState();
}

class AgentLoadedState extends AgentState {
  final List<AgentModel> agents;
  AgentLoadedState({
    required this.agents,
  });
}

class AgentOneLoadedState extends AgentState {
  final AgentModel agent;
  AgentOneLoadedState({
    required this.agent,
  });
}

class AgentSuccessState extends AgentState {}

class AgentMissingBizState extends AgentState {}

class AgentExistState extends AgentState {}

class AgentErrorState extends AgentState {
  final ServerErrorModel error;
  AgentErrorState({
    required this.error,
  });
}