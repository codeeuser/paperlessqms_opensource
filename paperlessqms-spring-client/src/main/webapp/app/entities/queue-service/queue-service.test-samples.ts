import { IQueueService, NewQueueService } from './queue-service.model';

export const sampleWithRequiredData: IQueueService = {
  id: 13838,
  profileBizId: 6949,
  name: 'censor gaze',
};

export const sampleWithPartialData: IQueueService = {
  id: 23860,
  profileBizId: 22921,
  name: 'supposing mull',
  type: 'mantle which yuck',
  desc: 'eventually consequently disinfect',
  createdDate: 9657,
  modifiedDate: 2895,
};

export const sampleWithFullData: IQueueService = {
  id: 11487,
  profileBizId: 5029,
  name: 'how colossal',
  type: 'almond to',
  letter: 'ack',
  start: 27286,
  desc: 'yieldingly surprised',
  enable: true,
  orderNum: 3409,
  enableCatalog: false,
  createdDate: 14960,
  modifiedDate: 8454,
};

export const sampleWithNewData: NewQueueService = {
  profileBizId: 2804,
  name: 'creative',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
