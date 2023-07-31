--------------------------------------------------------
--  Drop   
--------------------------------------------------------
DROP TABLE "CHAT" cascade constraints;
DROP SEQUENCE "CHAT_SEQ";
--------------------------------------------------------
--  DDL for Sequence CHAT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "CHAT_SEQ"  MINVALUE 0 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE;

--------------------------------------------------------
--  DDL for Table CHAT
--------------------------------------------------------

  CREATE TABLE "CHAT" 
   (	"CHATNO" NUMBER, 
	"NICK" VARCHAR2(200), 
	"CONTENTS" VARCHAR2(4000), 
	"WRITEDATE" DATE DEFAULT SYSDATE
   ) ;
 

   COMMENT ON COLUMN "CHAT"."CHATNO" IS '채팅번호';
 
   COMMENT ON COLUMN "CHAT"."NICK" IS '별명';
 
   COMMENT ON COLUMN "CHAT"."CONTENTS" IS '내용';
 
   COMMENT ON COLUMN "CHAT"."WRITEDATE" IS '작성일';

--------------------------------------------------------
--  DDL for Index CHAT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "CHAT_PK" ON "CHAT" ("CHATNO") 
  ;
--------------------------------------------------------
--  Constraints for Table CHAT
--------------------------------------------------------

  ALTER TABLE "CHAT" ADD CONSTRAINT "CHAT_PK" PRIMARY KEY ("CHATNO") ENABLE;
 
  ALTER TABLE "CHAT" MODIFY ("CHATNO" NOT NULL ENABLE);
 
  ALTER TABLE "CHAT" MODIFY ("NICK" NOT NULL ENABLE);
 
  ALTER TABLE "CHAT" MODIFY ("CONTENTS" NOT NULL ENABLE);
 
  ALTER TABLE "CHAT" MODIFY ("WRITEDATE" NOT NULL ENABLE);