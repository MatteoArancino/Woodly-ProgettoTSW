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

        <h3 class="titolo-premium storico-ordini-title" style="margin-top: 50px;">I tuoi Preventivi su Misura</h3>

        <c:if test="${empty mieRichieste}">
            <div class="vuoto-premium-box ordine-vuoto-container">
                <p class="ordine-vuoto-testo">Non hai ancora richiesto progetti personalizzati al nostro laboratorio.</p>
                <a href="${pageContext.request.contextPath}/invia-richiesta" class="btn-hero btn-esplora-catalogo">Richiedi un Preventivo</a>
            </div>
        </c:if>

        <c:if test="${not empty mieRichieste}">
            <div class="storico-ordini-list">
                <c:forEach var="richiesta" items="${mieRichieste}">
                    
                    <div class="ordine-card">
                        
                        <div class="ordine-card-header" style="background-color: #fcf8f2; border-bottom: 1px solid #eae0d5;">
                            <div>
                                <span class="ordine-meta-label">Richiesta inviata il</span>
                                <strong class="ordine-meta-value"><fmt:formatDate value="${richiesta.dataRichiesta}" pattern="dd MMMM yyyy - HH:mm" /></strong>
                            </div>
                            <div style="text-align: right;">
                                <span class="ordine-meta-label">Codice Progetto</span>
                                <strong class="ordine-meta-value">#PRJ-${richiesta.id}</strong>
                            </div>
                            <div style="text-align: right;">
                                <span class="ordine-meta-label">Stato Avanzamento</span>
                                <span class="ordine-stato-badge ${richiesta.stato == 'In attesa' ? 'stato-in-lavorazione' : 'stato-consegnato'}">
                                    ${richiesta.stato}
                                </span>
                            </div>
                        </div>

                        <div class="ordine-card-body">
                            <table class="ordine-table">
                                <thead>
                                    <tr>
                                        <th>Specifiche Creazione</th>
                                        <th>Materiale Richiesto</th>
                                        <th class="th-prezzo" style="width: 250px;">Dimensioni (L x A x P)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="prodotto-nome" style="font-weight: 600; color: #2e1f15;">
                                            ${richiesta.tipoMobile}
                                        </td>
                                        <td class="prodotto-nome" style="color: #6a513d;">
                                            ${richiesta.materiale}
                                        </td>
                                        <td class="prodotto-prezzo" style="text-align: left; font-size: 14px; font-weight: normal;">
                                            ${richiesta.larghezzaCm} cm x ${richiesta.altezzaCm} cm x ${richiesta.profonditaCm} cm
                                        </td>
                                    </tr>
                                    <c:if test="${not empty richiesta.noteCliente}">
                                        <tr>
                                            <td colspan="3" style="padding: 15px; background: #fafafa; font-style: italic; font-size: 13px; color: #666; border-top: 1px dashed #eae0d5;">
                                                <strong>Tue note di progettazione:</strong> "${richiesta.noteCliente}"
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                            
                            <div class="ordine-card-footer" style="background-color: #fdfdfd; border-top: 1px solid #eae0d5; padding-top: 15px;">
                                <div class="ordine-spedizione-info" style="font-size: 13px; color: #888; align-self: center;">
                                    🎨 Un maestro ebanista Woodly sta seguendo il tuo disegno.
                                </div>
                                <div class="ordine-totale-container" style="text-align: right;">
                                    <span class="totale-label">Offerta Economica Woodly</span>
                                    <span class="totale-valore" style="color: #8B5A2B;">
                                        <c:choose>
                                            <c:when test="${not empty richiesta.prezzoProposto}">
                                                <fmt:formatNumber value="${richiesta.prezzoProposto}" pattern="#,##0.00" /> €
                                            </c:when>
                                            <c:otherwise>
                                                <span style="font-size: 16px; font-weight: 500; font-style: italic; color: #a38f7d;">In fase di valutazione...</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
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