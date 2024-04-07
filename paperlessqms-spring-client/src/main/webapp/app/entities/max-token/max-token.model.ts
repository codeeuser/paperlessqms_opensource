export interface IMaxToken {
  id: number;
  profileBizId?: number | null;
  maxToken?: number | null;
  dayNum?: number | null;
  modifiedDate?: number | null;
  createdDate?: number | null;
}

export type NewMaxToken = Omit<IMaxToken, 'id'> & { id: null };
