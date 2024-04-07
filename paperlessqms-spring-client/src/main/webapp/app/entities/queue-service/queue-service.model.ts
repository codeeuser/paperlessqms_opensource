import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';

export interface IQueueService {
  id: number;
  profileBizId?: number | null;
  name?: string | null;
  type?: string | null;
  letter?: string | null;
  start?: number | null;
  desc?: string | null;
  enable?: boolean | null;
  orderNum?: number | null;
  enableCatalog?: boolean | null;
  createdDate?: number | null;
  modifiedDate?: number | null;
  queueDepartment?: IQueueDepartment | null;
}

export type NewQueueService = Omit<IQueueService, 'id'> & { id: null };
