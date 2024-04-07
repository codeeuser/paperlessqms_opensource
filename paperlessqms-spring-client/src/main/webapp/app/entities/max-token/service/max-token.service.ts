import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { IMaxToken, NewMaxToken } from '../max-token.model';

export type PartialUpdateMaxToken = Partial<IMaxToken> & Pick<IMaxToken, 'id'>;

export type EntityResponseType = HttpResponse<IMaxToken>;
export type EntityArrayResponseType = HttpResponse<IMaxToken[]>;

@Injectable({ providedIn: 'root' })
export class MaxTokenService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/max-tokens');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(maxToken: NewMaxToken): Observable<EntityResponseType> {
    return this.http.post<IMaxToken>(this.resourceUrl, maxToken, { observe: 'response' });
  }

  update(maxToken: IMaxToken): Observable<EntityResponseType> {
    return this.http.put<IMaxToken>(`${this.resourceUrl}/${this.getMaxTokenIdentifier(maxToken)}`, maxToken, { observe: 'response' });
  }

  partialUpdate(maxToken: PartialUpdateMaxToken): Observable<EntityResponseType> {
    return this.http.patch<IMaxToken>(`${this.resourceUrl}/${this.getMaxTokenIdentifier(maxToken)}`, maxToken, { observe: 'response' });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<IMaxToken>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<IMaxToken[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getMaxTokenIdentifier(maxToken: Pick<IMaxToken, 'id'>): number {
    return maxToken.id;
  }

  compareMaxToken(o1: Pick<IMaxToken, 'id'> | null, o2: Pick<IMaxToken, 'id'> | null): boolean {
    return o1 && o2 ? this.getMaxTokenIdentifier(o1) === this.getMaxTokenIdentifier(o2) : o1 === o2;
  }

  addMaxTokenToCollectionIfMissing<Type extends Pick<IMaxToken, 'id'>>(
    maxTokenCollection: Type[],
    ...maxTokensToCheck: (Type | null | undefined)[]
  ): Type[] {
    const maxTokens: Type[] = maxTokensToCheck.filter(isPresent);
    if (maxTokens.length > 0) {
      const maxTokenCollectionIdentifiers = maxTokenCollection.map(maxTokenItem => this.getMaxTokenIdentifier(maxTokenItem)!);
      const maxTokensToAdd = maxTokens.filter(maxTokenItem => {
        const maxTokenIdentifier = this.getMaxTokenIdentifier(maxTokenItem);
        if (maxTokenCollectionIdentifiers.includes(maxTokenIdentifier)) {
          return false;
        }
        maxTokenCollectionIdentifiers.push(maxTokenIdentifier);
        return true;
      });
      return [...maxTokensToAdd, ...maxTokenCollection];
    }
    return maxTokenCollection;
  }
}
