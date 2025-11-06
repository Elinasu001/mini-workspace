# CarTalk Mini Project - 이벤트 게시판 (Event Board)

Spring MVC, MyBatis, Oracle 기반으로 구현된 이벤트 게시판 미니 프로젝트입니다. 메인 페이지에는 진행 중인 이벤트 상위 3개를 노출하며, 목록 페이지는 진행/종료 탭 구분과 **Ajax 기반 부분 갱신**을 제공하는 하이브리드 SSR 구조를 채택했습니다.

---

## 1. 개요 (Overview)

본 프로젝트는 **JSP 기반 SSR (Server-Side Rendering)** 환경에서 **Ajax**를 활용한 부분 갱신 기능을 통합하여 구현한 **하이브리드 이벤트 게시판**입니다.

---

## 2. 주요 기능 (Core Features)

### 2.1. 메인 페이지 (`/main`)
* **Top 3 이벤트 노출**: `STATUS='Y'` 이며, 현재 진행 중인 (`START_DATE <= SYSDATE <= END_DATE`) 이벤트 중 상위 3개 표시.
* **노출 우선순위**: `MAIN_EXPOSE`, `VIEW_COUNT`, `EVENT_NO` 순으로 정렬하여 메인 배너 우선순위를 결정합니다.

### 2.2. 이벤트 목록 페이지 (`/event`)
* **탭 필터링**: 진행중 (`ongoing`) / 종료 (`ended`) 이벤트 목록 전환 기능.
* **Ajax 갱신**: 페이징을 포함한 목록 데이터에 **Ajax 기반 부분 갱신** (JSP Fragment 렌더링) 적용.
* **시각 효과**: 종료된 이벤트 카드에 dimmed 효과 적용.

### 2.3. 이벤트 상세 (`/event/detail/{eventNo}`)
* 이벤트 정보 및 첨부 이미지 (썸네일/상세 이미지) 표시.
* 조회 시 `VIEW_COUNT` 자동 증가 처리.

### 2.4. 이벤트 등록/수정 (관리자)
* **파일 업로드**: 썸네일 (`FILE_LEVEL=0`) 및 상세 이미지 (`FILE_LEVEL=1`) 동시 업로드 지원.
    * 파일명 규칙: `EVT_TH_yyyyMMddHHmmss_rand.ext`, `EVT_DE_yyyyMMddHHmmss_rand.ext`
* **예외 처리**: 파일 Null 및 확장자 없는 파일에 대한 처리 로직 포함.
* **데이터 관리**: `STATUS='N'`으로 변경하는 **논리 삭제** 방식을 사용.

---

## 3. 기술 스택 (Tech Stack)

| 구분 | 기술 |
|:---:|:---|
| **Backend** | **Spring MVC**, **MyBatis**, Lombok |
| **Database** | **Oracle** |
| **Frontend** | **JSP**, JSTL, Bootstrap, **jQuery (Ajax)** |
| **Build** | Maven |
| **Logging** | Slf4j, Logback |

---

## 4. 디렉터리 구조 및 하이브리드 SSR
```
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
       │   │   ├─ list.jsp              -- Ajax 기반 부분 렌더링 구조
       │   │   ├─ listFragment.jsp
       │   │   ├─ detail.jsp
       │   │   ├─ insertForm.jsp
       │   │   └─ updateForm.jsp
       │   └─ include/                  -- 공통 header/footer/toast 관리
       └─ resources/upfiles/event/
           ├─ thumb/
           └─ detail/
```

> 서버에서는 JSP Fragment(`listFragment.jsp`)만 렌더링하여 반환하고,  
> 클라이언트는 해당 영역만 갱신하는 **하이브리드 SSR 구조**를 사용했습니다.

---

## 5. 데이터베이스 구조

### 1) CT_EVENT_CATEGORY (이벤트 카테고리)

--
```
CREATE TABLE CT_EVENT_CATEGORY (                      
    CATEGORY_NO   NUMBER PRIMARY KEY,                 -- 카테고리 번호
    CATEGORY_NAME VARCHAR2(100) NOT NULL              -- 카테고리명
);
```
#### 기본 데이터
```
INSERT INTO CT_EVENT_CATEGORY VALUES (1, '시즌 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (2, '회원 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (3, '리뷰 이벤트');
INSERT INTO CT_EVENT_CATEGORY VALUES (4, '출석 이벤트');
```
### 2) CT_EVENT (이벤트 게시판)
```
CREATE TABLE CT_EVENT (                               -- 이벤트 게시판
    EVENT_NO       NUMBER PRIMARY KEY,                -- 이벤트번호
    CATEGORY_NO    NUMBER NOT NULL,                   -- 카테고리 (FK)
    EVENT_TITLE    VARCHAR2(100) NOT NULL,            -- 제목
    EVENT_CONTENT  VARCHAR2(4000) NOT NULL,           -- 내용
    VIEW_COUNT     NUMBER DEFAULT 0,                  -- 조회수
    START_DATE     DATE,                              -- 시작일
    END_DATE       DATE,                              -- 종료일
    STATUS         CHAR(1) DEFAULT 'Y' CHECK (STATUS IN ('Y','N')), -- 상태('Y')
    USER_NO        NUMBER NOT NULL,                   -- 작성자번호
    ENROLL_DATE    DATE DEFAULT SYSDATE NOT NULL,     -- 등록일
    CONSTRAINT FK_EVENT_CATEGORY FOREIGN KEY (CATEGORY_NO)
        REFERENCES CT_EVENT_CATEGORY(CATEGORY_NO),
    CONSTRAINT FK_EVENT_WRITER FOREIGN KEY (USER_NO)
        REFERENCES CT_MEMBER(USER_NO)
);
```
### 3) CT_EVENT_ATTACHMENT (첨부파일)
```
CREATE TABLE CT_EVENT_ATTACHMENT (
  FILE_NO NUMBER PRIMARY KEY,                          -- 파일번호
  REF_BNO NUMBER NOT NULL,                             -- 참조번호
  ORIGIN_NAME VARCHAR2(255) NOT NULL,                  -- 원본 파일명
  CHANGE_NAME VARCHAR2(255) NOT NULL,                  -- 서버 저장 파일명
  FILE_PATH VARCHAR2(2000) NOT NULL,                   -- 저장 경로
  FILE_LEVEL NUMBER DEFAULT 0,                         -- 0 : 썸네일, 1 : 상세이미지
  UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,           -- 업로드 일시
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK(STATUS IN('Y', 'N')), -- 상태('Y')
  FOREIGN KEY (REF_BNO) REFERENCES CT_EVENT(EVENT_NO)
);
```
### 특징
- FILE_LEVEL로 썸네일/상세 이미지 구분
- 논리 삭제(STATUS='N') 방식으로 관리
- EventFileHandler에서 물리 파일 경로 및 이름 관리

### 관계 요약
- CT_EVENT_CATEGORY (1:N) CT_EVENT
- CT_EVENT (1:N) CT_EVENT_ATTACHMENT
- CT_MEMBER (1:N) CT_EVENT

---

## 6. 트러블슈팅
- 작성 예정
---

## 7. 개발 환경
| 항목              | 버전                 |
| ---------------- | -------------------- |
| JDK              | 21 (Amazon Corretto) |
| Spring Framework | 5.x                  |
| MyBatis          | 3.x                  |
| Oracle DB        | XE 21c               |
| Tomcat           | 9.x                  |
| IDE              | STS 3.9.x            |

---

## 8. Git 명령 예시
echo "# CarTalk Mini Project - Event Board" > README.md
git add .
git commit -m "docs: add README for CarTalk Event Board"
git branch -M main
git remote add origin https://github.com/Elinasu001/mini-workspace.git
git push -u origin main
