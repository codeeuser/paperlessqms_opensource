import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IAgent } from '../agent.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../agent.test-samples';

import { AgentService } from './agent.service';

const requireRestSample: IAgent = {
  ...sampleWithRequiredData,
};

describe('Agent Service', () => {
  let service: AgentService;
  let httpMock: HttpTestingController;
  let expectedResult: IAgent | IAgent[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(AgentService);
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

    it('should create a Agent', () => {
      const agent = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(agent).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a Agent', () => {
      const agent = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(agent).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a Agent', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of Agent', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a Agent', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addAgentToCollectionIfMissing', () => {
      it('should add a Agent to an empty array', () => {
        const agent: IAgent = sampleWithRequiredData;
        expectedResult = service.addAgentToCollectionIfMissing([], agent);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(agent);
      });

      it('should not add a Agent to an array that contains it', () => {
        const agent: IAgent = sampleWithRequiredData;
        const agentCollection: IAgent[] = [
          {
            ...agent,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addAgentToCollectionIfMissing(agentCollection, agent);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a Agent to an array that doesn't contain it", () => {
        const agent: IAgent = sampleWithRequiredData;
        const agentCollection: IAgent[] = [sampleWithPartialData];
        expectedResult = service.addAgentToCollectionIfMissing(agentCollection, agent);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(agent);
      });

      it('should add only unique Agent to an array', () => {
        const agentArray: IAgent[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const agentCollection: IAgent[] = [sampleWithRequiredData];
        expectedResult = service.addAgentToCollectionIfMissing(agentCollection, ...agentArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const agent: IAgent = sampleWithRequiredData;
        const agent2: IAgent = sampleWithPartialData;
        expectedResult = service.addAgentToCollectionIfMissing([], agent, agent2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(agent);
        expect(expectedResult).toContain(agent2);
      });

      it('should accept null and undefined values', () => {
        const agent: IAgent = sampleWithRequiredData;
        expectedResult = service.addAgentToCollectionIfMissing([], null, agent, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(agent);
      });

      it('should return initial array if no Agent is added', () => {
        const agentCollection: IAgent[] = [sampleWithRequiredData];
        expectedResult = service.addAgentToCollectionIfMissing(agentCollection, undefined, null);
        expect(expectedResult).toEqual(agentCollection);
      });
    });

    describe('compareAgent', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareAgent(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareAgent(entity1, entity2);
        const compareResult2 = service.compareAgent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareAgent(entity1, entity2);
        const compareResult2 = service.compareAgent(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareAgent(entity1, entity2);
        const compareResult2 = service.compareAgent(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
