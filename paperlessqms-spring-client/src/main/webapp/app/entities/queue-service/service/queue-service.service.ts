import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IQueueService, NewQueueService } from '../queue-service.model';

export type PartialUpdateQueueService = Partial<IQueueService> & Pick<IQueueService, 'id'>;

export type EntityResponseType = HttpResponse<IQueueService>;
export type EntityArrayResponseType = HttpResponse<IQueueService[]>;

@Injectable({ providedIn: 'root' })
export class QueueServiceService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/queue-services');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(queueService: NewQueueService): Observable<EntityResponseType> {
    return this.http.post<IQueueService>(this.resourceUrl, queueService, { observe: 'response' });
  }

  update(queueService: IQueueService): Observable<EntityResponseType> {
    return this.http.put<IQueueService>(`${this.resourceUrl}/${this.getQueueServiceIdentifier(queueService)}`, queueService, {
      observe: 'response',
    });
  }

  partialUpdate(queueService: PartialUpdateQueueService): Observable<EntityResponseType> {
    return this.http.patch<IQueueService>(`${this.resourceUrl}/${this.getQueueServiceIdentifier(queueService)}`, queueService, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IQueueService>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IQueueService[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getQueueServiceIdentifier(queueService: Pick<IQueueService, 'id'>): number {
    return queueService.id;
  }

  compareQueueService(o1: Pick<IQueueService, 'id'> | null, o2: Pick<IQueueService, 'id'> | null): boolean {
    return o1 && o2 ? this.getQueueServiceIdentifier(o1) === this.getQueueServiceIdentifier(o2) : o1 === o2;
  }

  addQueueServiceToCollectionIfMissing<Type extends Pick<IQueueService, 'id'>>(
    queueServiceCollection: Type[],
    ...queueServicesToCheck: (Type | null | undefined)[]
  ): Type[] {
    const queueServices: Type[] = queueServicesToCheck.filter(isPresent);
    if (queueServices.length > 0) {
      const queueServiceCollectionIdentifiers = queueServiceCollection.map(
        queueServiceItem => this.getQueueServiceIdentifier(queueServiceItem)!,
      );
      const queueServicesToAdd = queueServices.filter(queueServiceItem => {
        const queueServiceIdentifier = this.getQueueServiceIdentifier(queueServiceItem);
        if (queueServiceCollectionIdentifiers.includes(queueServiceIdentifier)) {
          return false;
        }
        queueServiceCollectionIdentifiers.push(queueServiceIdentifier);
        return true;
      });
      return [...queueServicesToAdd, ...queueServiceCollection];
    }
    return queueServiceCollection;
  }
}
