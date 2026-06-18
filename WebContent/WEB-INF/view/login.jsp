<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- Se usi Tomcat 9 o precedente, usa uri="http://java.sun.com/jsp/jstl/core" --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Accedi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/validazioneLogin.js" defer></script>
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />
    
    <div class="form-container">
        <h2>Accedi a Woodly</h2>
        
        <c:if test="${not empty requestScope.erroreLogin}">
            <p class="login-errore-globale">
                ${requestScope.erroreLogin}
            </p>
        </c:if>

        <form id="formLogin" action="${pageContext.request.contextPath}/login" method="POST">
            <div class="form-group">
                <label for="email">Indirizzo Email:</label>
                <input type="text" id="email" name="email">
                <span id="errEmail" class="login-errore-campo"></span>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <span id="errPassword" class="login-errore-campo"></span>
            </div>
            
            <button type="submit" class="btn-hero btn-login-submit">
                Accedi
            </button>
        </form>
        
        <p class="login-footer-text">
            Non hai ancora un account? 
            <a href="${pageContext.request.contextPath}/registrazione" class="btn-link">Registrati qui</a>
        </p>
    </div>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>