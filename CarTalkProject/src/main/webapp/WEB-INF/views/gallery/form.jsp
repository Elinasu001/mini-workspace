<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>사진게시판-글등록 | CarTalk</title>
  <link rel="stylesheet" href="gallery_upload.css" />
  <style>
  /* 전체 스타일 */
body {
  font-family: 'Pretendard', 'Noto Sans KR', sans-serif;
  background-color: #f8f9fa;
  margin: 0;
  padding: 0;
}

/* 컨테이너 */
.container {
  width: 600px;
  background-color: #fff;
  margin: 60px auto;
  padding: 30px 40px;
  box-shadow: 0 4px 10px rgba(0,0,0,0.1);
  border-radius: 10px;
}

/* 제목 */
.container h2 {
  text-align: center;
  color: #333;
  margin-bottom: 25px;
}

/* 폼 그룹 */
.form-group {
  margin-bottom: 20px;
}

.form-group label {
  display: block;
  font-weight: 600;
  margin-bottom: 8px;
  color: #555;
}

.form-group input[type="text"],
.form-group textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 6px;
  box-sizing: border-box;
  font-size: 15px;
  resize: none;
}

/* 파일 업로드 */
.form-group input[type="file"] {
  display: block;
  margin-top: 8px;
}

#preview {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  margin-top: 12px;
}

#preview img {
  width: 120px;
  height: 120px;
  object-fit: cover;
  border-radius: 8px;
  border: 1px solid #ddd;
  transition: transform 0.2s;
}

#preview img:hover {
  transform: scale(1.05);
}

/* 버튼 */
.form-buttons {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-top: 20px;
}

.btn-submit,
.btn-cancel {
  padding: 10px 25px;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  font-size: 16px;
  transition: 0.2s ease;
}

.btn-submit {
  background-color: #007bff;
  color: white;
}

.btn-submit:hover {
  background-color: #0056b3;
}

.btn-cancel {
  background-color: #6c757d;
  color: white;
}

.btn-cancel:hover {
  background-color: #5a6268;
}
  
  </style>
</head>
<body>

  <div class="container">
    <h2>📸 사진게시판 글등록</h2>

    <form action="/gallery/insert" method="post" enctype="multipart/form-data" class="upload-form">
    
      <!-- 카테고리 -->
      <div class="form-group">
        <label for="title">카테고리</label>
        <input type="radio" id="category" name="galleryCategory" value="자랑"/>자랑
        <input type="radio" id="category" name="galleryCategory" value="리뷰"/>리뷰
      </div>
      
      <!-- 제목 -->
      <div class="form-group">
        <label for="title">제목</label>
        <input type="text" id="title" name="galleryTitle" placeholder="제목을 입력하세요" required />
      </div>

      <!-- 내용 -->
      <div class="form-group">
        <label for="content">내용</label>
        <textarea id="content" name="galleryContent" rows="6" placeholder="내용을 입력하세요" required></textarea>
      </div>

      <!-- 파일 업로드 -->
      <div class="form-group">
        <label for="imageUpload">썸네일 업로드</label>
        <input type="file" id="imageUpload" name="upfiles" accept="image/*" multiple />
        <div id="preview"></div>
      </div>

      <!-- 버튼 -->
      <div class="form-buttons">
        <button type="submit" class="btn-submit">등록</button>
        <button type="reset" class="btn-cancel">취소</button>
      </div>

    </form>
  </div>

  <script>
    // 이미지 미리보기 기능
    const imageInput = document.getElementById('imageUpload');
    const preview = document.getElementById('preview');

    imageInput.addEventListener('change', function() {
      preview.innerHTML = ''; // 기존 이미지 초기화
      const files = this.files;
      for (const file of files) {
        const reader = new FileReader();
        reader.onload = e => {
          const img = document.createElement('img');
          img.src = e.target.result;
          preview.appendChild(img);
        };
        reader.readAsDataURL(file);
      }
    });
  </script>

</body>
</html>
