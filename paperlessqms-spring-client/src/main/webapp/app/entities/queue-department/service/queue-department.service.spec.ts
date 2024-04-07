import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IQueueDepartment } from '../queue-department.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../queue-department.test-samples';

import { QueueDepartmentService } from './queue-department.service';

const requireRestSample: IQueueDepartment = {
  ...sampleWithRequiredData,
};

describe('QueueDepartment Service', () => {
  let service: QueueDepartmentService;
  let httpMock: HttpTestingController;
  let expectedResult: IQueueDepartment | IQueueDepartment[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(QueueDepartmentService);
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

    it('should create a QueueDepartment', () => {
      const queueDepartment = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(queueDepartment).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a QueueDepartment', () => {
      const queueDepartment = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(queueDepartment).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a QueueDepartment', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of QueueDepartment', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a QueueDepartment', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addQueueDepartmentToCollectionIfMissing', () => {
      it('should add a QueueDepartment to an empty array', () => {
        const queueDepartment: IQueueDepartment = sampleWithRequiredData;
        expectedResult = service.addQueueDepartmentToCollectionIfMissing([], queueDepartment);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(queueDepartment);
      });

      it('should not add a QueueDepartment to an array that contains it', () => {
        const queueDepartment: IQueueDepartment = sampleWithRequiredData;
        const queueDepartmentCollection: IQueueDepartment[] = [
          {
            ...queueDepartment,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addQueueDepartmentToCollectionIfMissing(queueDepartmentCollection, queueDepartment);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a QueueDepartment to an array that doesn't contain it", () => {
        const queueDepartment: IQueueDepartment = sampleWithRequiredData;
        const queueDepartmentCollection: IQueueDepartment[] = [sampleWithPartialData];
        expectedResult = service.addQueueDepartmentToCollectionIfMissing(queueDepartmentCollection, queueDepartment);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(queueDepartment);
      });

      it('should add only unique QueueDepartment to an array', () => {
        const queueDepartmentArray: IQueueDepartment[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const queueDepartmentCollection: IQueueDepartment[] = [sampleWithRequiredData];
        expectedResult = service.addQueueDepartmentToCollectionIfMissing(queueDepartmentCollection, ...queueDepartmentArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const queueDepartment: IQueueDepartment = sampleWithRequiredData;
        const queueDepartment2: IQueueDepartment = sampleWithPartialData;
        expectedResult = service.addQueueDepartmentToCollectionIfMissing([], queueDepartment, queueDepartment2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(queueDepartment);
        expect(expectedResult).toContain(queueDepartment2);
      });

      it('should accept null and undefined values', () => {
        const queueDepartment: IQueueDepartment = sampleWithRequiredData;
        expectedResult = service.addQueueDepartmentToCollectionIfMissing([], null, queueDepartment, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(queueDepartment);
      });

      it('should return initial array if no QueueDepartment is added', () => {
        const queueDepartmentCollection: IQueueDepartment[] = [sampleWithRequiredData];
        expectedResult = service.addQueueDepartmentToCollectionIfMissing(queueDepartmentCollection, undefined, null);
        expect(expectedResult).toEqual(queueDepartmentCollection);
      });
    });

    describe('compareQueueDepartment', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareQueueDepartment(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareQueueDepartment(entity1, entity2);
        const compareResult2 = service.compareQueueDepartment(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareQueueDepartment(entity1, entity2);
        const compareResult2 = service.compareQueueDepartment(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareQueueDepartment(entity1, entity2);
        const compareResult2 = service.compareQueueDepartment(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
