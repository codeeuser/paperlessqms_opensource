import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IAgent, NewAgent } from '../agent.model';

export type PartialUpdateAgent = Partial<IAgent> & Pick<IAgent, 'id'>;

export type EntityResponseType = HttpResponse<IAgent>;
export type EntityArrayResponseType = HttpResponse<IAgent[]>;

@Injectable({ providedIn: 'root' })
export class AgentService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/agents');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(agent: NewAgent): Observable<EntityResponseType> {
    return this.http.post<IAgent>(this.resourceUrl, agent, { observe: 'response' });
  }

  update(agent: IAgent): Observable<EntityResponseType> {
    return this.http.put<IAgent>(`${this.resourceUrl}/${this.getAgentIdentifier(agent)}`, agent, { observe: 'response' });
  }

  partialUpdate(agent: PartialUpdateAgent): Observable<EntityResponseType> {
    return this.http.patch<IAgent>(`${this.resourceUrl}/${this.getAgentIdentifier(agent)}`, agent, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IAgent>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IAgent[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getAgentIdentifier(agent: Pick<IAgent, 'id'>): number {
    return agent.id;
  }

  compareAgent(o1: Pick<IAgent, 'id'> | null, o2: Pick<IAgent, 'id'> | null): boolean {
    return o1 && o2 ? this.getAgentIdentifier(o1) === this.getAgentIdentifier(o2) : o1 === o2;
  }

  addAgentToCollectionIfMissing<Type extends Pick<IAgent, 'id'>>(
    agentCollection: Type[],
    ...agentsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const agents: Type[] = agentsToCheck.filter(isPresent);
    if (agents.length > 0) {
      const agentCollectionIdentifiers = agentCollection.map(agentItem => this.getAgentIdentifier(agentItem)!);
      const agentsToAdd = agents.filter(agentItem => {
        const agentIdentifier = this.getAgentIdentifier(agentItem);
        if (agentCollectionIdentifiers.includes(agentIdentifier)) {
          return false;
        }
        agentCollectionIdentifiers.push(agentIdentifier);
        return true;
      });
      return [...agentsToAdd, ...agentCollection];
    }
    return agentCollection;
  }
}
