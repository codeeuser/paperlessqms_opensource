part of 'token_bloc.dart';

@immutable
sealed class TokenEvent {}

class TokenResetEvent extends TokenEvent {}

class TokenLoadAllEvent extends TokenEvent {
  TokenLoadAllEvent();
}

class TokenLoadOneEvent extends TokenEvent {
  final int id;
  TokenLoadOneEvent({
    required this.id,
  });
}

class TokenAddEvent extends TokenEvent {
  final TokenIssuedModel token;
  TokenAddEvent({
    required this.token,
  });
}

class TokenUpdateEvent extends TokenEvent {
  final TokenIssuedModel token;
  TokenUpdateEvent({
    required this.token,
  });
}

class TokenRemoveEvent extends TokenEvent {
  final TokenIssuedModel token;
  TokenRemoveEvent({
    required this.token,
  });
}

class TokenSearchEvent extends TokenEvent {
  final String text;
  final int agentId;
  final List<int> statues; 
  final bool reset;
  TokenSearchEvent({
    required this.text,
    required this.agentId,
    required this.statues,
    required this.reset,
  });
}

class TokenResetNumberEvent extends TokenEvent {
  final bool reset;
  TokenResetNumberEvent({
    required this.reset
  });
}

class TokenCountRatingByBizAndDayEvent extends TokenEvent {
  final int totalDay;
  final int ratingCode;
  TokenCountRatingByBizAndDayEvent({
    required this.totalDay,
    required this.ratingCode,
  });
}

class TokenCountByBizAndDayEvent extends TokenEvent {
  final int totalDay;
  final int statusCode;
  TokenCountByBizAndDayEvent({
    required this.totalDay,
    required this.statusCode,
  });
}

class TokenCountHomeEvent extends TokenEvent {
  final List<int> statuesCall;
  final List<int> statuesList;  
  final QueueDepartmentModel department; 
  final QueueTerminalModel terminal;
  final bool reset;
  TokenCountHomeEvent({
    required this.statuesCall,
    required this.statuesList,
    required this.department,
    required this.terminal,
    required this.reset,
  });
}

class TokenByDepartmentWithStatusEvent extends TokenEvent {
  final QueueDepartmentModel department; 
  final List<int> statues; 
  final bool reset;
  final int? page;
  final int? pageSize;
  final String? sortBy;
  TokenByDepartmentWithStatusEvent({
    required this.department,
    required this.statues,
    required this.reset,
    this.page,
    this.pageSize,
    this.sortBy,
  });
}

class TokenByUidWithStatusEvent extends TokenEvent {
  final int uid;
  final List<int> statues;
  final bool reset;
  final int? page;
  final int? pageSize;
  final String? sortBy;
  TokenByUidWithStatusEvent({
    required this.uid,
    required this.statues,
    required this.reset,
    this.page,
    this.pageSize,
    this.sortBy,
  });
}

class TokenByAgentWithStatusEvent extends TokenEvent {
  final int agentId;
  final List<int> statues; 
  final bool reset;
  final int? page;
  final int? pageSize;
  final String? sortBy;
  TokenByAgentWithStatusEvent({
    required this.agentId,
    required this.statues,
    required this.reset,
    this.page,
    this.pageSize,
    this.sortBy,
  });
}

class TokenNewEvent extends TokenEvent {
  final AgentModel? agent;
  final QueueDepartmentModel department;
  final QueueServiceModel service;
  TokenNewEvent({
    this.agent,
    required this.department,
    required this.service,
  });
}

class TokenWithQrEvent extends TokenEvent {
  final int tokenId;
  final int? departmentId;
  final QRCodeDartScanController? controller;
  TokenWithQrEvent({
    required this.tokenId,
    this.departmentId,
    this.controller,
  });
}