export interface IOpenHour {
  id: number;
  profileBizId?: number | null;
  startHour?: number | null;
  startMin?: number | null;
  endHour?: number | null;
  endMin?: number | null;
  dayNum?: number | null;
  enable?: boolean | null;
  modifiedDate?: number | null;
  createdDate?: number | null;
}

export type NewOpenHour = Omit<IOpenHour, 'id'> & { id: null };
