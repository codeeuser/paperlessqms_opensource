import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IQueueTerminal, NewQueueTerminal } from '../queue-terminal.model';

export type PartialUpdateQueueTerminal = Partial<IQueueTerminal> & Pick<IQueueTerminal, 'id'>;

export type EntityResponseType = HttpResponse<IQueueTerminal>;
export type EntityArrayResponseType = HttpResponse<IQueueTerminal[]>;

@Injectable({ providedIn: 'root' })
export class QueueTerminalService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/queue-terminals');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(queueTerminal: NewQueueTerminal): Observable<EntityResponseType> {
    return this.http.post<IQueueTerminal>(this.resourceUrl, queueTerminal, { observe: 'response' });
  }

  update(queueTerminal: IQueueTerminal): Observable<EntityResponseType> {
    return this.http.put<IQueueTerminal>(`${this.resourceUrl}/${this.getQueueTerminalIdentifier(queueTerminal)}`, queueTerminal, {
      observe: 'response',
    });
  }

  partialUpdate(queueTerminal: PartialUpdateQueueTerminal): Observable<EntityResponseType> {
    return this.http.patch<IQueueTerminal>(`${this.resourceUrl}/${this.getQueueTerminalIdentifier(queueTerminal)}`, queueTerminal, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IQueueTerminal>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IQueueTerminal[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getQueueTerminalIdentifier(queueTerminal: Pick<IQueueTerminal, 'id'>): number {
    return queueTerminal.id;
  }

  compareQueueTerminal(o1: Pick<IQueueTerminal, 'id'> | null, o2: Pick<IQueueTerminal, 'id'> | null): boolean {
    return o1 && o2 ? this.getQueueTerminalIdentifier(o1) === this.getQueueTerminalIdentifier(o2) : o1 === o2;
  }

  addQueueTerminalToCollectionIfMissing<Type extends Pick<IQueueTerminal, 'id'>>(
    queueTerminalCollection: Type[],
    ...queueTerminalsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const queueTerminals: Type[] = queueTerminalsToCheck.filter(isPresent);
    if (queueTerminals.length > 0) {
      const queueTerminalCollectionIdentifiers = queueTerminalCollection.map(
        queueTerminalItem => this.getQueueTerminalIdentifier(queueTerminalItem)!,
      );
      const queueTerminalsToAdd = queueTerminals.filter(queueTerminalItem => {
        const queueTerminalIdentifier = this.getQueueTerminalIdentifier(queueTerminalItem);
        if (queueTerminalCollectionIdentifiers.includes(queueTerminalIdentifier)) {
          return false;
        }
        queueTerminalCollectionIdentifiers.push(queueTerminalIdentifier);
        return true;
      });
      return [...queueTerminalsToAdd, ...queueTerminalCollection];
    }
    return queueTerminalCollection;
  }
}
