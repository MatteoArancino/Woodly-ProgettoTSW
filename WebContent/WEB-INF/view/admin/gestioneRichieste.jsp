<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Preventivi Su Misura</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css?v=4">
</head>
<body class="admin-body">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="admin-container">
        <h2 class="admin-title">📐 Gestione Preventivi Su Misura</h2>
        <p class="admin-subtitle">Controlla e rispondi alle richieste di progetti personalizzati inviate dai clienti.</p>

        <div class="admin-table-panel mt-25">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID Utente</th>
                        <th>Nome e Cognome</th>
                        <th>Data</th>
                        <th>Tipo Mobile</th>
                        <th>Materiale</th>
                        <th>Descrizione Progetto</th>
                        <th>Prezzo Proposto</th>
                        <th class="text-center">Stato</th>
                        <th class="text-center">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${richieste}">
                        <tr>
                            <td class="text-bold">#${req.idUtente}</td>
                            
                            <td class="text-bold">${req.nomeUtente} ${req.cognomeUtente}</td>
                            
                            <td><fmt:formatDate value="${req.dataRichiesta}" pattern="dd/MM/yyyy HH:mm"/></td>
                            
                            <td class="text-bold">${req.tipoMobile}</td>
                            
                            <td>${req.materiale}</td>
                            
                            <td class="text-small">
                                📐 ${req.larghezzaCm}x${req.altezzaCm}x${req.profonditaCm} cm<br>
                                <span class="text-muted">
                                    <c:choose>
                                        <c:when test="${fn:length(req.noteCliente) > 40}">
                                            ${fn:substring(req.noteCliente, 0, 40)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${req.noteCliente}
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            
                            <td class="text-bold">
                                <c:choose>
                                    <c:when test="${not empty req.prezzoProposto}">
                                        <fmt:formatNumber value="${req.prezzoProposto}" type="currency" currencySymbol="€"/>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted fw-normal">-</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            
                            <td class="text-center col-stato">
                                <c:choose>
                                    <c:when test="${req.stato == 'In attesa'}">
                                        <span class="admin-status-badge badge-warning">In attesa</span>
                                    </c:when>
                                    <c:when test="${req.stato == 'Preventivo inviato'}">
                                        <span class="admin-status-badge badge-info">Inviato</span>
                                    </c:when>
                                    <c:when test="${req.stato == 'Accettato'}">
                                        <span class="admin-status-badge badge-success">Accettato</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="admin-status-badge badge-danger">${req.stato}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            
                            <td class="text-center">
                                <a href="${pageContext.request.contextPath}/admin/dettaglio-richiesta?id=${req.id}" class="btn-admin-edit">Gestisci</a>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty richieste}">
                        <tr>
                            <td colspan="9" class="admin-table-empty">Nessuna richiesta di preventivo ricevuta al momento.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>