import { IQueueDepartment, NewQueueDepartment } from './queue-department.model';

export const sampleWithRequiredData: IQueueDepartment = {
  id: 13566,
  profileBizId: 11592,
  bizName: 'exfoliate',
  name: 'bonding',
};

export const sampleWithPartialData: IQueueDepartment = {
  id: 11653,
  profileBizId: 11063,
  bizName: 'paltry',
  bizCategoryName: 'zucchini rapid',
  name: 'why analogy while',
  desc: 'outmaneuver between',
  lng: 12476.25,
  timeZone: 20446,
  threshold: 28941,
  nearbyRange: 25947,
  tokenTimeoutMin: 22517,
  selected: false,
  enable: false,
  orderNum: 5746,
  currencySymbol: '$',
  lenMetric: 'along oh mid',
  bannerName: 'clumsy',
  createdDate: 32116,
};

export const sampleWithFullData: IQueueDepartment = {
  id: 1330,
  profileBizId: 11580,
  bizName: 'brr down youthfully',
  bizCategoryName: 'gee round',
  name: 'gah',
  desc: 'finally ha',
  lat: 24044.24,
  lng: 16814.57,
  timeZone: 31886,
  threshold: 24166,
  nearbyRange: 26199,
  tokenTimeoutMin: 31441,
  selected: false,
  enable: false,
  orderNum: 1588,
  currencySymbol: 'kr',
  lenMetric: 'curvy ah uh-huh',
  currencyCode: 'TWD',
  bannerName: 'since ick',
  createdDate: 18148,
  modifiedDate: 25071,
};

export const sampleWithNewData: NewQueueDepartment = {
  profileBizId: 1896,
  bizName: 'miserably titter than',
  name: 'where dim',
  id: null,
};

Object.freeze(sampleWithNewData);
Object.freeze(sampleWithRequiredData);
Object.freeze(sampleWithPartialData);
Object.freeze(sampleWithFullData);
