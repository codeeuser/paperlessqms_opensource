// ignore_for_file: use_build_context_synchronously

import 'package:common/models/profile_biz_model.dart';
import 'package:common/models/queue_department_model.dart';
import 'package:common/models/queue_service_model.dart';
import 'package:common/models/queue_terminal_model.dart';
import 'package:common/models/server_error_model.dart';
import 'package:common/repositories/biz_repository.dart';
import 'package:common/repositories/department_repository.dart';
import 'package:common/repositories/service_repository.dart';
import 'package:common/repositories/terminal_repository.dart';
import 'package:common/utils/constants.dart';
import 'package:common/utils/functions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

part 'department_event.dart';
part 'department_state.dart';

class DepartmentBloc extends Bloc<DepartmentEvent, DepartmentState> {
  final DepartmentRepository repository;
  final ServiceRepository serviceRepository;
  final TerminalRepository terminalRepository;
  final BizRepository bizRepository;
  DepartmentBloc({
    required this.repository,
    required this.serviceRepository,
    required this.terminalRepository,
    required this.bizRepository}) : super(DepartmentLoadingState()) {
    on<DepartmentResetEvent>(_resetEvent);
    on<DepartmentLoadAllEvent>(_loadAllEvent);
    on<DepartmentLoadOneEvent>(_loadOneEvent);
    on<DepartmentAddEvent>(_addEvent);
    on<DepartmentUpdateEvent>(_updateEvent);
    on<DepartmentRemoveEvent>(_removeEvent);
    on<DepartmentSearchEvent>(_searchEvent);
    on<DepartmentEnableEvent>(_enableEvent);
    on<DepartmentDummyEvent>(_dummyEvent);
    on<DepartmentSaveOrUpdateEvent>(_saveOrUpdateEvent);
    on<DepartmentByBizEvent>(_departmentByBizEvent);
    on<DepartmentWithQrEvent>(_departmentWithQrEvent);
  }

  Future<void> _resetEvent(DepartmentResetEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
  }

  Future<void> _loadAllEvent(DepartmentLoadAllEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(DepartmentMissingBizState());
      return;
    }
    final enable = ev.enable;
    final data = await repository.getQueueDepartmentList(profileBiz, enable: enable);
    final error = ServerErrorModel.fromMap(data);
    if (error.data!=null) {
      emit(DepartmentErrorState(error: error));
      return;
    }
    for (QueueDepartmentModel dep in data??[]) {
      final service = await serviceRepository.findServiceByDepartment(dep);
      dep.queueServices = service;
    }
    emit(DepartmentLoadedState(departments: data??[]));
  }

  Future<void> _loadOneEvent(DepartmentLoadOneEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final id  = ev.id;
    final department = await repository.getQueueDepartment(id);
    emit(DepartmentOneLoadedState(department: department));
  }

  Future<void> _addEvent(DepartmentAddEvent ev, Emitter<DepartmentState> emit) async{ 

  }

  Future<void> _updateEvent(DepartmentUpdateEvent ev, Emitter<DepartmentState> emit) async{ 

  }

  Future<void> _removeEvent(DepartmentRemoveEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final dep = ev.department;
    List<QueueTerminalModel> terminalList = await terminalRepository.findTerminalByDepartment(dep);
    if (terminalList.isNotEmpty==true){
      emit(DepartmentErrorTerminalState());
      return;
    }
    List<QueueServiceModel>? serviceList = await serviceRepository.findServiceByDepartment(dep);
    for (QueueServiceModel service in serviceList??[]) {
      dynamic dataService = await serviceRepository.deleteService(service);
      if (dataService is ServerErrorModel) {
        emit(DepartmentErrorState(error: dataService));
        return;
      }
    }
    dynamic data = await repository.deleteDepartment(dep);
    if (data is ServerErrorModel) {
      emit(DepartmentErrorState(error: data));
    } else if (data is String){
      add(DepartmentLoadAllEvent());
    }
  }

  Future<void> _searchEvent(DepartmentSearchEvent ev, Emitter<DepartmentState> emit) async{ 

  }

  Future<void> _enableEvent(DepartmentEnableEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final department = ev.department;
    final enable = ev.enable;

    department.enable = enable;
    dynamic data = await repository.updateDepartment(department);
    if (data is ServerErrorModel) {
      emit(DepartmentErrorState(error: data));
    } else if (data is QueueDepartmentModel){
      add(DepartmentLoadAllEvent());
    }
  }

  Future<void> _dummyEvent(DepartmentDummyEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(DepartmentMissingBizState());
      return;
    }

    DateTime now = DateTime.now();
    String randomText = Utils.generateRandomString(5);
    QueueDepartmentModel dep = QueueDepartmentModel(
      name: 'HR-$randomText',
      desc: 'This is HR Department in town',
      bizName: profileBiz.bizName,
      profileBizId: profileBiz.id,
      enable: false,
      createdDate: now.millisecondsSinceEpoch,
      modifiedDate: now.millisecondsSinceEpoch,
    );
    dynamic dataDep = await repository.saveDepartment(dep);
    if (dataDep is ServerErrorModel) {
      emit(DepartmentErrorState(error: dataDep));
      return;
    }
    
    // first
    QueueServiceModel ser = QueueServiceModel(
      profileBizId: profileBiz.id,
      name: 'Testing-$randomText',
      letter: 'TEST',
      start: 100,
      desc: 'This is Testing for candidate',
      enable: true,
      orderNum: 0,
      queueDepartment: dataDep,
      createdDate: now.millisecondsSinceEpoch,
      modifiedDate: now.millisecondsSinceEpoch,
    );
    await serviceRepository.saveService(ser);

    // second
    QueueServiceModel ser2 = QueueServiceModel(
      profileBizId: profileBiz.id,
      name: 'Interview-$randomText',
      letter: 'INTER',
      start: 200,
      desc: 'This is Interview for candidate',
      enable: true,
      orderNum: 1,
      queueDepartment: dataDep,
      createdDate: now.millisecondsSinceEpoch,
      modifiedDate: now.millisecondsSinceEpoch,
    );
    await serviceRepository.saveService(ser2);

    QueueTerminalModel ter = QueueTerminalModel(
      profileBizId: profileBiz.id,
      queueDepartment: dataDep,
      name: randomText,
      enable: true,
      createdDate: now.millisecondsSinceEpoch,
      modifiedDate: now.millisecondsSinceEpoch,
    );
    await terminalRepository.saveTerminal(ter);

    add(DepartmentLoadAllEvent());
  }

  Future<void> _saveOrUpdateEvent(DepartmentSaveOrUpdateEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final profileBiz = await bizRepository.getProfileBiz();
    if (profileBiz==null){
      emit(DepartmentMissingBizState());
      return;
    }

    int? id = ev.id;
    String name = ev.name.trim();
    String desc = ev.desc.trim(); 
    String banner = ev.banner.trim();              
    QueueDepartmentModel department = QueueDepartmentModel(
      id: id,
      name: name,
      desc: desc,
      bannerName: banner,
      bizName: profileBiz.bizName,
      profileBizId: profileBiz.id,
      enable: false,
    );
    DateTime now = DateTime.now();

    // for QueueDepartment
    dynamic dataDepartment;
    if (department.id==null){ // SAVE
      department.createdDate = now.millisecondsSinceEpoch;
      department.modifiedDate = now.millisecondsSinceEpoch;
      dataDepartment = await repository.saveDepartment(department);
    } else { // UPDATE
      department.modifiedDate = now.millisecondsSinceEpoch;
      dataDepartment = await repository.updateDepartment(department);
    }
    if (dataDepartment is ServerErrorModel) {
      emit(DepartmentErrorState(error: dataDepartment));
      return;
    } 
    if (dataDepartment!=null && dataDepartment is QueueDepartmentModel){
      final serviceList = ev.services;
      final List<QueueServiceModel> list = [];
      for(var i=0; i<serviceList.length; i++){
        QueueServiceModel queueService = serviceList.elementAt(i);
        String? serviceName = queueService.name;
        String? serviceLetter = queueService.letter;
        dynamic serviceStart = queueService.start;
        if (serviceName==null || serviceLetter==null || serviceLetter.isEmpty==true || serviceStart==null || serviceStart is! num){
          continue;
        }
        queueService.name = queueService.name;
        queueService.profileBizId = profileBiz.id;
        queueService.orderNum = i;
        queueService.enable = true;

        if (queueService.name?.isEmpty==true || queueService.letter?.isEmpty==true || queueService.start==null){
          continue;
        }
        dynamic dataService;
        if (queueService.id==null){ // save
          queueService.createdDate = now.millisecondsSinceEpoch;
          queueService.modifiedDate = now.millisecondsSinceEpoch;
          dataService = await serviceRepository.saveService(queueService);
        } else { // Update              
          queueService.modifiedDate = now.millisecondsSinceEpoch;              
          dataService = await serviceRepository.updateService(queueService);                
        }
        if (dataService is ServerErrorModel) {
          emit(DepartmentErrorState(error: dataService));
          return;
        } 
        if (dataService!=null && dataService is QueueServiceModel){
          dataService.key = uuid.v4();
          list.add(dataService);
        }
      }
      int? id = dataDepartment.id;
      if (id!=null){
        add(DepartmentLoadOneEvent(id: id));
      }
      emit(DepartmentSuccessState());
    } 
  }

  Future<void> _departmentByBizEvent(DepartmentByBizEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final biz = ev.biz;
    final enable = ev.enable;
    dynamic data = await repository.getQueueDepartmentList(biz, enable: enable);
    if (data is ServerErrorModel){
      emit(DepartmentErrorState(error: data));
      return;
    }
    emit(DepartmentLoadedState(departments: data??[]));
  }

  Future<void> _departmentWithQrEvent(DepartmentWithQrEvent ev, Emitter<DepartmentState> emit) async{ 
    emit(DepartmentLoadingState());
    final depId = ev.depId;
    final banner = ev.banner;
    final controller = ev.controller;

    dynamic data = await repository.getQueueDepartment(depId);
    if (data is ServerErrorModel){
      emit(DepartmentErrorState(error: data));
      return;
    }
    String sBanner = data?.bannerName??'';
    if (data!=null && sBanner==banner) {
      dynamic dataBiz = await bizRepository.findProfileBizById(data.profileBizId);
      if (dataBiz is ServerErrorModel){
        emit(DepartmentErrorState(error: dataBiz));
        return;
      }
      if (dataBiz==null) return;
      if (controller!=null){
        await controller.dispose();
      }
      dynamic dataDep = await repository.getQueueDepartmentList(dataBiz, enable: true);
      if (dataDep is ServerErrorModel){
        emit(DepartmentErrorState(error: dataDep));
        return;
      }
      emit(DepartmentQrSuccessState(
          department: data,
          biz: dataBiz,
          departments: dataDep,
        )
      );
    }
  }
}
