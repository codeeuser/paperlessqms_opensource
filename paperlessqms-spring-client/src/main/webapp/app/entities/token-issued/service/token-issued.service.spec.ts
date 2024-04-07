import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { ITokenIssued } from '../token-issued.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../token-issued.test-samples';

import { TokenIssuedService } from './token-issued.service';

const requireRestSample: ITokenIssued = {
  ...sampleWithRequiredData,
};

describe('TokenIssued Service', () => {
  let service: TokenIssuedService;
  let httpMock: HttpTestingController;
  let expectedResult: ITokenIssued | ITokenIssued[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(TokenIssuedService);
    httpMock = TestBed.inject(HttpTestingController);
  });

  describe('Service methods', () => {
    it('should find an element', () => {
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.find(123).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should create a TokenIssued', () => {
      const tokenIssued = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(tokenIssued).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a TokenIssued', () => {
      const tokenIssued = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(tokenIssued).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a TokenIssued', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of TokenIssued', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a TokenIssued', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addTokenIssuedToCollectionIfMissing', () => {
      it('should add a TokenIssued to an empty array', () => {
        const tokenIssued: ITokenIssued = sampleWithRequiredData;
        expectedResult = service.addTokenIssuedToCollectionIfMissing([], tokenIssued);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tokenIssued);
      });

      it('should not add a TokenIssued to an array that contains it', () => {
        const tokenIssued: ITokenIssued = sampleWithRequiredData;
        const tokenIssuedCollection: ITokenIssued[] = [
          {
            ...tokenIssued,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addTokenIssuedToCollectionIfMissing(tokenIssuedCollection, tokenIssued);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a TokenIssued to an array that doesn't contain it", () => {
        const tokenIssued: ITokenIssued = sampleWithRequiredData;
        const tokenIssuedCollection: ITokenIssued[] = [sampleWithPartialData];
        expectedResult = service.addTokenIssuedToCollectionIfMissing(tokenIssuedCollection, tokenIssued);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tokenIssued);
      });

      it('should add only unique TokenIssued to an array', () => {
        const tokenIssuedArray: ITokenIssued[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const tokenIssuedCollection: ITokenIssued[] = [sampleWithRequiredData];
        expectedResult = service.addTokenIssuedToCollectionIfMissing(tokenIssuedCollection, ...tokenIssuedArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const tokenIssued: ITokenIssued = sampleWithRequiredData;
        const tokenIssued2: ITokenIssued = sampleWithPartialData;
        expectedResult = service.addTokenIssuedToCollectionIfMissing([], tokenIssued, tokenIssued2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tokenIssued);
        expect(expectedResult).toContain(tokenIssued2);
      });

      it('should accept null and undefined values', () => {
        const tokenIssued: ITokenIssued = sampleWithRequiredData;
        expectedResult = service.addTokenIssuedToCollectionIfMissing([], null, tokenIssued, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tokenIssued);
      });

      it('should return initial array if no TokenIssued is added', () => {
        const tokenIssuedCollection: ITokenIssued[] = [sampleWithRequiredData];
        expectedResult = service.addTokenIssuedToCollectionIfMissing(tokenIssuedCollection, undefined, null);
        expect(expectedResult).toEqual(tokenIssuedCollection);
      });
    });

    describe('compareTokenIssued', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareTokenIssued(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareTokenIssued(entity1, entity2);
        const compareResult2 = service.compareTokenIssued(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareTokenIssued(entity1, entity2);
        const compareResult2 = service.compareTokenIssued(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareTokenIssued(entity1, entity2);
        const compareResult2 = service.compareTokenIssued(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
