import { IOpenHour, NewOpenHour } from './open-hour.model';

export const sampleWithRequiredData: IOpenHour = {
  id: 25113,
  profileBizId: 15338,
  startHour: 8786,
  startMin: 3107,
  endHour: 85,
  endMin: 3092,
  dayNum: 12104,
};

export const sampleWithPartialData: IOpenHour = {
  id: 14539,
  profileBizId: 32564,
  startHour: 15579,
  startMin: 27267,
  endHour: 10875,
  endMin: 15984,
  dayNum: 28427,
  modifiedDate: 18141,
  createdDate: 5226,
};

export const sampleWithFullData: IOpenHour = {
  id: 3144,
  profileBizId: 1166,
  startHour: 24133,
  startMin: 23218,
  endHour: 31202,
  endMin: 26781,
  dayNum: 20735,
  enable: false,
  modifiedDate: 10400,
  createdDate: 7600,
};

export const sampleWithNewData: NewOpenHour = {
  profileBizId: 8893,
  startHour: 7741,
  startMin: 7626,
  endHour: 9312,
  endMin: 16031,
  dayNum: 7498,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
