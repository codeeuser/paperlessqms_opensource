import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';
import { IAgent } from 'app/entities/agent/agent.model';

export interface IQueueTerminal {
  id: number;
  profileBizId?: number | null;
  name?: string | null;
  enable?: boolean | null;
  orderNum?: number | null;
  createdDate?: number | null;
  modifiedDate?: number | null;
  queueDepartment?: IQueueDepartment | null;
  agents?: IAgent[] | null;
}

export type NewQueueTerminal = Omit<IQueueTerminal, 'id'> & { id: null };
