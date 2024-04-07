import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/maxtoken_model.dart';
import 'package:common/models/openhour_model.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/models/stat_count_status.dart';
import 'package:common/models/stat_rating_status.dart';
import 'package:common/models/token_issued_model.dart';
import 'package:common/models/token_number_model.dart';
import 'package:common/repositories/agent_repository.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/maxtoken_repository.dart';
import 'package:common/repositories/number_repository.dart';
import 'package:common/repositories/openhour_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:common/repositories/token_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'token_event.dart';
part 'token_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final SharedPreferences prefs;
  final TokenRepository repository;
  final BizRepository bizRepository;
  final DepartmentRepository departmentRepository;
  final NumberRepository numberRepository;
  final TokenRepository tokenRepository;
  final TerminalRepository terminalRepository;
  final OpenhourRepository openhourRepository;
  final MaxtokenRepository maxtokenRepository;
  final AgentRepository agentRepository;
  TokenBloc({
    required this.prefs,
    required this.repository,
    required this.bizRepository,
    required this.departmentRepository,
    required this.numberRepository,
    required this.tokenRepository,
    required this.terminalRepository,
    required this.openhourRepository,
    required this.maxtokenRepository,
    required this.agentRepository}) : super(TokenLoadingState()) {
    on<TokenResetEvent>(_resetEvent);
    on<TokenLoadAllEvent>(_loadAllEvent);
    on<TokenLoadOneEvent>(_loadOneEvent);
    on<TokenAddEvent>(_addEvent);
    on<TokenUpdateEvent>(_updateEvent);
    on<TokenRemoveEvent>(_removeEvent);
    on<TokenSearchEvent>(_searchEvent);
    on<TokenResetNumberEvent>(_resetNumberEvent);
    on<TokenCountRatingByBizAndDayEvent>(_countRatingByBizAndDayEvent);
    on<TokenCountByBizAndDayEvent>(_countByBizAndDayEvent);
    on<TokenCountHomeEvent>(_countHomeEvent);
    on<TokenByDepartmentWithStatusEvent>(_tokenByDepartmentWithStatusEvent);
    on<TokenByUidWithStatusEvent>(_tokenByUidWithStatusEvent);
    on<TokenByAgentWithStatusEvent>(_tokenByAgentWithStatusEvent);
    on<TokenWithQrEvent>(_tokenWithQrEvent);
    on<TokenNewEvent>(_tokenNewEvent);
  }

  Future<void> _resetEvent(TokenResetEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
  }

  Future<void> _loadAllEvent(TokenLoadAllEvent ev, Emitter<TokenState> emit) async{ 

  }

  Future<void> _loadOneEvent(TokenLoadOneEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final id = ev.id;
    dynamic data = await repository.getTokenIssued(id);
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    if (data is TokenIssuedModel){
      final biz = await bizRepository.findProfileBizById(data.profileBizId);
      data.profileBiz = biz;
    }
    emit(TokenOneLoadedState(token: data));
  }

  Future<void> _addEvent(TokenAddEvent ev, Emitter<TokenState> emit) async{ 

  }

  Future<void> _updateEvent(TokenUpdateEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final token = ev.token;

    dynamic dataOld = await repository.getTokenIssued(token.id);
    final tokenOld = (dataOld is TokenIssuedModel)? dataOld: null;
    if (tokenOld==token){
      String sToken = '${token.tokenLetter}-${token.tokenNumber}';
      emit(TokenSameState(sToken: sToken));
      return;
    }
    await repository.updateTokenIssued(token);
    emit(TokenSuccessState());
  }

  Future<void> _removeEvent(TokenRemoveEvent ev, Emitter<TokenState> emit) async{ 

  }

  Future<void> _searchEvent(TokenSearchEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final text = ev.text;
    final agentId = ev.agentId;
    final statues = ev.statues; 
    final reset = ev.reset;
    dynamic data = await repository.searchNumber(text, agentId, statues, reset: reset);
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    emit(TokenLoadedCompletedState(tokens: data??[]));
  }

  Future<void> _resetNumberEvent(TokenResetNumberEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(TokenMissingBizState());
      return;
    }
    final reset = ev.reset;
    dynamic dataDep = await departmentRepository.getQueueDepartmentList(profileBiz);
      if (dataDep is ServerErrorModel){
        emit(TokenErrorState(error: dataDep));
        return;
      }
      for (QueueDepartmentModel dep in dataDep??[]) {
        dynamic dataNumber = await numberRepository.findTokenNumberByDepartment(dep, reset: false);
        if (dataNumber is ServerErrorModel){
          emit(TokenErrorState(error: dataNumber));
          return;
        }
        for (TokenNumberModel number in dataNumber) {
          number.reset = reset;
          dynamic dataNumber2 = await numberRepository.updateTokenNumber(number);
          if (dataNumber2 is ServerErrorModel){
            emit(TokenErrorState(error: dataNumber2));
            return;
          }
        }
        dynamic dataTokenList = await tokenRepository.findTokenIssuedByDepartmentWithStatus(dep.id, [], reset: false);
        if (dataTokenList is ServerErrorModel){
          emit(TokenErrorState(error: dataTokenList));
          return;
        }
        for (TokenIssuedModel issued in dataTokenList??[]) {
          issued.reset = reset;
          await tokenRepository.updateTokenIssued(issued);
        }
      }
  }

  Future<void> _countRatingByBizAndDayEvent(TokenCountRatingByBizAndDayEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(TokenMissingBizState());
      return;
    }
    int countOne = await repository.countRatingdByBiz(profileBiz.id, [RatingCode.one]);
    int countTwo = await repository.countRatingdByBiz(profileBiz.id, [RatingCode.two]);
    int countThree = await repository.countRatingdByBiz(profileBiz.id, [RatingCode.three]);
    int countFour = await repository.countRatingdByBiz(profileBiz.id, [RatingCode.four]);
    int countFive = await repository.countRatingdByBiz(profileBiz.id, [RatingCode.five]);

    final day = ev.totalDay;
    final ratingCode = ev.ratingCode;
    DateTime now = DateTime.now();
    List<(DateTime, int)> dateCountList = [];
    for (var i = day-1; i >= 0; i--) {
      DateTime dt = now.subtract(Duration(days: i));
      int day = dt.day;
      int dateCount = await repository.countRatingByBizAndDayAndMonthAndYearAndRating(profileBiz.id, day, now.month, now.year, ratingCode);
      dateCountList.add((dt, dateCount));
    }
    final statRatingStatus = StatRatingStatus(
      countOne: countOne,
      countTwo: countTwo,
      countThree: countThree,
      countFour: countFour,
      countFive: countFive,
      dateCountList: dateCountList,
    );
    emit(TokenCountLoadedState(statRatingStatus: statRatingStatus));
  }

  Future<void> _countByBizAndDayEvent(TokenCountByBizAndDayEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(TokenMissingBizState());
      return;
    }
    int? countWait = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.onwait]);
    int? countQueue = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.onqueue]);
    int? countCompleted = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.completed]);
    int? countRecall = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.recall]);
    int? countTimeout = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.timeout]);
    int? countCancel = await repository.countTokenIssuedByBizWithStatus(profileBiz.id, [StatusCode.cancel]);
    
    DateTime now = DateTime.now();
    final day = ev.totalDay;
    final statusCode = ev.statusCode;
    List<(DateTime, int)> dateCountList = [];
    for (var i = day-1; i >= 0; i--) {
      DateTime dt = now.subtract(Duration(days: i));
      int day = dt.day;
      int dateCount = await repository.countTokenIssuedByBizAndDayAndMonthAndYearAndStatus(profileBiz.id, day, now.month, now.year, statusCode);
      dateCountList.add((dt, dateCount));
    }
    final statCountStatus = StatCountStatus(
      countWait: countWait,
      countQueue: countQueue,
      countCompleted: countCompleted,
      countRecall: countRecall,
      countTimeout: countTimeout,
      countCancel: countCancel,
      dateCountList: dateCountList,
    );
    emit(TokenCountByBizWithStatusLoadedState(statCountStatus: statCountStatus));
  }
  
  Future<void> _countHomeEvent(TokenCountHomeEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final statuesCall = ev.statuesCall; 
    final statuesList = ev.statuesList; 
    final department = ev.department; 
    final terminal = ev.terminal;
    final reset = ev.reset;

    int countCall = await repository.countTokenIssuedByDepartmentWithStatus(
                          department.id,
                          statuesCall,
                          reset: reset);
    int countList = await repository.countTokenIssuedByDepartmentAndTerminalWithStatus(
                          department.id,
                          terminal.id,
                          statuesList,
                          reset: reset);
    emit(TokenCountHomeState(countCall: countCall, countList: countList));                      
  }

  Future<void> _tokenByDepartmentWithStatusEvent(TokenByDepartmentWithStatusEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final department = ev.department; 
    final statues = ev.statues; 
    final reset = ev.reset;
    final page = ev.page;
    final pageSize = ev.pageSize;
    final sortBy = ev.sortBy;
    dynamic data = await repository.findTokenIssuedByDepartmentWithStatus(
      department.id, 
      statues, 
      reset: reset,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy
    );
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    emit(TokenLoadedCallState(tokens: data??[]));
  }

  Future<void> _tokenByUidWithStatusEvent(TokenByUidWithStatusEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final uid = ev.uid; 
    final statues = ev.statues; 
    final reset = ev.reset;
    final page = ev.page;
    final pageSize = ev.pageSize;
    final sortBy = ev.sortBy;
    dynamic data = await repository.findTokenIssuedByUidWithStatus(
      uid, 
      statues, 
      reset: reset,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy
    );
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    for (TokenIssuedModel token in data??[]) {
      dynamic dataBiz = await bizRepository.findProfileBizById(token.profileBizId);
      if (dataBiz is ServerErrorModel){
        emit(TokenErrorState(error: dataBiz));
        return;
      }
      token.profileBiz = dataBiz;
    }
    emit(TokenLoadedVisitorState(tokens: data??[]));
  }

  Future<void> _tokenByAgentWithStatusEvent(TokenByAgentWithStatusEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final agentId = ev.agentId; 
    final statues = ev.statues; 
    final reset = ev.reset;
    final page = ev.page;
    final pageSize = ev.pageSize;
    final sortBy = ev.sortBy;
    dynamic data = await repository.findTokenIssuedByAgentWithStatus(
      agentId, 
      statues, 
      reset: reset,
      page: page,
      pageSize: pageSize,
      sortBy: sortBy
    );
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    if (statues==statues4Completed){
      emit(TokenLoadedCompletedState(tokens: data??[]));
      return;
    } 
    if (statues==statues4List){
      emit(TokenLoadedListState(tokens: data??[]));
      return;
    }
  }

  Future<void> _tokenWithQrEvent(TokenWithQrEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    final tokenId = ev.tokenId;
    final departmentId = ev.departmentId;
    final controller = ev.controller;
    dynamic data = await repository.getTokenIssued(tokenId);
    if (data is ServerErrorModel){
      emit(TokenErrorState(error: data));
      return;
    }
    controller?.dispose();
    int? depId = data.departmentId;
    if (depId!=departmentId){
      emit(TokenInvalidTokenState());
      return;
    }
    if (data is TokenIssuedModel){
      dynamic dataBiz = await bizRepository.findProfileBizById(data.profileBizId);
      dynamic dataTerminal = await terminalRepository.getQueueTerminal(data.terminalId);
      dynamic dataAgent = await agentRepository.getAgent(data.assignedUid);
      data.profileBiz = (dataBiz is ProfileBizModel)? dataBiz: null;
      emit(TokenOneLoadedState(
        token: data,
        agent: (dataAgent is AgentModel)? dataAgent: null,
        terminal: (dataTerminal is QueueTerminalModel)? dataTerminal: null,
        biz: (dataBiz is ProfileBizModel)? dataBiz: null,
      ));
    }
  }

  Future<void> _tokenNewEvent(TokenNewEvent ev, Emitter<TokenState> emit) async{ 
    emit(TokenLoadingState());
    AccountModel? account = PrefsUtils.getAccount(prefs);
    if (account==null) {
      emit(TokenMissingAccountState());
      return; 
    }
    final agent = ev.agent;
    final dep = ev.department;
    final ser = ev.service;
    await createTokenIssued(agent, account, ser, dep, emit);
  }

  Future<void> createTokenIssued(
        AgentModel? agent,
        AccountModel account,
        QueueServiceModel service, 
        QueueDepartmentModel department,
        Emitter<TokenState> emit) async{
    

    DateTime now = DateTime.now();
    final profileBiz = await bizRepository.findProfileBizById(service.profileBizId);
    bool validHour = await checkValidOpenHour(
      prefs, 
      profileBiz
    );
    (bool, int?) validMax = await checkValidMaxToken(
      profileBiz,
      department
    );
    if (validHour==false) {
      // Utils.overlayInfoMessage(msg: S.of(context).closed);
      emit(TokenInvalidHourState());
      return; 
    }
    if (validMax.$1==false) {
      // Utils.overlayInfoMessage(msg: '${S.of(context).reachedMaxToken} [${validMax.$2}]');
      emit(TokenInvalidMaxState(count: validMax.$2));
      return; 
    }

    TokenNumberModel tokenNumber = TokenNumberModel(
      serviceId: service.id,
      number: service.start,
      departmentId: service.queueDepartment?.id,  
      reset: false,    
    );
    dynamic dataCount = await numberRepository.countTokenNumberByDepartmentAndService(department, service, reset: false);
    int count = (dataCount is int)? dataCount: 0;
    dynamic dataNextNumber;
    if (count==0){
      dataNextNumber = await numberRepository.saveTokenNumber(tokenNumber);
    } else {
      dataNextNumber = await numberRepository.nextTokenNumber(tokenNumber);
    }
    final tokenNumberNew = (dataNextNumber is TokenNumberModel)? dataNextNumber: null;
    if (tokenNumberNew!=null){
      TokenIssuedModel tokenIssued = TokenIssuedModel(
        serviceId: service.id,
        serviceName: service.name,
        tokenLetter: service.letter,
        tokenNumber: tokenNumberNew.number,
        uid: account.id,
        departmentId: department.id,
        departmentName: department.name,
        profileBizId: service.profileBizId,
        bizName: profileBiz?.bizName,
        statusName: Status.onwait,
        statusCode: StatusCode.onwait,
        isAbsent: false,
        isCancel: false,
        isCompleted: false,
        isPending: true,
        isQueue: false,
        isRecall: false,
        isReject: false,
        isTimeout: false,
        userEmail: account.email,
        userFirstName: account.firstName,
        userLastName: account.lastName,
        issuedFrom: QmsPlatform.client.name,
        createdTimeZoneName: now.timeZoneName,
        createdTimeZoneOffset: now.timeZoneOffset.inHours,
        createdDate: now.millisecondsSinceEpoch,
        createdDay: now.day,
        createdHour: now.hour,
        createdMin: now.minute,
        createdMonth: now.month,
        createdYear: now.year,
        createdNow: now.toIso8601String(),
        modifiedDate: now.millisecondsSinceEpoch,
        modifiedTimeZoneName: now.timeZoneName,
        modifiedTimeZoneOffset: now.timeZoneOffset.inHours,
        modifiedDay: now.day,
        modifiedHour: now.hour,
        modifiedMin: now.minute,
        modifiedMonth: now.month,
        modifiedYear: now.year,
        modifiedNow: now.toIso8601String(),
        reset: false,
      );
      final tokenIssuedNew = await tokenRepository.saveTokenIssued(tokenIssued);
      
      if (tokenIssuedNew!=null && tokenIssuedNew is TokenIssuedModel){
        dynamic dataBiz = await bizRepository.findProfileBizById(tokenIssuedNew.profileBizId);
        dynamic dataTerminal = await terminalRepository.getQueueTerminal(agent?.queueTerminal?.id);
        tokenIssuedNew.profileBiz = (dataBiz is ProfileBizModel)? dataBiz: null;
        emit(TokenOneLoadedState(
          token: tokenIssuedNew,
          biz: (dataBiz is ProfileBizModel)? dataBiz: null,
          terminal: (dataTerminal is QueueTerminalModel)? dataTerminal: null,
          agent: agent,
        ));
      } else {
        emit(TokenFailureState());
      }
    } else {
      emit(TokenFailureState());
    }
  }

  Future<bool> checkValidOpenHour(
        prefs, 
        profileBiz) async{
    DateTime now = DateTime.now();
    int dayNum = now.weekday;

    dynamic dataOpenhourList = await openhourRepository.findOpenhourByBizAndDay(profileBiz, dayNum, enable: true);
    final openhourList = Utils.handleResponseList<OpenhourModel>(dataOpenhourList, null);
    OpenhourModel? configHour;
    if(openhourList.isNotEmpty){
      configHour = openhourList.last;
    }

    int? startHour = configHour?.startHour;
    int? startMin = configHour?.startMin;
    int? endHour = configHour?.endHour;
    int? endMin = configHour?.endMin;
    if (startHour!=null && startMin!=null && endHour!=null && endMin!=null){
      final start = DateTime(now.year, now.month, now.day, startHour, startMin);
      final end = DateTime(now.year, now.month, now.day, endHour, endMin);
      if (now.isBefore(start) || now.isAfter(end)){
        return false;
      }
    }
    return true;
  }

  Future<(bool, int?)> checkValidMaxToken(
        profileBiz,
        department) async{
    DateTime now = DateTime.now();
    int dayNum = now.weekday;

    dynamic dataMaxtokenList = await maxtokenRepository.findMaxtokenByBizAndDay(profileBiz, dayNum, enable: true);
    final maxtokenList = Utils.handleResponseList<MaxtokenModel>(dataMaxtokenList, null);
    MaxtokenModel? configMaxToken;
    if(maxtokenList.isNotEmpty){
      configMaxToken = maxtokenList.last;
    }

    if(configMaxToken!=null){
      int max = configMaxToken.maxToken?? 0;
      int countTotalToken = await tokenRepository.countTokenIssuedByDepartment(department.id, reset: false);
      if (countTotalToken >= max){
        return (false, max);
      }
    }
    return (true, null);
  }
}
