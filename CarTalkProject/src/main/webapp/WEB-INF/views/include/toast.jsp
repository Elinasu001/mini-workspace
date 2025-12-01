<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="toast" class="toast-message"></div>
<script>
  <%-- flash 메시지 가져오기 --%>
  const alertMsg = "${alertMsg}";
  if (alertMsg) {
    const toast = document.getElementById("toast");
    toast.textContent = alertMsg;
    toast.classList.add("show");

    setTimeout(() => toast.classList.remove("show"), 3000);
  }
</script>
