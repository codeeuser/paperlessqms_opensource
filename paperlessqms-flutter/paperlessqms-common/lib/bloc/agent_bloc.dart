import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/account_repository.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/repositories/agent_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'agent_event.dart';
part 'agent_state.dart';

class AgentBloc extends Bloc<AgentEvent, AgentState> {
  final SharedPreferences prefs;
  final AgentRepository repository;
  final BizRepository bizRepository;
  final DepartmentRepository departmentRepository;
  final TerminalRepository terminalRepository;
  final AccountRepository accountRepository;
  AgentBloc({
    required this.prefs,
    required this.repository,
    required this.bizRepository,
    required this.departmentRepository,
    required this.terminalRepository,
    required this.accountRepository}) : super(AgentLoadingState()) {
    on<AgentResetEvent>(_resetEvent);
    on<AgentLoadAllEvent>(_loadAllEvent);
    on<AgentLoadOneEvent>(_loadOneEvent);
    on<AgentLoadByDepartmentEvent>(_loadByDepartmentEvent);
    on<AgentAddEvent>(_addEvent);
    on<AgentUpdateEvent>(_updateEvent);
    on<AgentRemoveEvent>(_removeEvent);
    on<AgentSearchEvent>(_searchEvent);
    on<AgentEnableEvent>(_enableEvent);
    on<AgentSaveOrUpdateEvent>(_saveOrUpdateEvent);
  }

  Future<void> _resetEvent(AgentResetEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
  }

  Future<void> _loadAllEvent(AgentLoadAllEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(AgentMissingBizState());
      return;
    }
    final enable = ev.enable;
    final data = await repository.getAgentList(profileBiz, enable: enable);
    final error = ServerErrorModel.fromMap(data);
    if (error.data!=null) {
      emit(AgentErrorState(error: error));
    }       
    for (AgentModel agent in data??[]) {
      dynamic dataDep = await departmentRepository.getQueueDepartment(agent.queueDepartment?.id);
      if (dataDep is ServerErrorModel) {
        emit(AgentErrorState(error: dataDep));
      }
      dynamic dataTer = await terminalRepository.getQueueTerminal(agent.queueTerminal?.id);
      if (dataTer is ServerErrorModel) {
        emit(AgentErrorState(error: dataTer));
      }
      dynamic dataAcc = await accountRepository.getUser(agent.login);
      if (dataAcc is ServerErrorModel) {
        emit(AgentErrorState(error: dataAcc));
      }

      agent.queueDepartment = dataDep;
      agent.queueTerminal = dataTer;
      agent.account = dataAcc;
    }
    emit(AgentLoadedState(agents: data??[]));
  }

  Future<void> _loadOneEvent(AgentLoadOneEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final id  = ev.id;
    final data = await repository.getAgent(id);
    if (data is ServerErrorModel){
      emit(AgentErrorState(error: data));
      return;
    }
    emit(AgentOneLoadedState(agent: data));
  }

  Future<void> _loadByDepartmentEvent(AgentLoadByDepartmentEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final departmentId  = ev.departmentId;
    final enable = ev.enable;
    dynamic data = await repository.findAgentByDepartment(departmentId, enable: enable);
    if (data is ServerErrorModel){
      emit(AgentErrorState(error: data));
      return;
    }
    for (AgentModel agent in data) {
      final terminal = await terminalRepository.getQueueTerminal(agent.queueTerminal?.id);
      agent.queueTerminal = terminal;
    }
    emit(AgentLoadedState(agents: data));
  }

  Future<void> _addEvent(AgentAddEvent ev, Emitter<AgentState> emit) async{ 

  }

  Future<void> _updateEvent(AgentUpdateEvent ev, Emitter<AgentState> emit) async{ 

  }

  Future<void> _removeEvent(AgentRemoveEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final agent = ev.agent;
    dynamic data = await repository.deleteAgent(agent);
    if (data is ServerErrorModel) {
      emit(AgentErrorState(error: data));
      return;
    } 
    add(AgentLoadAllEvent());
  }

  Future<void> _searchEvent(AgentSearchEvent ev, Emitter<AgentState> emit) async{ 

  }

  Future<void> _enableEvent(AgentEnableEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final agent = ev.agent;
    final enable = ev.enable;

    agent.enable = enable;
    dynamic data = await repository.updateAgent(agent);
    if (data is ServerErrorModel) {
      emit(AgentErrorState(error: data));
      return;
    } 
    add(AgentLoadAllEvent());
  }

  Future<void> _saveOrUpdateEvent(AgentSaveOrUpdateEvent ev, Emitter<AgentState> emit) async{ 
    emit(AgentLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(AgentMissingBizState());
      return;
    }
    final id = ev.id;
    final login = ev.login;
    final enable = ev.enable;
    final queueDepartment = ev.queueDepartment;
    final queueTerminal = ev.queueTerminal;

    dynamic dataAcc = await accountRepository.getUser(login);
    if (dataAcc is ServerErrorModel) {
      emit(AgentErrorState(error: dataAcc));
      return;
    }

    int countAgent = await repository.countAgentByDepartmentAndTerminal(login, queueDepartment.id, queueTerminal.id);
    if (countAgent > 0) {
      emit(AgentExistState());
      return;
    }

    AgentModel agent = AgentModel(
      id: id,
      login: login,
      enable: enable,
      queueDepartment: queueDepartment,
      queueTerminal: queueTerminal,
      email: dataAcc.email,
      uid: dataAcc.id,
      updateUid: PrefsUtils.getAccount(prefs)?.id,
      profileBizId: profileBiz.id,
      orderNum: 0,
    );

    DateTime now = DateTime.now();
    dynamic data;
    if (agent.id == null) {
      // SAVE
      agent.createdDate = now.millisecondsSinceEpoch;
      agent.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.saveAgent(agent);
    } else {
      // UPDATE
      agent.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.updateAgent(agent);
    }
    if (data is ServerErrorModel) {
      emit(AgentErrorState(error: data));
      return;
    } 
    add(AgentLoadOneEvent(id: data.id));
    emit(AgentSuccessState());
  }
}
