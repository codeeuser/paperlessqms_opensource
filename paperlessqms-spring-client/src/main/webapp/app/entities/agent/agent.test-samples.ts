import { IAgent, NewAgent } from './agent.model';

export const sampleWithRequiredData: IAgent = {
  id: 17046,
  profileBizId: 9300,
  uid: 398,
  login: 'after reassuringly majestically',
  email: 'Matilde42@gmail.com',
};

export const sampleWithPartialData: IAgent = {
  id: 22003,
  profileBizId: 18270,
  uid: 12915,
  login: 'shakily drat quart',
  email: 'Brock_Roberts@yahoo.com',
  orderNum: 27033,
  modifiedDate: 7692,
};

export const sampleWithFullData: IAgent = {
  id: 16971,
  profileBizId: 13615,
  uid: 25322,
  login: 'phooey optimist leap',
  email: 'Romaine.Schuster63@gmail.com',
  updateUid: 9879,
  enable: true,
  orderNum: 12186,
  createdDate: 16633,
  modifiedDate: 30881,
};

export const sampleWithNewData: NewAgent = {
  profileBizId: 13643,
  uid: 29080,
  login: 'pace',
  email: 'Justus_Frami@hotmail.com',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
