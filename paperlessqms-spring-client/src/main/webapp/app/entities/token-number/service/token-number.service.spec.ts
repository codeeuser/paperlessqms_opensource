import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { ITokenNumber } from '../token-number.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../token-number.test-samples';

import { TokenNumberService } from './token-number.service';

const requireRestSample: ITokenNumber = {
  ...sampleWithRequiredData,
};

describe('TokenNumber Service', () => {
  let service: TokenNumberService;
  let httpMock: HttpTestingController;
  let expectedResult: ITokenNumber | ITokenNumber[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(TokenNumberService);
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

    it('should create a TokenNumber', () => {
      const tokenNumber = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(tokenNumber).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a TokenNumber', () => {
      const tokenNumber = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(tokenNumber).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a TokenNumber', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of TokenNumber', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a TokenNumber', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addTokenNumberToCollectionIfMissing', () => {
      it('should add a TokenNumber to an empty array', () => {
        const tokenNumber: ITokenNumber = sampleWithRequiredData;
        expectedResult = service.addTokenNumberToCollectionIfMissing([], tokenNumber);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tokenNumber);
      });

      it('should not add a TokenNumber to an array that contains it', () => {
        const tokenNumber: ITokenNumber = sampleWithRequiredData;
        const tokenNumberCollection: ITokenNumber[] = [
          {
            ...tokenNumber,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addTokenNumberToCollectionIfMissing(tokenNumberCollection, tokenNumber);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a TokenNumber to an array that doesn't contain it", () => {
        const tokenNumber: ITokenNumber = sampleWithRequiredData;
        const tokenNumberCollection: ITokenNumber[] = [sampleWithPartialData];
        expectedResult = service.addTokenNumberToCollectionIfMissing(tokenNumberCollection, tokenNumber);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tokenNumber);
      });

      it('should add only unique TokenNumber to an array', () => {
        const tokenNumberArray: ITokenNumber[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const tokenNumberCollection: ITokenNumber[] = [sampleWithRequiredData];
        expectedResult = service.addTokenNumberToCollectionIfMissing(tokenNumberCollection, ...tokenNumberArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const tokenNumber: ITokenNumber = sampleWithRequiredData;
        const tokenNumber2: ITokenNumber = sampleWithPartialData;
        expectedResult = service.addTokenNumberToCollectionIfMissing([], tokenNumber, tokenNumber2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(tokenNumber);
        expect(expectedResult).toContain(tokenNumber2);
      });

      it('should accept null and undefined values', () => {
        const tokenNumber: ITokenNumber = sampleWithRequiredData;
        expectedResult = service.addTokenNumberToCollectionIfMissing([], null, tokenNumber, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(tokenNumber);
      });

      it('should return initial array if no TokenNumber is added', () => {
        const tokenNumberCollection: ITokenNumber[] = [sampleWithRequiredData];
        expectedResult = service.addTokenNumberToCollectionIfMissing(tokenNumberCollection, undefined, null);
        expect(expectedResult).toEqual(tokenNumberCollection);
      });
    });

    describe('compareTokenNumber', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareTokenNumber(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareTokenNumber(entity1, entity2);
        const compareResult2 = service.compareTokenNumber(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareTokenNumber(entity1, entity2);
        const compareResult2 = service.compareTokenNumber(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareTokenNumber(entity1, entity2);
        const compareResult2 = service.compareTokenNumber(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
