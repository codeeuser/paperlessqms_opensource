import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IOpenHour } from '../open-hour.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../open-hour.test-samples';

import { OpenHourService } from './open-hour.service';

const requireRestSample: IOpenHour = {
  ...sampleWithRequiredData,
};

describe('OpenHour Service', () => {
  let service: OpenHourService;
  let httpMock: HttpTestingController;
  let expectedResult: IOpenHour | IOpenHour[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(OpenHourService);
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

    it('should create a OpenHour', () => {
      const openHour = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(openHour).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a OpenHour', () => {
      const openHour = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(openHour).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a OpenHour', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of OpenHour', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a OpenHour', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addOpenHourToCollectionIfMissing', () => {
      it('should add a OpenHour to an empty array', () => {
        const openHour: IOpenHour = sampleWithRequiredData;
        expectedResult = service.addOpenHourToCollectionIfMissing([], openHour);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(openHour);
      });

      it('should not add a OpenHour to an array that contains it', () => {
        const openHour: IOpenHour = sampleWithRequiredData;
        const openHourCollection: IOpenHour[] = [
          {
            ...openHour,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addOpenHourToCollectionIfMissing(openHourCollection, openHour);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a OpenHour to an array that doesn't contain it", () => {
        const openHour: IOpenHour = sampleWithRequiredData;
        const openHourCollection: IOpenHour[] = [sampleWithPartialData];
        expectedResult = service.addOpenHourToCollectionIfMissing(openHourCollection, openHour);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(openHour);
      });

      it('should add only unique OpenHour to an array', () => {
        const openHourArray: IOpenHour[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const openHourCollection: IOpenHour[] = [sampleWithRequiredData];
        expectedResult = service.addOpenHourToCollectionIfMissing(openHourCollection, ...openHourArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const openHour: IOpenHour = sampleWithRequiredData;
        const openHour2: IOpenHour = sampleWithPartialData;
        expectedResult = service.addOpenHourToCollectionIfMissing([], openHour, openHour2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(openHour);
        expect(expectedResult).toContain(openHour2);
      });

      it('should accept null and undefined values', () => {
        const openHour: IOpenHour = sampleWithRequiredData;
        expectedResult = service.addOpenHourToCollectionIfMissing([], null, openHour, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(openHour);
      });

      it('should return initial array if no OpenHour is added', () => {
        const openHourCollection: IOpenHour[] = [sampleWithRequiredData];
        expectedResult = service.addOpenHourToCollectionIfMissing(openHourCollection, undefined, null);
        expect(expectedResult).toEqual(openHourCollection);
      });
    });

    describe('compareOpenHour', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareOpenHour(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareOpenHour(entity1, entity2);
        const compareResult2 = service.compareOpenHour(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareOpenHour(entity1, entity2);
        const compareResult2 = service.compareOpenHour(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareOpenHour(entity1, entity2);
        const compareResult2 = service.compareOpenHour(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
