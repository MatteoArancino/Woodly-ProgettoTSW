<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Ordine Confermato</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="carrello-premium-container">
        <div class="vuoto-premium-box" style="padding: 60px 20px;">
            <div class="vuoto-art" style="color: #27ae60;">✨</div>
            <h3>Acquisto Completato!</h3>
            <p>${messaggioSuccesso}</p>
            <p style="font-size: 14px; color: #666; margin-top: -10px;">Riceverai a breve un'email con i dettagli per tracciare la spedizione del tuo pezzo artigianale.</p>
            <a href="${pageContext.request.contextPath}/catalogo" class="btn-hero" style="margin-top: 20px;">Continua lo Shopping</a>
        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>