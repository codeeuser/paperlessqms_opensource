import { ITokenNumber, NewTokenNumber } from './token-number.model';

export const sampleWithRequiredData: ITokenNumber = {
  id: 124,
};

export const sampleWithPartialData: ITokenNumber = {
  id: 785,
};

export const sampleWithFullData: ITokenNumber = {
  id: 21827,
  number: 10375,
  departmentId: 32530,
  serviceId: 896,
  reset: false,
};

export const sampleWithNewData: NewTokenNumber = {
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
