import 'dart:convert';

import 'package:common/models/account_model.dart';
import 'package:common/models/agent_model.dart';
import 'package:common/models/maxtoken_model.dart';
import 'package:common/models/openhour_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/agent_repository.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/maxtoken_repository.dart';
import 'package:common/repositories/openhour_repository.dart';
import 'package:common/repositories/service_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:common/models/profile_biz_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'biz_event.dart';
part 'biz_state.dart';

class BizBloc extends Bloc<BizEvent, BizState> {
  final SharedPreferences prefs;
  final BizRepository repository;
  final OpenhourRepository openhourRepository;
  final MaxtokenRepository maxtokenRepository;
  final DepartmentRepository departmentRepository;
  final ServiceRepository serviceRepository;
  final TerminalRepository terminalRepository;
  final AgentRepository agentRepository;
  BizBloc({
    required this.prefs,
    required this.repository,
    required this.openhourRepository,
    required this.maxtokenRepository,
    required this.departmentRepository,
    required this.serviceRepository,
    required this.terminalRepository,
    required this.agentRepository}) : super(BizLoadingState()) {
    on<BizResetEvent>(_resetEvent);
    on<BizLoadAllEvent>(_loadAllEvent);
    on<BizLoadOneEvent>(_loadOneEvent);
    on<BizAddEvent>(_addEvent);
    on<BizUpdateEvent>(_updateEvent);
    on<BizRemoveEvent>(_removeEvent);
    on<BizSearchEvent>(_searchEvent);
    on<BizSaveOrUpdateEvent>(_saveOrUpdateEvent);
    on<BizEnableEvent>(_enableEvent);
    on<BizByIdEvent>(_bizByIdEvent);
  }

  Future<void> _resetEvent(BizResetEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
  }

  Future<void> _loadAllEvent(BizLoadAllEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final page = ev.page;
    final pageSize = ev.pageSize;
    final sortBy = ev.sortBy;
    final enable = ev.enable;
    dynamic data = await repository.getBusinessList(page: page, pageSize: pageSize, sortBy: sortBy, enable: enable);
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
      return;
    } 
    emit(BizLoadedState(bizs: data));
  }

  Future<void> _loadOneEvent(BizLoadOneEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    dynamic data = await repository.getProfileBiz();
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
      return;
    }
    if (data==null){
      emit(BizMissingBizState());
      return;
    }
    emit(BizOneLoadedState(biz: data));
  }

  Future<void> _addEvent(BizAddEvent ev, Emitter<BizState> emit) async{ 

  }

  Future<void> _updateEvent(BizUpdateEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final biz = ev.biz;
    await repository.updateBusiness(biz);
  }

  Future<void> _removeEvent(BizRemoveEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final biz = ev.biz;
    // handle delete agent
    dynamic dataAgent = await agentRepository.getAgentList(biz);
    if (dataAgent is List<AgentModel>){
      for (AgentModel agent in dataAgent) {
        await agentRepository.deleteAgent(agent);
      }
    }

    // handle delete terminal
    dynamic dataTerminal = await terminalRepository.getQueueTerminalList(biz);
    if (dataTerminal is List<QueueTerminalModel>){
      for (QueueTerminalModel terminal in dataTerminal) {
        await terminalRepository.deleteTerminal(terminal);
      }
    }

    // handle delete department & service
    dynamic dataDepartment = await departmentRepository.getQueueDepartmentList(biz);
    if (dataDepartment is List<QueueDepartmentModel>){
      for (QueueDepartmentModel dep in dataDepartment) {
        dynamic dataService = await serviceRepository.findServiceByDepartment(dep);
        if (dataService is List<QueueServiceModel>){
          for (QueueServiceModel service in dataService) {
            await serviceRepository.deleteService(service);
          }
        }
        await departmentRepository.deleteDepartment(dep);
      }
    }

    // handle delete openhour
    dynamic dataHour = await openhourRepository.getOpenhourList(biz);
    if (dataHour is List<OpenhourModel>){
      for (OpenhourModel hour in dataHour) {
        await openhourRepository.deleteOpenhour(hour);
      }
    }
    // handle delete maxtoken
    dynamic dataMax = await maxtokenRepository.getMaxtokenList(biz);
    if (dataMax is List<MaxtokenModel>){
      for (MaxtokenModel max in dataMax) {
        await maxtokenRepository.deleteMaxtoken(max);
      }
    }
    // handle delete biz
    dynamic data = await repository.deleteBiz(biz);
    if (data is ServerErrorModel){
      emit(BizErrorState(error: data));
      return;
    }
    add(BizLoadOneEvent());
  }

  Future<void> _searchEvent(BizSearchEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final text = ev.text;
    dynamic data = await repository.search(text, true);
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
      return;
    } 
    emit(BizLoadedState(bizs: data??[]));
  }

  Future<void> _saveOrUpdateEvent(BizSaveOrUpdateEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final accountJson = prefs.getString(Prefs.account);
    AccountModel? account;
    if (accountJson!=null){
      account = AccountModel.fromMap(jsonDecode(accountJson));
    } else {
      emit(BizFailureState());
      return;
    }

    final profileBiz = await repository.getProfileBiz();

    final id = ev.id;
    final name = ev.name;
    final desc = ev.desc;
    final phone = ev.phone;
    final email = ev.email;
    final address = ev.address;
    final website = ev.website;
    final bizLogoBase64 = ev.bizLogoBase64;
    final bizPhotoBase64 = ev.bizPhotoBase64;
    ProfileBizModel biz = ProfileBizModel(
      id: id,
      bizName: name,
      bizDesc: desc,
      bizPhoneNumber: phone,
      bizEmail: email,
      bizAddress: address,
      bizWebsite: website,
      bizLevel: profileBiz?.bizLevel??0,
      createdByUid: account.id,
      bizLogoBase64: bizLogoBase64,
      bizPhotoBase64: bizPhotoBase64,
    );
    DateTime now = DateTime.now();
    dynamic data;
    if (biz.id == null) {
      // SAVE
      biz.createdByUid = account.id;
      biz.updatedByUid = account.id;
      biz.createdDate = now.millisecondsSinceEpoch;
      biz.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.saveBusiness(biz);
    } else {
      // UPDATE
      biz.updatedByUid = account.id;
      biz.modifiedDate = now.millisecondsSinceEpoch;
      data = await repository.updateBusiness(biz);
    }
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
      return;
    } 
    add(BizLoadOneEvent());
    emit(BizSuccessState());
  }

  Future<void> _enableEvent(BizEnableEvent ev, Emitter<BizState> emit) async{ 
    emit(BizLoadingState());
    final biz = ev.biz;
    final enable = ev.enable;

    biz.enable = enable;
    dynamic data = await repository.updateBusiness(biz);
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
    } else if (data is ProfileBizModel){
      add(BizLoadAllEvent());
    }
  }

  Future<void> _bizByIdEvent(BizByIdEvent ev, Emitter<BizState> emit) async{ 
    final id = ev.id;
    dynamic data = await repository.findProfileBizById(id);
    if (data is ServerErrorModel) {
      emit(BizErrorState(error: data));
      return;
    } 
    if (data==null){
      emit(BizMissingBizState());
      return;
    }
    emit(BizOneLoadedState(biz: data));
  }
}
