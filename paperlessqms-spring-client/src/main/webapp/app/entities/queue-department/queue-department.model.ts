import { IAgent } from 'app/entities/agent/agent.model';
import { IQueueTerminal } from 'app/entities/queue-terminal/queue-terminal.model';
import { IQueueService } from 'app/entities/queue-service/queue-service.model';

export interface IQueueDepartment {
  id: number;
  profileBizId?: number | null;
  bizName?: string | null;
  bizCategoryName?: string | null;
  name?: string | null;
  desc?: string | null;
  lat?: number | null;
  lng?: number | null;
  timeZone?: number | null;
  threshold?: number | null;
  nearbyRange?: number | null;
  tokenTimeoutMin?: number | null;
  selected?: boolean | null;
  enable?: boolean | null;
  orderNum?: number | null;
  currencySymbol?: string | null;
  lenMetric?: string | null;
  currencyCode?: string | null;
  bannerName?: string | null;
  createdDate?: number | null;
  modifiedDate?: number | null;
  agents?: IAgent[] | null;
  queueTerminals?: IQueueTerminal[] | null;
  queueServices?: IQueueService[] | null;
}

export type NewQueueDepartment = Omit<IQueueDepartment, 'id'> & { id: null };
