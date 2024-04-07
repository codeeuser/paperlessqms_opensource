import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/maxtoken_model.dart';
import 'package:common/repositories/maxtoken_repository.dart';

part 'maxtoken_event.dart';
part 'maxtoken_state.dart';

class MaxtokenBloc extends Bloc<MaxtokenEvent, MaxtokenState> {
  final MaxtokenRepository repository;
  final BizRepository bizRepository;
  MaxtokenBloc({
    required this.repository,
    required this.bizRepository}) : super(MaxtokenLoadingState()) {
    on<MaxtokenResetEvent>(_resetEvent);
    on<MaxtokenLoadAllEvent>(_loadAllEvent);
    on<MaxtokenLoadOneEvent>(_loadOneEvent);
    on<MaxtokenAddEvent>(_addEvent);
    on<MaxtokenUpdateEvent>(_updateEvent);
    on<MaxtokenRemoveEvent>(_removeEvent);
    on<MaxtokenSearchEvent>(_searchEvent);
    on<MaxtokenSaveOrUpdateEvent>(_saveOrUpdateEvent);
    on<MaxtokenByBizEvent>(_maxtokenByBizEvent);
  }

  Future<void> _resetEvent(MaxtokenResetEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
  }

  Future<void> _loadAllEvent(MaxtokenLoadAllEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(MaxtokenMissingBizState());
      return;
    }
    dynamic data = await repository.getMaxtokenList(profileBiz);
    if (data is ServerErrorModel) {
      emit(MaxtokenErrorState(error: data));
      return;
    }
    emit(MaxtokenLoadedState(maxtokens: data??[]));
  }

  Future<void> _loadOneEvent(MaxtokenLoadOneEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
    final id  = ev.id;
    final maxtoken = await repository.getMaxtoken(id);
    emit(MaxtokenOneLoadedState(maxtoken: maxtoken));
  }

  Future<void> _addEvent(MaxtokenAddEvent ev, Emitter<MaxtokenState> emit) async{ 

  }

  Future<void> _updateEvent(MaxtokenUpdateEvent ev, Emitter<MaxtokenState> emit) async{ 

  }

  Future<void> _removeEvent(MaxtokenRemoveEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
    final maxtoken = ev.maxtoken;
    dynamic data = await repository.deleteMaxtoken(maxtoken);
    if (data is ServerErrorModel) {
      emit(MaxtokenErrorState(error: data));
    } else {
      add(MaxtokenLoadAllEvent());
    }
  }

  Future<void> _searchEvent(MaxtokenSearchEvent ev, Emitter<MaxtokenState> emit) async{ 
  
  }

  Future<void> _saveOrUpdateEvent(MaxtokenSaveOrUpdateEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(MaxtokenMissingBizState());
      return;
    }
    final id = ev.id;
    final dayNum = ev.dayNum;
    final max = ev.maxToken;
    MaxtokenModel maxtoken = MaxtokenModel(
      id: id,
      dayNum: dayNum,
      maxToken: max,
      profileBizId: profileBiz.id,
    );

    DateTime now = DateTime.now();
    dynamic data;
    if (maxtoken.id == null) {
      // SAVE
      maxtoken.createdDate = now.millisecondsSinceEpoch;
      maxtoken.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.saveMaxtoken(maxtoken);
    } else {
      // UPDATE
      maxtoken.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.updateMaxtoken(maxtoken);
    }
    if (data is ServerErrorModel) {
      emit(MaxtokenErrorState(error: data));
      return;
    } 
    add(MaxtokenLoadOneEvent(id: data.id));
    emit(MaxtokenSuccessState());
  }

  Future<void> _maxtokenByBizEvent(MaxtokenByBizEvent ev, Emitter<MaxtokenState> emit) async{ 
    emit(MaxtokenLoadingState());
    final biz = ev.biz;
    final enable = ev.enable;
    dynamic data = await repository.findMaxtokenByBiz(biz, enable: enable);
    if (data is ServerErrorModel) {
      emit(MaxtokenErrorState(error: data));
      return;
    } 
    emit(MaxtokenLoadedState(maxtokens: data??[]));
  }
}
