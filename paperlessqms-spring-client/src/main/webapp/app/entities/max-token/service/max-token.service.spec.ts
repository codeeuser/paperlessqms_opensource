import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IMaxToken } from '../max-token.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../max-token.test-samples';

import { MaxTokenService } from './max-token.service';

const requireRestSample: IMaxToken = {
  ...sampleWithRequiredData,
};

describe('MaxToken Service', () => {
  let service: MaxTokenService;
  let httpMock: HttpTestingController;
  let expectedResult: IMaxToken | IMaxToken[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(MaxTokenService);
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

    it('should create a MaxToken', () => {
      const maxToken = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(maxToken).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a MaxToken', () => {
      const maxToken = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(maxToken).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a MaxToken', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of MaxToken', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a MaxToken', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addMaxTokenToCollectionIfMissing', () => {
      it('should add a MaxToken to an empty array', () => {
        const maxToken: IMaxToken = sampleWithRequiredData;
        expectedResult = service.addMaxTokenToCollectionIfMissing([], maxToken);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(maxToken);
      });

      it('should not add a MaxToken to an array that contains it', () => {
        const maxToken: IMaxToken = sampleWithRequiredData;
        const maxTokenCollection: IMaxToken[] = [
          {
            ...maxToken,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addMaxTokenToCollectionIfMissing(maxTokenCollection, maxToken);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a MaxToken to an array that doesn't contain it", () => {
        const maxToken: IMaxToken = sampleWithRequiredData;
        const maxTokenCollection: IMaxToken[] = [sampleWithPartialData];
        expectedResult = service.addMaxTokenToCollectionIfMissing(maxTokenCollection, maxToken);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(maxToken);
      });

      it('should add only unique MaxToken to an array', () => {
        const maxTokenArray: IMaxToken[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const maxTokenCollection: IMaxToken[] = [sampleWithRequiredData];
        expectedResult = service.addMaxTokenToCollectionIfMissing(maxTokenCollection, ...maxTokenArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const maxToken: IMaxToken = sampleWithRequiredData;
        const maxToken2: IMaxToken = sampleWithPartialData;
        expectedResult = service.addMaxTokenToCollectionIfMissing([], maxToken, maxToken2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(maxToken);
        expect(expectedResult).toContain(maxToken2);
      });

      it('should accept null and undefined values', () => {
        const maxToken: IMaxToken = sampleWithRequiredData;
        expectedResult = service.addMaxTokenToCollectionIfMissing([], null, maxToken, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(maxToken);
      });

      it('should return initial array if no MaxToken is added', () => {
        const maxTokenCollection: IMaxToken[] = [sampleWithRequiredData];
        expectedResult = service.addMaxTokenToCollectionIfMissing(maxTokenCollection, undefined, null);
        expect(expectedResult).toEqual(maxTokenCollection);
      });
    });

    describe('compareMaxToken', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareMaxToken(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareMaxToken(entity1, entity2);
        const compareResult2 = service.compareMaxToken(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareMaxToken(entity1, entity2);
        const compareResult2 = service.compareMaxToken(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareMaxToken(entity1, entity2);
        const compareResult2 = service.compareMaxToken(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
