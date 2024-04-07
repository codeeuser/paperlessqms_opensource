import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IProfileBiz, NewProfileBiz } from '../profile-biz.model';

export type PartialUpdateProfileBiz = Partial<IProfileBiz> & Pick<IProfileBiz, 'id'>;

export type EntityResponseType = HttpResponse<IProfileBiz>;
export type EntityArrayResponseType = HttpResponse<IProfileBiz[]>;

@Injectable({ providedIn: 'root' })
export class ProfileBizService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/profile-bizs');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(profileBiz: NewProfileBiz): Observable<EntityResponseType> {
    return this.http.post<IProfileBiz>(this.resourceUrl, profileBiz, { observe: 'response' });
  }

  update(profileBiz: IProfileBiz): Observable<EntityResponseType> {
    return this.http.put<IProfileBiz>(`${this.resourceUrl}/${this.getProfileBizIdentifier(profileBiz)}`, profileBiz, {
      observe: 'response',
    });
  }

  partialUpdate(profileBiz: PartialUpdateProfileBiz): Observable<EntityResponseType> {
    return this.http.patch<IProfileBiz>(`${this.resourceUrl}/${this.getProfileBizIdentifier(profileBiz)}`, profileBiz, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IProfileBiz>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IProfileBiz[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getProfileBizIdentifier(profileBiz: Pick<IProfileBiz, 'id'>): number {
    return profileBiz.id;
  }

  compareProfileBiz(o1: Pick<IProfileBiz, 'id'> | null, o2: Pick<IProfileBiz, 'id'> | null): boolean {
    return o1 && o2 ? this.getProfileBizIdentifier(o1) === this.getProfileBizIdentifier(o2) : o1 === o2;
  }

  addProfileBizToCollectionIfMissing<Type extends Pick<IProfileBiz, 'id'>>(
    profileBizCollection: Type[],
    ...profileBizsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const profileBizs: Type[] = profileBizsToCheck.filter(isPresent);
    if (profileBizs.length > 0) {
      const profileBizCollectionIdentifiers = profileBizCollection.map(profileBizItem => this.getProfileBizIdentifier(profileBizItem)!);
      const profileBizsToAdd = profileBizs.filter(profileBizItem => {
        const profileBizIdentifier = this.getProfileBizIdentifier(profileBizItem);
        if (profileBizCollectionIdentifiers.includes(profileBizIdentifier)) {
          return false;
        }
        profileBizCollectionIdentifiers.push(profileBizIdentifier);
        return true;
      });
      return [...profileBizsToAdd, ...profileBizCollection];
    }
    return profileBizCollection;
  }
}
