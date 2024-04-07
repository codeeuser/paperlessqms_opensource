import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';

import { IProfileBiz } from '../profile-biz.model';
import { sampleWithRequiredData, sampleWithNewData, sampleWithPartialData, sampleWithFullData } from '../profile-biz.test-samples';

import { ProfileBizService } from './profile-biz.service';

const requireRestSample: IProfileBiz = {
  ...sampleWithRequiredData,
};

describe('ProfileBiz Service', () => {
  let service: ProfileBizService;
  let httpMock: HttpTestingController;
  let expectedResult: IProfileBiz | IProfileBiz[] | boolean | null;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
    });
    expectedResult = null;
    service = TestBed.inject(ProfileBizService);
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

    it('should create a ProfileBiz', () => {
      const profileBiz = { ...sampleWithNewData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.create(profileBiz).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'POST' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should update a ProfileBiz', () => {
      const profileBiz = { ...sampleWithRequiredData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.update(profileBiz).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PUT' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should partial update a ProfileBiz', () => {
      const patchObject = { ...sampleWithPartialData };
      const returnedFromService = { ...requireRestSample };
      const expected = { ...sampleWithRequiredData };

      service.partialUpdate(patchObject).subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'PATCH' });
      req.flush(returnedFromService);
      expect(expectedResult).toMatchObject(expected);
    });

    it('should return a list of ProfileBiz', () => {
      const returnedFromService = { ...requireRestSample };

      const expected = { ...sampleWithRequiredData };

      service.query().subscribe(resp => (expectedResult = resp.body));

      const req = httpMock.expectOne({ method: 'GET' });
      req.flush([returnedFromService]);
      httpMock.verify();
      expect(expectedResult).toMatchObject([expected]);
    });

    it('should delete a ProfileBiz', () => {
      const expected = true;

      service.delete(123).subscribe(resp => (expectedResult = resp.ok));

      const req = httpMock.expectOne({ method: 'DELETE' });
      req.flush({ status: 200 });
      expect(expectedResult).toBe(expected);
    });

    describe('addProfileBizToCollectionIfMissing', () => {
      it('should add a ProfileBiz to an empty array', () => {
        const profileBiz: IProfileBiz = sampleWithRequiredData;
        expectedResult = service.addProfileBizToCollectionIfMissing([], profileBiz);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(profileBiz);
      });

      it('should not add a ProfileBiz to an array that contains it', () => {
        const profileBiz: IProfileBiz = sampleWithRequiredData;
        const profileBizCollection: IProfileBiz[] = [
          {
            ...profileBiz,
          },
          sampleWithPartialData,
        ];
        expectedResult = service.addProfileBizToCollectionIfMissing(profileBizCollection, profileBiz);
        expect(expectedResult).toHaveLength(2);
      });

      it("should add a ProfileBiz to an array that doesn't contain it", () => {
        const profileBiz: IProfileBiz = sampleWithRequiredData;
        const profileBizCollection: IProfileBiz[] = [sampleWithPartialData];
        expectedResult = service.addProfileBizToCollectionIfMissing(profileBizCollection, profileBiz);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(profileBiz);
      });

      it('should add only unique ProfileBiz to an array', () => {
        const profileBizArray: IProfileBiz[] = [sampleWithRequiredData, sampleWithPartialData, sampleWithFullData];
        const profileBizCollection: IProfileBiz[] = [sampleWithRequiredData];
        expectedResult = service.addProfileBizToCollectionIfMissing(profileBizCollection, ...profileBizArray);
        expect(expectedResult).toHaveLength(3);
      });

      it('should accept varargs', () => {
        const profileBiz: IProfileBiz = sampleWithRequiredData;
        const profileBiz2: IProfileBiz = sampleWithPartialData;
        expectedResult = service.addProfileBizToCollectionIfMissing([], profileBiz, profileBiz2);
        expect(expectedResult).toHaveLength(2);
        expect(expectedResult).toContain(profileBiz);
        expect(expectedResult).toContain(profileBiz2);
      });

      it('should accept null and undefined values', () => {
        const profileBiz: IProfileBiz = sampleWithRequiredData;
        expectedResult = service.addProfileBizToCollectionIfMissing([], null, profileBiz, undefined);
        expect(expectedResult).toHaveLength(1);
        expect(expectedResult).toContain(profileBiz);
      });

      it('should return initial array if no ProfileBiz is added', () => {
        const profileBizCollection: IProfileBiz[] = [sampleWithRequiredData];
        expectedResult = service.addProfileBizToCollectionIfMissing(profileBizCollection, undefined, null);
        expect(expectedResult).toEqual(profileBizCollection);
      });
    });

    describe('compareProfileBiz', () => {
      it('Should return true if both entities are null', () => {
        const entity1 = null;
        const entity2 = null;

        const compareResult = service.compareProfileBiz(entity1, entity2);

        expect(compareResult).toEqual(true);
      });

      it('Should return false if one entity is null', () => {
        const entity1 = { id: 123 };
        const entity2 = null;

        const compareResult1 = service.compareProfileBiz(entity1, entity2);
        const compareResult2 = service.compareProfileBiz(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey differs', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 456 };

        const compareResult1 = service.compareProfileBiz(entity1, entity2);
        const compareResult2 = service.compareProfileBiz(entity2, entity1);

        expect(compareResult1).toEqual(false);
        expect(compareResult2).toEqual(false);
      });

      it('Should return false if primaryKey matches', () => {
        const entity1 = { id: 123 };
        const entity2 = { id: 123 };

        const compareResult1 = service.compareProfileBiz(entity1, entity2);
        const compareResult2 = service.compareProfileBiz(entity2, entity1);

        expect(compareResult1).toEqual(true);
        expect(compareResult2).toEqual(true);
      });
    });
  });

  afterEach(() => {
    httpMock.verify();
  });
});
