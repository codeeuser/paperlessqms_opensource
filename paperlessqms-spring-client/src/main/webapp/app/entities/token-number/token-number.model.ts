export interface ITokenNumber {
  id: number;
  number?: number | null;
  departmentId?: number | null;
  serviceId?: number | null;
  reset?: boolean | null;
}

export type NewTokenNumber = Omit<ITokenNumber, 'id'> & { id: null };
