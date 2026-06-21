<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dettaglio Richiesta #${richiesta.id} - Woodly Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css?v=5">
</head>
<body class="admin-body">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="admin-container">
        
        <a href="${pageContext.request.contextPath}/admin/gestione-richieste" style="text-decoration: none; color: #337ab7; font-weight: bold;">&larr; Torna alle richieste</a>
        
        <h2 class="admin-title" style="margin-top: 15px;">Dettaglio Richiesta #${richiesta.id}</h2>
        
        <c:if test="${not empty param.errore}">
            <div style="background-color: #f2dede; color: #a94442; padding: 15px; border-radius: 4px; margin-bottom: 20px;">
                <strong>Errore:</strong> 
                <c:choose>
                    <c:when test="${param.errore == 'PrezzoNonValido'}">Il prezzo inserito non è un formato numerico valido.</c:when>
                    <c:when test="${param.errore == 'AggiornamentoFallito'}">Si è verificato un errore nel salvataggio. Riprova.</c:when>
                    <c:otherwise>Si è verificato un errore imprevisto.</c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <div class="admin-detail-card">
            
            <div class="detail-section">
                <h3>👤 Dati Cliente</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <span class="detail-label">Nome e Cognome</span>
                        <span class="detail-value text-bold">${richiesta.nomeUtente} ${richiesta.cognomeUtente}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Email Contatto</span>
                        <span class="detail-value"><a href="mailto:${richiesta.emailUtente}">${richiesta.emailUtente}</a></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Data Richiesta</span>
                        <span class="detail-value"><fmt:formatDate value="${richiesta.dataRichiesta}" pattern="dd/MM/yyyy - HH:mm"/></span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Stato Attuale</span>
                        <span class="detail-value text-bold" style="color: #337ab7;">${richiesta.stato}</span>
                    </div>
                </div>
            </div>

            <div class="detail-section">
                <h3>🪵 Specifiche Progetto</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <span class="detail-label">Tipo di Mobile</span>
                        <span class="detail-value text-bold">${richiesta.tipoMobile}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Materiale Scelto</span>
                        <span class="detail-value">${richiesta.materiale}</span>
                    </div>
                    <div class="detail-item">
                        <span class="detail-label">Dimensioni (L x A x P)</span>
                        <span class="detail-value">${richiesta.larghezzaCm} x ${richiesta.altezzaCm} x ${richiesta.profonditaCm} cm</span>
                    </div>
                </div>
            </div>

            <div class="detail-section">
                <h3>📝 Descrizione e Note del Cliente</h3>
                <div class="detail-notes">
                    <c:choose>
                        <c:when test="${not empty richiesta.noteCliente}">
                            ${richiesta.noteCliente}
                        </c:when>
                        <c:otherwise>
                            <em>Il cliente non ha lasciato note aggiuntive.</em>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="admin-price-form">
                <h3 style="margin-top: 0; color: #31708f;">💰 Formula la tua Offerta</h3>
                <p style="font-size: 14px; color: #555; margin-bottom: 10px;">
                    Inserisci il prezzo che vuoi proporre al cliente per questa realizzazione. Una volta inviato, lo stato passerà a "Preventivo inviato".
                </p>
                
                <form action="${pageContext.request.contextPath}/admin/dettaglio-richiesta" method="POST">
                    <input type="hidden" name="id" value="${richiesta.id}">
                    
                    <div class="form-group-price">
                        <div class="input-price-wrapper">
                            <span>€</span>
                            <input type="number" step="0.01" min="1" name="prezzo" class="input-price" required 
                                   value="${richiesta.prezzoProposto > 0 ? richiesta.prezzoProposto : ''}" 
                                   placeholder="Es. 450.00">
                        </div>
                        <button type="submit" class="btn-submit-price">Invia Preventivo</button>
                    </div>
                </form>
            </div>

        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>