part of 'token_bloc.dart';

@immutable
sealed class TokenState {}

final class TokenInitial extends TokenState {}

class TokenLoadingState extends TokenState {
  TokenLoadingState();
}

class TokenLoadedVisitorState extends TokenState {
  final List<TokenIssuedModel> tokens;
  TokenLoadedVisitorState({
    required this.tokens,
  });
}

class TokenLoadedCallState extends TokenState {
  final List<TokenIssuedModel> tokens;
  TokenLoadedCallState({
    required this.tokens,
  });
}

class TokenLoadedListState extends TokenState {
  final List<TokenIssuedModel> tokens;
  TokenLoadedListState({
    required this.tokens,
  });
}

class TokenLoadedCompletedState extends TokenState {
  final List<TokenIssuedModel> tokens;
  TokenLoadedCompletedState({
    required this.tokens,
  });
}

class TokenOneLoadedState extends TokenState {
  final TokenIssuedModel token;
  final AgentModel? agent;
  final QueueTerminalModel? terminal;
  final ProfileBizModel? biz;
  TokenOneLoadedState({
    required this.token,
    this.agent,
    this.terminal,
    this.biz,
  });
}

class TokenCountLoadedState extends TokenState {
  final StatRatingStatus statRatingStatus;
  TokenCountLoadedState({
    required this.statRatingStatus,
  });
}

class TokenCountByBizWithStatusLoadedState extends TokenState {
  final StatCountStatus statCountStatus;
  TokenCountByBizWithStatusLoadedState({
    required this.statCountStatus,
  });
}

class TokenCountHomeState extends TokenState {
  final int countCall;
  final int countList;
  TokenCountHomeState({
    required this.countCall,
    required this.countList,
  });
}

class TokenMissingAccountState extends TokenState {}

class TokenMissingBizState extends TokenState {}

class TokenTransferedState extends TokenState {}

class TokenInvalidHourState extends TokenState {}

class TokenInvalidTokenState extends TokenState {}

class TokenSuccessState extends TokenState {}

class TokenInvalidMaxState extends TokenState {
  final int? count;
  TokenInvalidMaxState({
    this.count,
  });
}

class TokenFailureState extends TokenState {}

class TokenSameState extends TokenState {
  final String sToken;
  TokenSameState({
    required this.sToken,
  });
}

class TokenErrorState extends TokenState {
  final ServerErrorModel error;
  TokenErrorState({
    required this.error,
  });
}