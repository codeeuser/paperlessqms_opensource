import { IQueueTerminal, NewQueueTerminal } from './queue-terminal.model';

export const sampleWithRequiredData: IQueueTerminal = {
  id: 21867,
  profileBizId: 31628,
  name: 'unto miserably',
};

export const sampleWithPartialData: IQueueTerminal = {
  id: 4860,
  profileBizId: 29265,
  name: 'smoodge',
  enable: true,
  createdDate: 8132,
  modifiedDate: 15405,
};

export const sampleWithFullData: IQueueTerminal = {
  id: 24736,
  profileBizId: 16313,
  name: 'imperfect naughty austere',
  enable: false,
  orderNum: 20634,
  createdDate: 6804,
  modifiedDate: 29694,
};

export const sampleWithNewData: NewQueueTerminal = {
  profileBizId: 22760,
  name: 'split yahoo meanwhile',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
