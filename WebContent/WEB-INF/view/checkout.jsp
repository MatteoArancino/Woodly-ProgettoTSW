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

    <main class="carrello-premium-container" style="max-width: 600px; margin: 40px auto; padding: 20px;">
        <h2 class="titolo-premium" style="text-align: center; margin-bottom: 30px;">Dettagli di Spedizione</h2>
        
        <c:if test="${not empty erroreCheckout}">
            <p style="color: #a94442; background: #f2dede; padding: 10px; border-radius: 4px; text-align: center;">${erroreCheckout}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/checkout" method="POST" style="display: flex; flex-direction: column; gap: 15px;">
            
            <div style="display: flex; flex-direction: column;">
                <label style="font-weight: 600; margin-bottom: 5px; color: #333;">Indirizzo di Spedizione</label>
                <input type="text" name="indirizzo" placeholder="Via/Piazza e Numero Civico" required 
                       style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-family: inherit;">
            </div>

            <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 15px;">
                <div style="display: flex; flex-direction: column;">
                    <label style="font-weight: 600; margin-bottom: 5px; color: #333;">Città</label>
                    <input type="text" name="citta" placeholder="Milano, Roma..." required 
                           style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-family: inherit;">
                </div>
                <div style="display: flex; flex-direction: column;">
                    <label style="font-weight: 600; margin-bottom: 5px; color: #333;">CAP</label>
                    <input type="text" name="cap" placeholder="20100" pattern="[0-9]{5}" required 
                           style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-family: inherit;">
                </div>
            </div>

            <div style="display: flex; flex-direction: column; margin-top: 10px;">
                <label style="font-weight: 600; margin-bottom: 8px; color: #333;">Metodo di Pagamento</label>
                <select name="metodoPagamento" required style="padding: 10px; border: 1px solid #ccc; border-radius: 4px; font-family: inherit; background: white;">
                    <option value="Carta di Credito / Debito">Carta di Credito / Debito</option>
                    <option value="PayPal">PayPal</option>
                    <option value="Bonifico Bancario">Bonifico Bancario anticipato</option>
                    <option value="Contrassegno">Alla Consegna (+5.00 €)</option>
                </select>
            </div>

            <hr class="divider-elegante" style="margin: 20px 0;">

            <button type="submit" class="btn-procedi-checkout-bello" style="width: 100%; border: none; cursor: pointer; padding: 15px; font-size: 16px;">
                Conferma e Invia Ordine
            </button>
        </form>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>