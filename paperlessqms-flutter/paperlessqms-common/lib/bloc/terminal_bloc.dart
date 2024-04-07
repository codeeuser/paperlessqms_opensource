import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'terminal_event.dart';
part 'terminal_state.dart';

class TerminalBloc extends Bloc<TerminalEvent, TerminalState> {
  final TerminalRepository repository;
  final DepartmentRepository departmentRepository;
  final BizRepository bizRepository;
  TerminalBloc({
    required this.repository,
    required this.departmentRepository,
    required this.bizRepository}) : super(TerminalLoadingState()) {
    on<TerminalResetEvent>(_resetEvent);
    on<TerminalLoadAllEvent>(_loadAllEvent);
    on<TerminalLoadOneEvent>(_loadOneEvent);
    on<TerminalLoadByDepartmentEvent>(_loadByDepartmentEvent);
    on<TerminalAddEvent>(_addEvent);
    on<TerminalUpdateEvent>(_updateEvent);
    on<TerminalRemoveEvent>(_removeEvent);
    on<TerminalSearchEvent>(_searchEvent);
    on<TerminalEnableEvent>(_enableEvent);
    on<TerminalSaveOrUpdateEvent>(_saveOrUpdateEvent);
  }

  Future<void> _resetEvent(TerminalResetEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
  }

  Future<void> _loadAllEvent(TerminalLoadAllEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(TerminalMissingBizState());
      return;
    }

    final data = await repository.getQueueTerminalList(profileBiz);
    final error = ServerErrorModel.fromMap(data);
    if (error.data!=null) {
      emit(TerminalErrorState(error: error));
      return;
    } 
    for (QueueTerminalModel ter in data??[]) {
      final dep = await departmentRepository.getQueueDepartment(ter.queueDepartment?.id);
      ter.queueDepartment = dep;
    }
    emit(TerminalLoadedState(terminals: data??[]));
  }

  Future<void> _loadOneEvent(TerminalLoadOneEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final id  = ev.id;
    final terminal = await repository.getQueueTerminal(id);
    emit(TerminalOneLoadedState(terminal: terminal));
  }

  Future<void> _loadByDepartmentEvent(TerminalLoadByDepartmentEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final department  = ev.department;
    final enable = ev.enable;
    dynamic data = await repository.findTerminalByDepartment(department, enable: enable);
    if (data is ServerErrorModel) {
      emit(TerminalErrorState(error: data));
      return;
    }
    emit(TerminalLoadedState(terminals: data));
  }

  Future<void> _addEvent(TerminalAddEvent ev, Emitter<TerminalState> emit) async{ 

  }

  Future<void> _updateEvent(TerminalUpdateEvent ev, Emitter<TerminalState> emit) async{ 

  }

  Future<void> _removeEvent(TerminalRemoveEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final terminal = ev.terminal;
    dynamic data = await repository.deleteTerminal(terminal);
    if (data is ServerErrorModel) {
      emit(TerminalErrorState(error: data));
    } else {
      add(TerminalLoadAllEvent());
    }
  }

  Future<void> _searchEvent(TerminalSearchEvent ev, Emitter<TerminalState> emit) async{ 

  }

  Future<void> _enableEvent(TerminalEnableEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final terminal = ev.terminal;
    final enable = ev.enable;

    terminal.enable = enable;
    dynamic data = await repository.updateTerminal(terminal);
    if (data is ServerErrorModel) {
      emit(TerminalErrorState(error: data));
    } else if (data is QueueTerminalModel){
      add(TerminalLoadAllEvent());
    }
  }

  Future<void> _saveOrUpdateEvent(TerminalSaveOrUpdateEvent ev, Emitter<TerminalState> emit) async{ 
    emit(TerminalLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(TerminalMissingBizState());
      return;
    }

    final id = ev.id;
    final department = ev.department;
    final name = ev.name.trim();
    QueueTerminalModel terminal = QueueTerminalModel(
      id: id,
      name: name,
      profileBizId: profileBiz.id,
      queueDepartment: department,
      enable: false,
    );
    DateTime now = DateTime.now();
    dynamic data;
    if (terminal.id == null) {
      // SAVE
      terminal.createdDate = now.millisecondsSinceEpoch;
      terminal.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.saveTerminal(terminal);
    } else {
      // UPDATE
      terminal.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.updateTerminal(terminal);
    }
    if (data is ServerErrorModel) {
      emit(TerminalErrorState(error: data));
      return;
    } 
    add(TerminalLoadOneEvent(id: data.id));
    emit(TerminalSuccessState());
  }
}
