import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IQueueTerminal } from '../queue-terminal.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../queue-terminal.test-samples';

import { QueueTerminalService } from './queue-terminal.service';

const requireRestSample: IQueueTerminal = {
  ...sampleWithRequiredData,
};

describe('QueueTerminal Service', () => {
  let service: QueueTerminalService;
  let httpMock: HttpTestingController;
  let expectedResult: IQueueTerminal | IQueueTerminal[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(QueueTerminalService);
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

    it('should create a QueueTerminal', () => {
      const queueTerminal = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(queueTerminal).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a QueueTerminal', () => {
      const queueTerminal = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(queueTerminal).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a QueueTerminal', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of QueueTerminal', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a QueueTerminal', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addQueueTerminalToCollectionIfMissing', () => {
      it('should add a QueueTerminal to an empty array', () => {
        const queueTerminal: IQueueTerminal = sampleWithRequiredData;
        expectedResult = service.addQueueTerminalToCollectionIfMissing([], queueTerminal);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(queueTerminal);
      });

      it('should not add a QueueTerminal to an array that contains it', () => {
        const queueTerminal: IQueueTerminal = sampleWithRequiredData;
        const queueTerminalCollection: IQueueTerminal[] = [
          {
            ...queueTerminal,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addQueueTerminalToCollectionIfMissing(queueTerminalCollection, queueTerminal);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a QueueTerminal to an array that doesn't contain it", () => {
        const queueTerminal: IQueueTerminal = sampleWithRequiredData;
        const queueTerminalCollection: IQueueTerminal[] = [sampleWithPartialData];
        expectedResult = service.addQueueTerminalToCollectionIfMissing(queueTerminalCollection, queueTerminal);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(queueTerminal);
      });

      it('should add only unique QueueTerminal to an array', () => {
        const queueTerminalArray: IQueueTerminal[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const queueTerminalCollection: IQueueTerminal[] = [sampleWithRequiredData];
        expectedResult = service.addQueueTerminalToCollectionIfMissing(queueTerminalCollection, ...queueTerminalArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const queueTerminal: IQueueTerminal = sampleWithRequiredData;
        const queueTerminal2: IQueueTerminal = sampleWithPartialData;
        expectedResult = service.addQueueTerminalToCollectionIfMissing([], queueTerminal, queueTerminal2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(queueTerminal);
        expect(expectedResult).toContain(queueTerminal2);
      });

      it('should accept null and undefined values', () => {
        const queueTerminal: IQueueTerminal = sampleWithRequiredData;
        expectedResult = service.addQueueTerminalToCollectionIfMissing([], null, queueTerminal, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(queueTerminal);
      });

      it('should return initial array if no QueueTerminal is added', () => {
        const queueTerminalCollection: IQueueTerminal[] = [sampleWithRequiredData];
        expectedResult = service.addQueueTerminalToCollectionIfMissing(queueTerminalCollection, undefined, null);
        expect(expectedResult).toEqual(queueTerminalCollection);
      });
    });

    describe('compareQueueTerminal', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareQueueTerminal(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareQueueTerminal(entity1, entity2);
        const compareResult2 = service.compareQueueTerminal(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareQueueTerminal(entity1, entity2);
        const compareResult2 = service.compareQueueTerminal(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareQueueTerminal(entity1, entity2);
        const compareResult2 = service.compareQueueTerminal(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
