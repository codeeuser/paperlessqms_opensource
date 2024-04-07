import { Injectable } from '@angular/core';
import { HttpClient, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';

import { isPresent } from 'app/core/util/operators';
import { ApplicationConfigService } from 'app/core/config/application-config.service';
import { createRequestOption } from 'app/core/request/request-util';
import { ITokenNumber, NewTokenNumber } from '../token-number.model';

export type PartialUpdateTokenNumber = Partial<ITokenNumber> & Pick<ITokenNumber, 'id'>;

export type EntityResponseType = HttpResponse<ITokenNumber>;
export type EntityArrayResponseType = HttpResponse<ITokenNumber[]>;

@Injectable({ providedIn: 'root' })
export class TokenNumberService {
  protected resourceUrl = this.applicationConfigService.getEndpointFor('api/token-numbers');

  constructor(
    protected http: HttpClient,
    protected applicationConfigService: ApplicationConfigService,
  ) {}

  create(tokenNumber: NewTokenNumber): Observable<EntityResponseType> {
    return this.http.post<ITokenNumber>(this.resourceUrl, tokenNumber, { observe: 'response' });
  }

  update(tokenNumber: ITokenNumber): Observable<EntityResponseType> {
    return this.http.put<ITokenNumber>(`${this.resourceUrl}/${this.getTokenNumberIdentifier(tokenNumber)}`, tokenNumber, {
      observe: 'response',
    });
  }

  partialUpdate(tokenNumber: PartialUpdateTokenNumber): Observable<EntityResponseType> {
    return this.http.patch<ITokenNumber>(`${this.resourceUrl}/${this.getTokenNumberIdentifier(tokenNumber)}`, tokenNumber, {
      observe: 'response',
    });
  }

  find(id: number): Observable<EntityResponseType> {
    return this.http.get<ITokenNumber>(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  query(req?: any): Observable<EntityArrayResponseType> {
    const options = createRequestOption(req);
    return this.http.get<ITokenNumber[]>(this.resourceUrl, { params: options, observe: 'response' });
  }

  delete(id: number): Observable<HttpResponse<{}>> {
    return this.http.delete(`${this.resourceUrl}/${id}`, { observe: 'response' });
  }

  getTokenNumberIdentifier(tokenNumber: Pick<ITokenNumber, 'id'>): number {
    return tokenNumber.id;
  }

  compareTokenNumber(o1: Pick<ITokenNumber, 'id'> | null, o2: Pick<ITokenNumber, 'id'> | null): boolean {
    return o1 && o2 ? this.getTokenNumberIdentifier(o1) === this.getTokenNumberIdentifier(o2) : o1 === o2;
  }

  addTokenNumberToCollectionIfMissing<Type extends Pick<ITokenNumber, 'id'>>(
    tokenNumberCollection: Type[],
    ...tokenNumbersToCheck: (Type | null | undefined)[]
  ): Type[] {
    const tokenNumbers: Type[] = tokenNumbersToCheck.filter(isPresent);
    if (tokenNumbers.length > 0) {
      const tokenNumberCollectionIdentifiers = tokenNumberCollection.map(
        tokenNumberItem => this.getTokenNumberIdentifier(tokenNumberItem)!,
      );
      const tokenNumbersToAdd = tokenNumbers.filter(tokenNumberItem => {
        const tokenNumberIdentifier = this.getTokenNumberIdentifier(tokenNumberItem);
        if (tokenNumberCollectionIdentifiers.includes(tokenNumberIdentifier)) {
          return false;
        }
        tokenNumberCollectionIdentifiers.push(tokenNumberIdentifier);
        return true;
      });
      return [...tokenNumbersToAdd, ...tokenNumberCollection];
    }
    return tokenNumberCollection;
  }
}
