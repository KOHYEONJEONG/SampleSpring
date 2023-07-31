--------------------------------------------------------
--  Drop   
--------------------------------------------------------
DROP TABLE "REST";

--------------------------------------------------------
--  DDL for Table REST
--------------------------------------------------------
  CREATE TABLE "REST" 
   (	"RTXT" VARCHAR2(100 BYTE), 
	"RDT" DATE DEFAULT SYSDATE
   ) ;

   COMMENT ON COLUMN "REST"."RTXT" IS '텍스트';
   COMMENT ON COLUMN "REST"."RDT" IS '등록일';


Insert into REST (RTXT,RDT) values ('홍길동',TO_DATE('20220516145001', 'YYYYMMDDHH24MISS'));
Insert into REST (RTXT,RDT) values ('신사임당',TO_DATE('20220516145003', 'YYYYMMDDHH24MISS'));
Insert into REST (RTXT,RDT) values ('김철수',TO_DATE('20220516145005', 'YYYYMMDDHH24MISS'));
Insert into REST (RTXT,RDT) values ('허준',TO_DATE('20220516145007', 'YYYYMMDDHH24MISS'));
Insert into REST (RTXT,RDT) values ('유관순',TO_DATE('20220516145009', 'YYYYMMDDHH24MISS'));
--------------------------------------------------------
--  Constraints for Table REST
--------------------------------------------------------
  ALTER TABLE "REST" MODIFY ("RTXT" NOT NULL ENABLE);
  ALTER TABLE "REST" MODIFY ("RDT" NOT NULL ENABLE);