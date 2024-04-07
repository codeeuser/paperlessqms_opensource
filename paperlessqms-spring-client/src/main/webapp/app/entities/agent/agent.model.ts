import { IQueueTerminal } from 'app/entities/queue-terminal/queue-terminal.model';
import { IQueueDepartment } from 'app/entities/queue-department/queue-department.model';

export interface IAgent {
  id: number;
  profileBizId?: number | null;
  uid?: number | null;
  login?: string | null;
  email?: string | null;
  updateUid?: number | null;
  enable?: boolean | null;
  orderNum?: number | null;
  createdDate?: number | null;
  modifiedDate?: number | null;
  queueTerminal?: IQueueTerminal | null;
  queueDepartment?: IQueueDepartment | null;
}

export type NewAgent = Omit<IAgent, 'id'> & { id: null };
