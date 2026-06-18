<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Area Personale</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="carrello-premium-container area-personale-main">
        
        <div class="user-welcome-box">
            <div>
                <h2 class="titolo-premium welcome-title">Benvenuto, ${utenteLoggato.nome} ${utenteLoggato.cognome}</h2>
                <p class="user-account-info">Account collegato: <strong>${utenteLoggato.email}</strong></p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    Disconnetti (Logout)
                </a>
            </div>
        </div>

        <h3 class="titolo-premium storico-ordini-title">Il tuo Storico Acquisti</h3>

        <c:if test="${empty storicoOrdini}">
            <div class="vuoto-premium-box ordine-vuoto-container">
                <p class="ordine-vuoto-testo">Non hai ancora effettuato ordini su Woodly.</p>
                <a href="${pageContext.request.contextPath}/catalogo" class="btn-hero btn-esplora-catalogo">Esplora il Catalogo</a>
            </div>
        </c:if>

        <c:if test="${not empty storicoOrdini}">
            <div class="storico-ordini-list">
                <c:forEach var="ordine" items="${storicoOrdini}">
                    
                    <div class="ordine-card">
                        
                        <div class="ordine-card-header">
                            <div>
                                <span class="ordine-meta-label">Ordine effettuato il</span>
                                <strong class="ordine-meta-value"><fmt:formatDate value="${ordine.dataOrdine}" pattern="dd MMMM yyyy - HH:mm" /></strong>
                            </div>
                            <div style="text-align: right;">
                                <span class="ordine-meta-label">ID Spedizione</span>
                                <strong class="ordine-meta-value">#WDLY-${ordine.id}</strong>
                            </div>
                            <div style="text-align: right;">
                                <span class="ordine-meta-label">Stato</span>
                                <span class="ordine-stato-badge ${ordine.stato == 'Consegnato' ? 'stato-consegnato' : (ordine.stato == 'Annullato' ? 'stato-annullato' : 'stato-in-lavorazione')}">
                                    ${ordine.stato}
                                </span>
                            </div>
                        </div>

                        <div class="ordine-card-body">
                            <table class="ordine-table">
                                <thead>
                                    <tr>
                                        <th>Elemento Artigianale</th>
                                        <th class="th-qta">Qta</th>
                                        <th class="th-prezzo">Prezzo Unitario</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dettaglio" items="${ordine.dettagli}">
                                        <tr>
                                            <td class="prodotto-nome">${dettaglio.nomeProdotto}</td>
                                            <td class="prodotto-qta">x${dettaglio.quantita}</td>
                                            <td class="prodotto-prezzo">
                                                <fmt:formatNumber value="${dettaglio.prezzoAcquisto}" pattern="#,##0.00" /> €
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                            <div class="ordine-card-footer">
                                <div class="ordine-spedizione-info">
                                    <span class="destinazione-label">Destinazione:</span>
                                    ${ordine.indirizzo}, ${ordine.citta} (${ordine.cap})<br>
                                    Pagato con: <em>${ordine.metodoPagamento}</em>
                                </div>
                                <div class="ordine-totale-container">
                                    <span class="totale-label">Totale Transazione</span>
                                    <span class="totale-valore"><fmt:formatNumber value="${ordine.totale}" pattern="#,##0.00" /> €</span>
                                </div>
                            </div>

                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>