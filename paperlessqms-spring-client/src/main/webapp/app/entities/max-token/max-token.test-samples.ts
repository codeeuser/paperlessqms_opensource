import { IMaxToken, NewMaxToken } from './max-token.model';

export const sampleWithRequiredData: IMaxToken = {
  id: 1074,
  profileBizId: 18705,
  maxToken: 27630,
  dayNum: 17885,
};

export const sampleWithPartialData: IMaxToken = {
  id: 26308,
  profileBizId: 25478,
  maxToken: 3574,
  dayNum: 3356,
};

export const sampleWithFullData: IMaxToken = {
  id: 1702,
  profileBizId: 18182,
  maxToken: 8425,
  dayNum: 10402,
  modifiedDate: 7460,
  createdDate: 6826,
};

export const sampleWithNewData: NewMaxToken = {
  profileBizId: 30653,
  maxToken: 9444,
  dayNum: 13066,
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
