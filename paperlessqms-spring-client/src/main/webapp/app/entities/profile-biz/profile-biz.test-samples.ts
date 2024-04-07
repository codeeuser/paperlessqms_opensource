import { IProfileBiz, NewProfileBiz } from './profile-biz.model';

export const sampleWithRequiredData: IProfileBiz = {
  id: 12454,
  bizName: 'selfishly on',
};

export const sampleWithPartialData: IProfileBiz = {
  id: 10791,
  bizName: 'yearly',
  bizLogoBase64: '../fake-data/blob/hipster.txt',
  bizPhoneCode: 'amidst qualified save',
  bizPhoneIsoCode: 'zowie under trowel',
  enable: true,
  createdByUid: 15208,
  createdDate: 10234,
};

export const sampleWithFullData: IProfileBiz = {
  id: 20908,
  bizName: 'interject crow upskill',
  bizLogoBase64: '../fake-data/blob/hipster.txt',
  bizPhotoBase64: '../fake-data/blob/hipster.txt',
  bizAddress: 'transpire',
  bizLevel: 2644,
  bizEmail: 'querulous',
  bizPhoneNumber: 'before a',
  bizPhoneCode: 'bitterly',
  bizPhoneIsoCode: 'fob as nor',
  bizWebsite: 'merrily out despite',
  bizDesc: 'as officially geez',
  enable: false,
  createdByUid: 27312,
  updatedByUid: 6162,
  modifiedDate: 32728,
  createdDate: 22000,
};

export const sampleWithNewData: NewProfileBiz = {
  bizName: 'blazer bail salmon',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
