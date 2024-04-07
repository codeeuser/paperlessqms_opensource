export interface IProfileBiz {
  id: number;
  bizName?: string | null;
  bizLogoBase64?: string | null;
  bizPhotoBase64?: string | null;
  bizAddress?: string | null;
  bizLevel?: number | null;
  bizEmail?: string | null;
  bizPhoneNumber?: string | null;
  bizPhoneCode?: string | null;
  bizPhoneIsoCode?: string | null;
  bizWebsite?: string | null;
  bizDesc?: string | null;
  enable?: boolean | null;
  createdByUid?: number | null;
  updatedByUid?: number | null;
  modifiedDate?: number | null;
  createdDate?: number | null;
}

export type NewProfileBiz = Omit<IProfileBiz, 'id'> & { id: null };
