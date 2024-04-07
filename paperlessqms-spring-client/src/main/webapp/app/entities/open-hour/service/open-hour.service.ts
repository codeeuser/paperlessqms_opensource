import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IOpenHour, NewOpenHour } from '../open-hour.model';

export type PartialUpdateOpenHour = Partial<IOpenHour> & Pick<IOpenHour, 'id'>;

export type EntityResponseType = HttpResponse<IOpenHour>;
export type EntityArrayResponseType = HttpResponse<IOpenHour[]>;

@Injectable({ providedIn: 'root' })
export class OpenHourService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/open-hours');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(openHour: NewOpenHour): Observable<EntityResponseType> {
    return this.http.post<IOpenHour>(this.resourceUrl, openHour, { observe: 'response' });
  }

  update(openHour: IOpenHour): Observable<EntityResponseType> {
    return this.http.put<IOpenHour>(`${this.resourceUrl}/${this.getOpenHourIdentifier(openHour)}`, openHour, { observe: 'response' });
  }

  partialUpdate(openHour: PartialUpdateOpenHour): Observable<EntityResponseType> {
    return this.http.patch<IOpenHour>(`${this.resourceUrl}/${this.getOpenHourIdentifier(openHour)}`, openHour, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IOpenHour>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IOpenHour[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getOpenHourIdentifier(openHour: Pick<IOpenHour, 'id'>): number {
    return openHour.id;
  }

  compareOpenHour(o1: Pick<IOpenHour, 'id'> | null, o2: Pick<IOpenHour, 'id'> | null): boolean {
    return o1 && o2 ? this.getOpenHourIdentifier(o1) === this.getOpenHourIdentifier(o2) : o1 === o2;
  }

  addOpenHourToCollectionIfMissing<Type extends Pick<IOpenHour, 'id'>>(
    openHourCollection: Type[],
    ...openHoursToCheck: (Type | null | undefined)[]
  ): Type[] {
    const openHours: Type[] = openHoursToCheck.filter(isPresent);
    if (openHours.length > 0) {
      const openHourCollectionIdentifiers = openHourCollection.map(openHourItem => this.getOpenHourIdentifier(openHourItem)!);
      const openHoursToAdd = openHours.filter(openHourItem => {
        const openHourIdentifier = this.getOpenHourIdentifier(openHourItem);
        if (openHourCollectionIdentifiers.includes(openHourIdentifier)) {
          return false;
        }
        openHourCollectionIdentifiers.push(openHourIdentifier);
        return true;
      });
      return [...openHoursToAdd, ...openHourCollection];
    }
    return openHourCollection;
  }
}
