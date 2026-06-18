<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Spedizione e Pagamento</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="carrello-premium-container checkout-main-box">
        <h2 class="titolo-premium checkout-titolo">Dettagli di Spedizione</h2>
        
        <c:if test="${not empty erroreCheckout}">
            <p class="checkout-errore-messaggio">${erroreCheckout}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="POST" class="checkout-form">
            
            <div class="checkout-form-group">
                <label class="checkout-label">Indirizzo di Spedizione</label>
                <input type="text" name="indirizzo" placeholder="Via/Piazza e Numero Civico" required class="checkout-input">
            </div>

            <div class="checkout-grid-row">
                <div class="checkout-form-group">
                    <label class="checkout-label">Città</label>
                    <input type="text" name="citta" placeholder="Milano, Roma..." required class="checkout-input">
                </div>
                <div class="checkout-form-group">
                    <label class="checkout-label">CAP</label>
                    <input type="text" name="cap" placeholder="20100" pattern="[0-9]{5}" required class="checkout-input">
                </div>
            </div>

            <div class="checkout-form-group checkout-select-space">
                <label class="checkout-label">Metodo di Pagamento</label>
                <select name="metodoPagamento" required class="checkout-input checkout-select">
                    <option value="Carta di Credito / Debito">Carta di Credito / Debito</option>
                    <option value="PayPal">PayPal</option>
                    <option value="Bonifico Bancario">Bonifico Bancario anticipato</option>
                    <option value="Contrassegno">Alla Consegna (+5.00 €)</option>
                </select>
            </div>

            <hr class="divider-elegante checkout-divider">

            <button type="submit" class="btn-procedi-checkout-bello btn-checkout-submit">
                Conferma e Invia Ordine
            </button>
        </form>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>