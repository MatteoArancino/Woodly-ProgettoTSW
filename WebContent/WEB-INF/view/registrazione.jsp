<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Registrati</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <script src="${pageContext.request.contextPath}/scripts/validazioneRegistrazione.js" defer></script>
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />
    
    <div class="form-container">
        <h2>Crea il tuo Account Woodly</h2>
        
        <c:if test="${not empty requestScope.erroreRegistrazione}">
            <p class="login-errore-globale">
                ${requestScope.erroreRegistrazione}
            </p>
        </c:if>

        <form id="formRegistrazione" action="${pageContext.request.contextPath}/registrazione" method="POST">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome">
                <span id="errNome" class="login-errore-campo"></span>
            </div>
            
            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome">
                <span id="errCognome" class="login-errore-campo"></span>
            </div>
            
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
                Registrati
            </button>
        </form>
        
        <p class="login-footer-text">
            Hai già un account? 
            <a href="${pageContext.request.contextPath}/login" class="btn-link">Accedi qui</a>
        </p>
    </div>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>