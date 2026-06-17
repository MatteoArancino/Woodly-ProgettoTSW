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
            <p style="color: #cc3333; text-align: center; font-weight: bold; margin-bottom: 15px;">
                ${requestScope.erroreRegistrazione}
            </p>
        </c:if>

        <form id="formRegistrazione" action="${pageContext.request.contextPath}/registrazione" method="POST">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome">
                <span id="errNome" style="color: #cc3333; font-size: 0.85em; display: block; margin-top: 5px;"></span>
            </div>
            
            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome">
                <span id="errCognome" style="color: #cc3333; font-size: 0.85em; display: block; margin-top: 5px;"></span>
            </div>
            
            <div class="form-group">
                <label for="email">Indirizzo Email:</label>
                <input type="text" id="email" name="email">
                <span id="errEmail" style="color: #cc3333; font-size: 0.85em; display: block; margin-top: 5px;"></span>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <span id="errPassword" style="color: #cc3333; font-size: 0.85em; display: block; margin-top: 5px;"></span>
            </div>
            
            <button type="submit" class="btn-hero" style="width: 100%; border: none; cursor: pointer; margin-top: 10px;">
                Registrati
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 20px;">
            Hai già un account? 
            <a href="${pageContext.request.contextPath}/login" class="btn-link">Accedi qui</a>
        </p>
    </div>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>