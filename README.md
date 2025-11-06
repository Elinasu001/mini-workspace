# CarTalk Mini Project - Event Board

Spring MVC, MyBatis, Oracle 기반으로 구현한 이벤트 게시판 미니 프로젝트입니다.  
메인 페이지에서는 진행 중인 이벤트 상위 3개를 노출하고, 이벤트 목록 페이지에서는 진행/종료 탭 구분과 Ajax 기반 부분 갱신을 제공합니다.

---

## 1. 개요

본 프로젝트는 JSP 기반 SSR(Server-Side Rendering)을 유지하면서,  
Ajax로 부분 갱신을 적용한 하이브리드 형태의 이벤트 게시판 구현을 목표로 합니다.

---

## 2. 주요 기능

### 메인 페이지 (`/main`)
- 메인 전체
- 진행 중 이벤트 상위 3개 노출
- `STATUS='Y'` 상태이며, 현재 날짜 기준 진행 중(`START_DATE <= SYSDATE <= END_DATE`)인 데이터만 표시
- `MAIN_EXPOSE`, `VIEW_COUNT`, `EVENT_NO` 순으로 정렬하여 **노출 우선순위 기반 메인 배너 구성**

### 이벤트 목록 페이지 (`/event`)
- 진행중(`ongoing`) / 종료(`ended`) 탭 전환
- Ajax 기반 부분 갱신 (페이징 포함)
- 종료된 이벤트 카드에 dimmed 효과 적용

### 이벤트 상세 (`/event/detail/{eventNo}`)
- 이벤트 제목, 내용, 카테고리, 조회수, 첨부 이미지(썸네일, 상세 이미지) 표시
- 조회 시 `VIEW_COUNT` 자동 증가

### 이벤트 등록/수정 (관리자)
- 썸네일(`FILE_LEVEL=0`) / 상세 이미지(`FILE_LEVEL=1`) 업로드
- 파일명 규칙: `EVT_TH_yyyyMMddHHmmss_rand.ext`, `EVT_DE_yyyyMMddHHmmss_rand.ext`
- Null 파일 또는 확장자 없는 파일 예외 처리
- 논리 삭제(`STATUS='N'`) 방식으로 데이터 유지

---

## 3. 기술 스택

| 구분 | 기술 |
|------|------|
| Backend | Spring MVC, MyBatis, Lombok |
| Database | Oracle |
| Frontend | JSP, JSTL, Bootstrap, jQuery(Ajax) |
| Build | Maven |
| Logging | Slf4j, Logback |

---

## 4. 디렉터리 구조

src/
└─ main/
   ├─ java/com/kh/spring/
   │  ├─ main/
   │  │   └─ controller/MainController.java
   │  ├─ event/
   │  │   ├─ controller/EventController.java
   │  │   ├─ model/dto/EventDTO.java
   │  │   ├─ model/vo/EventCategory.java
   │  │   ├─ model/vo/EventAttachment.java
   │  │   ├─ model/mapper/EventMapper.java
   │  │   ├─ model/service/EventService.java
   │  │   ├─ model/service/EventServiceImpl.java
   │  │   ├─ model/service/EventValidator.java
   │  │   └─ model/service/EventFileHandler.java
   │  ├─ exception/
   │  │   └─ controller/ExceptionHandlingController.java
   │  └─ util/
   │      ├─ PageInfo.java
   │      └─ Pagenation.java
   ├─ resources/
   │  ├─ mybatis-config.xml
   │  └─ mapper/event-mapper.xml
   └─ webapp/
       ├─ WEB-INF/views/
       │   ├─ main.jsp
       │   ├─ event/
       │   │   ├─ list.jsp
       │   │   ├─ listFragment.jsp
       │   │   ├─ detail.jsp
       │   │   ├─ insertForm.jsp
       │   │   └─ updateForm.jsp
       │   └─ include/
       └─ resources/upfiles/event/
           ├─ thumb/
           └─ detail/


- 서버에서는 JSP Fragment(listFragment.jsp)만 렌더링하여 반환하고,
- 클라이언트는 해당 영역만 갱신하는 하이브리드 SSR 구조를 사용했습니다.


---

## 5. 데이터베이스 구조

### 3) CT_EVENT_CATEGORY  (이벤트 카테고리)
CREATE TABLE CT_EVENT_CATEGORY (                      
    CATEGORY_NO   NUMBER PRIMARY KEY,							  -- 카테고리 번호
    CATEGORY_NAME VARCHAR2(100) NOT NULL						  -- 카테고리명
);


### 1) CT_EVENT  (이벤트 게시판)
CREATE TABLE CT_EVENT (                               			-- 이벤트 게시판
    EVENT_NO       NUMBER PRIMARY KEY,                			-- 이벤트번호
    CATEGORY_NO    NUMBER NOT NULL,                   			-- 카테고리 (FK)
    EVENT_TITLE    VARCHAR2(100) NOT NULL,            			-- 제목
    EVENT_CONTENT  VARCHAR2(4000) NOT NULL,          			  -- 내용
    VIEW_COUNT     NUMBER DEFAULT 0,                  			-- 조회수
    START_DATE     DATE,                              			-- 시작일
    END_DATE       DATE,                              			-- 종료일
    STATUS         CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y','N')), -- 상태('Y')
    USER_NO        NUMBER NOT NULL,                   			-- 작성자번호
    ENROLL_DATE    DATE DEFAULT SYSDATE NOT NULL,     			-- 등록일
    CONSTRAINT FK_EVENT_CATEGORY FOREIGN KEY (CATEGORY_NO)
    REFERENCES CT_EVENT_CATEGORY(CATEGORY_NO),
    CONSTRAINT FK_EVENT_WRITER FOREIGN KEY (USER_NO)
    REFERENCES CT_MEMBER(USER_NO)
);

### 2) CT_EVENT_ATTACHMENT  (첨부파일)
CREATE TABLE CT_EVENT_ATTACHMENT (
  FILE_NO NUMBER PRIMARY KEY,									          -- 파일번호
  REF_BNO NUMBER NOT NULL,									              -- 참조번호
  ORIGIN_NAME VARCHAR2(255) NOT NULL,							          -- 원본 파일명
  CHANGE_NAME VARCHAR2(255) NOT NULL,							          -- 서버 저장 파일명
  FILE_PATH VARCHAR2(2000) NOT NULL,							          -- 저장 경로
  FILE_LEVEL NUMBER DEFAULT 0,									          -- 0 : 썸네일, 1 : 상세이미지
  UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,					          -- 업로드 일시
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')),              -- 상태('Y')
  FOREIGN KEY (REF_BNO) REFERENCES CT_EVENT(EVENT_NO)
);

특징
- `FILE_LEVEL`로 썸네일/상세 이미지 구분  
- 논리 삭제(`STATUS='N'`) 방식으로 관리  
- `EventFileHandler`에서 물리 파일 경로 및 이름 관리

**기본 데이터**
INSERT INTO CT_EVENT_CATEGORY VALUES (1, '시즌 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (2, '회원 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (3, '리뷰 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (4, '출석 이벤트');

###관계 요약
CT_EVENT_CATEGORY (1:N) CT_EVENT
CT_EVENT (1:N) CT_EVENT_ATTACHMENT
CT_MEMBER (1:N) CT_EVENT

## 6. 트러블슈팅
- 작성중

## 7. 개발 환경

| 항목              | 버전                 |
| ---------------- | -------------------- |
| JDK              | 21 (Amazon Corretto) |
| Spring Framework | 5.x                  |
| MyBatis          | 3.x                  |
| Oracle DB        | XE 21c               |
| Tomcat           | 9.x                  |
| IDE              | STS 3.9.x            |


## 8. Git 명령 예시
echo "# CarTalk Mini Project - Event Board" > README.md
git add .
git commit -m "docs: add README for CarTalk Event Board"
git branch -M main
git remote add origin https://github.com/Elinasu001/mini-workspace.git
git push -u origin main


