<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>중고 판매 목록 | CarTalk</title>

<!-- CSS 외부 파일 연결 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/usedList.css">

</head>
<body>

<main class="main-wrap">
  <h2>중고 판매 목록</h2>

  <!-- 차량 목록 -->
  <div class="car-list">

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | SUV</div>
        <h3>현대 팰리세이드 2.2 디젤 4WD 캘리그래피</h3>
        <p>20.03년식 / 6.3만KM / 무사고 / 1인소유</p>
        <div class="meta">가격: 4,290만원 | 댓글 5 | 1일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=Palisade" alt="팰리세이드">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매완료 | 세단</div>
        <h3>제네시스 G80 3.3 GDI AWD 럭셔리</h3>
        <p>18.09년식 / 8.5만KM / 완무 / 정비이력 있음</p>
        <div class="meta">가격: 3,150만원 | 댓글 8 | 3일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=G80" alt="제네시스 G80">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>예약중 | 준중형</div>
        <h3>기아 K3 1.6 노블레스</h3>
        <p>19.06년식 / 4.2만KM / 무사고 / 여성 1인 운행</p>
        <div class="meta">가격: 1,290만원 | 댓글 2 | 2일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=K3" alt="기아 K3">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | 소형 SUV</div>
        <h3>기아 셀토스 1.6 디젤 트렌디</h3>
        <p>21.05년식 / 2.9만KM / 완무 / 신조차주</p>
        <div class="meta">가격: 2,380만원 | 댓글 1 | 5일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=Seltos" alt="셀토스">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | 중형</div>
        <h3>현대 쏘나타 DN8 2.0 스마트</h3>
        <p>20.08년식 / 5.1만KM / 무사고 / 보험이력 無</p>
        <div class="meta">가격: 1,890만원 | 댓글 4 | 6일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=Sonata" alt="쏘나타">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | 준대형</div>
        <h3>현대 그랜저 IG 3.0 익스클루시브</h3>
        <p>19.11년식 / 7.2만KM / 무사고 / 옵션 풍부</p>
        <div class="meta">가격: 2,680만원 | 댓글 6 | 4일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=Grandeur" alt="그랜저 IG">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | 수입 SUV</div>
        <h3>BMW X3 20d xDrive M 스포츠</h3>
        <p>17.05년식 / 9.8만KM / 무사고 / 정식출고</p>
        <div class="meta">가격: 3,450만원 | 댓글 9 | 7일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=X3" alt="BMW X3">
    </div>

    <div class="car-card">
      <div class="car-info">
        <div>판매중 | 해치백</div>
        <h3>폭스바겐 골프 2.0 TDI 프리미엄</h3>
        <p>16.12년식 / 10.1만KM / 완무 / 연비 우수</p>
        <div class="meta">가격: 1,290만원 | 댓글 3 | 8일 전</div>
      </div>
      <img src="https://via.placeholder.com/150x100?text=Golf" alt="폭스바겐 골프">
    </div>

  </div>

  <!-- 페이징 -->
  <div class="pagination">
    <button>1</button>
    <button class="active">2</button>
    <button>3</button>
    <button>4</button>
    <button>5</button>
    <button>▶</button>
  </div>

  <!-- 검색 -->
  <div class="search-box">
    <input type="text" placeholder="검색어를 입력하세요.">
    <button>검색</button>
  </div>

</main>

</body>
</html>