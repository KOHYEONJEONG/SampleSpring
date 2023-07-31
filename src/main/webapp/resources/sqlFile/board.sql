--------------------------------------------------------
--  Drop   
--------------------------------------------------------
DROP TABLE "BOARD" cascade constraints;
DROP SEQUENCE "BOARD_SEQ";
--------------------------------------------------------
--  DDL for Sequence BOARD_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "BOARD_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOARD
--------------------------------------------------------

  CREATE TABLE "BOARD" 
   (	"BOARD_NO" NUMBER, 
	"TITLE" VARCHAR2(1000), 
	"WRITER" VARCHAR2(100), 
	"PASS" VARCHAR2(100), 
	"CONTENTS" VARCHAR2(4000), 
	"WRITE_DATE" DATE DEFAULT SYSDATE, 
	"HIT_CNT" NUMBER DEFAULT 0, 
	"DEL_YN" NUMBER DEFAULT 1
   ) ;

   COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '글번호';
   COMMENT ON COLUMN "BOARD"."TITLE" IS '제목';
   COMMENT ON COLUMN "BOARD"."WRITER" IS '작성자';
   COMMENT ON COLUMN "BOARD"."PASS" IS '비밀번호';
   COMMENT ON COLUMN "BOARD"."CONTENTS" IS '글내용';
   COMMENT ON COLUMN "BOARD"."WRITE_DATE" IS '작성일';
   COMMENT ON COLUMN "BOARD"."HIT_CNT" IS '조회수';
   COMMENT ON COLUMN "BOARD"."DEL_YN" IS '삭제여부';
--------------------------------------------------------
--  DDL for Index BOARD_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "BOARD_PK" ON "BOARD" ("BOARD_NO") 
  ;
--------------------------------------------------------
--  Constraints for Table BOARD
--------------------------------------------------------

  ALTER TABLE "BOARD" ADD CONSTRAINT "BOARD_PK" PRIMARY KEY ("BOARD_NO") ENABLE;
  ALTER TABLE "BOARD" MODIFY ("DEL_YN" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("HIT_CNT" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("WRITE_DATE" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("CONTENTS" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("PASS" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("WRITER" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("TITLE" NOT NULL ENABLE);
  ALTER TABLE "BOARD" MODIFY ("BOARD_NO" NOT NULL ENABLE);
