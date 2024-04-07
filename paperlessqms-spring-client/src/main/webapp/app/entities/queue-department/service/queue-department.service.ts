import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IQueueDepartment, NewQueueDepartment } from '../queue-department.model';

export type PartialUpdateQueueDepartment = Partial<IQueueDepartment> & Pick<IQueueDepartment, 'id'>;

export type EntityResponseType = HttpResponse<IQueueDepartment>;
export type EntityArrayResponseType = HttpResponse<IQueueDepartment[]>;

@Injectable({ providedIn: 'root' })
export class QueueDepartmentService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/queue-departments');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(queueDepartment: NewQueueDepartment): Observable<EntityResponseType> {
    return this.http.post<IQueueDepartment>(this.resourceUrl, queueDepartment, { observe: 'response' });
  }

  update(queueDepartment: IQueueDepartment): Observable<EntityResponseType> {
    return this.http.put<IQueueDepartment>(`${this.resourceUrl}/${this.getQueueDepartmentIdentifier(queueDepartment)}`, queueDepartment, {
      observe: 'response',
    });
  }

  partialUpdate(queueDepartment: PartialUpdateQueueDepartment): Observable<EntityResponseType> {
    return this.http.patch<IQueueDepartment>(`${this.resourceUrl}/${this.getQueueDepartmentIdentifier(queueDepartment)}`, queueDepartment, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IQueueDepartment>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IQueueDepartment[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getQueueDepartmentIdentifier(queueDepartment: Pick<IQueueDepartment, 'id'>): number {
    return queueDepartment.id;
  }

  compareQueueDepartment(o1: Pick<IQueueDepartment, 'id'> | null, o2: Pick<IQueueDepartment, 'id'> | null): boolean {
    return o1 && o2 ? this.getQueueDepartmentIdentifier(o1) === this.getQueueDepartmentIdentifier(o2) : o1 === o2;
  }

  addQueueDepartmentToCollectionIfMissing<Type extends Pick<IQueueDepartment, 'id'>>(
    queueDepartmentCollection: Type[],
    ...queueDepartmentsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const queueDepartments: Type[] = queueDepartmentsToCheck.filter(isPresent);
    if (queueDepartments.length > 0) {
      const queueDepartmentCollectionIdentifiers = queueDepartmentCollection.map(
        queueDepartmentItem => this.getQueueDepartmentIdentifier(queueDepartmentItem)!,
      );
      const queueDepartmentsToAdd = queueDepartments.filter(queueDepartmentItem => {
        const queueDepartmentIdentifier = this.getQueueDepartmentIdentifier(queueDepartmentItem);
        if (queueDepartmentCollectionIdentifiers.includes(queueDepartmentIdentifier)) {
          return false;
        }
        queueDepartmentCollectionIdentifiers.push(queueDepartmentIdentifier);
        return true;
      });
      return [...queueDepartmentsToAdd, ...queueDepartmentCollection];
    }
    return queueDepartmentCollection;
  }
}
