import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { ITokenIssued, NewTokenIssued } from '../token-issued.model';

export type PartialUpdateTokenIssued = Partial<ITokenIssued> & Pick<ITokenIssued, 'id'>;

export type EntityResponseType = HttpResponse<ITokenIssued>;
export type EntityArrayResponseType = HttpResponse<ITokenIssued[]>;

@Injectable({ providedIn: 'root' })
export class TokenIssuedService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/token-issueds');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(tokenIssued: NewTokenIssued): Observable<EntityResponseType> {
    return this.http.post<ITokenIssued>(this.resourceUrl, tokenIssued, { observe: 'response' });
  }

  update(tokenIssued: ITokenIssued): Observable<EntityResponseType> {
    return this.http.put<ITokenIssued>(`${this.resourceUrl}/${this.getTokenIssuedIdentifier(tokenIssued)}`, tokenIssued, {
      observe: 'response',
    });
  }

  partialUpdate(tokenIssued: PartialUpdateTokenIssued): Observable<EntityResponseType> {
    return this.http.patch<ITokenIssued>(`${this.resourceUrl}/${this.getTokenIssuedIdentifier(tokenIssued)}`, tokenIssued, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<ITokenIssued>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<ITokenIssued[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getTokenIssuedIdentifier(tokenIssued: Pick<ITokenIssued, 'id'>): number {
    return tokenIssued.id;
  }

  compareTokenIssued(o1: Pick<ITokenIssued, 'id'> | null, o2: Pick<ITokenIssued, 'id'> | null): boolean {
    return o1 && o2 ? this.getTokenIssuedIdentifier(o1) === this.getTokenIssuedIdentifier(o2) : o1 === o2;
  }

  addTokenIssuedToCollectionIfMissing<Type extends Pick<ITokenIssued, 'id'>>(
    tokenIssuedCollection: Type[],
    ...tokenIssuedsToCheck: (Type | null | undefined)[]
  ): Type[] {
    const tokenIssueds: Type[] = tokenIssuedsToCheck.filter(isPresent);
    if (tokenIssueds.length > 0) {
      const tokenIssuedCollectionIdentifiers = tokenIssuedCollection.map(
        tokenIssuedItem => this.getTokenIssuedIdentifier(tokenIssuedItem)!,
      );
      const tokenIssuedsToAdd = tokenIssueds.filter(tokenIssuedItem => {
        const tokenIssuedIdentifier = this.getTokenIssuedIdentifier(tokenIssuedItem);
        if (tokenIssuedCollectionIdentifiers.includes(tokenIssuedIdentifier)) {
          return false;
        }
        tokenIssuedCollectionIdentifiers.push(tokenIssuedIdentifier);
        return true;
      });
      return [...tokenIssuedsToAdd, ...tokenIssuedCollection];
    }
    return tokenIssuedCollection;
  }
}
