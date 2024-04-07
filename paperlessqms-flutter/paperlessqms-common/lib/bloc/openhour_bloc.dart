import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/openhour_model.dart';
import 'package:common/repositories/openhour_repository.dart';

part 'openhour_event.dart';
part 'openhour_state.dart';

class OpenhourBloc extends Bloc<OpenhourEvent, OpenhourState> {
  final OpenhourRepository repository;
  final BizRepository bizRepository;
  OpenhourBloc({
    required this.repository,
    required this.bizRepository}) : super(OpenhourLoadingState()) {
    on<OpenhourResetEvent>(_resetEvent);
    on<OpenhourLoadAllEvent>(_loadAllEvent);
    on<OpenhourLoadOneEvent>(_loadOneEvent);
    on<OpenhourAddEvent>(_addEvent);
    on<OpenhourUpdateEvent>(_updateEvent);
    on<OpenhourRemoveEvent>(_removeEvent);
    on<OpenhourSearchEvent>(_searchEvent);
    on<OpenhourEnableEvent>(_enableEvent);
    on<OpenhourSaveOrUpdateEvent>(_saveOrUpdateEvent);
    on<OpenhourByBizEvent>(_openhourByBizEvent);
  }

  Future<void> _resetEvent(OpenhourResetEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
  }

  Future<void> _loadAllEvent(OpenhourLoadAllEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(OpenhourMissingBizState());
      return;
    }
    dynamic data = await repository.getOpenhourList(profileBiz);
    if (data is ServerErrorModel) {
      emit(OpenhourErrorState(error: data));
      return;
    }
    emit(OpenhourLoadedState(openhours: data??[]));
  }

  Future<void> _loadOneEvent(OpenhourLoadOneEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final id  = ev.id;
    final openhour = await repository.getOpenhour(id);
    emit(OpenhourOneLoadedState(openhour: openhour));
  }

  Future<void> _addEvent(OpenhourAddEvent ev, Emitter<OpenhourState> emit) async{ 

  }

  Future<void> _updateEvent(OpenhourUpdateEvent ev, Emitter<OpenhourState> emit) async{ 

  }

  Future<void> _removeEvent(OpenhourRemoveEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final openhour = ev.openhour;
    dynamic data = await repository.deleteOpenhour(openhour);
    if (data is ServerErrorModel) {
      emit(OpenhourErrorState(error: data));
      return;
    } 
    add(OpenhourLoadAllEvent());
  }

  Future<void> _searchEvent(OpenhourSearchEvent ev, Emitter<OpenhourState> emit) async{ 

  }

  Future<void> _enableEvent(OpenhourEnableEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final openhour = ev.openhour;
    final enable = ev.enable;

    openhour.enable = enable;
    dynamic data = await repository.updateOpenhour(openhour);
    if (data is ServerErrorModel) {
      emit(OpenhourErrorState(error: data));
      return;
    } 
    add(OpenhourLoadAllEvent());
  }

  Future<void> _saveOrUpdateEvent(OpenhourSaveOrUpdateEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(OpenhourMissingBizState());
      return;
    }
    final id = ev.id;
    final dayNum = ev.dayNum;
    final startHour = ev.startHour;
    final startMin = ev.startMin;
    final endHour = ev.endHour;
    final endMin = ev.endMin;

    OpenhourModel openhour = OpenhourModel(
      id: id,
      dayNum: dayNum,
      enable: false,
      startHour: startHour,
      startMin: startMin,
      endHour: endHour,
      endMin: endMin,
      profileBizId: profileBiz.id,
    );

    DateTime now = DateTime.now();
    dynamic data;
    if (openhour.id == null) {
      // SAVE
      openhour.createdDate = now.millisecondsSinceEpoch;
      openhour.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.saveOpenhour(openhour);
    } else {
      // UPDATE
      openhour.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.updateOpenhour(openhour);
    }
    if (data is ServerErrorModel) {
      emit(OpenhourErrorState(error: data));
      return;
    } 
    add(OpenhourLoadOneEvent(id: data.id));
    emit(OpenhourSuccessState());
  }

  Future<void> _openhourByBizEvent(OpenhourByBizEvent ev, Emitter<OpenhourState> emit) async{ 
    emit(OpenhourLoadingState());
    final biz = ev.biz;
    final enable = ev.enable;
    dynamic data = await repository.findOpenhourByBiz(biz, enable: enable);
    if (data is ServerErrorModel) {
      emit(OpenhourErrorState(error: data));
      return;
    } 
    emit(OpenhourLoadedState(openhours: data??[]));
  }
}
