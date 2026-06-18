<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Monitoraggio Ordini</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body class="admin-body">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="admin-container">
        <h2 class="admin-title">📜 Registro Vendite Complessivo</h2>
        
        <form action="${pageContext.request.contextPath}/admin/ordini" method="GET" class="admin-filter-form">
            <div>
                <label class="admin-filter-label">Da Data (X):</label>
                <input type="date" name="dataInizio" value="${param.dataInizio}" class="admin-filter-input">
            </div>
            <div>
                <label class="admin-filter-label">A Data (Y):</label>
                <input type="date" name="dataFine" value="${param.dataFine}" class="admin-filter-input">
            </div>
            <div>
                <label class="admin-filter-label">ID Cliente (Numerico):</label>
                <input type="number" name="idCliente" value="${param.idCliente}" placeholder="Es: 1" class="admin-filter-input input-small">
            </div>
            <button type="submit" class="btn-admin-filter">Filtra Ordini</button>
            <a href="${pageContext.request.contextPath}/admin/ordini" class="admin-filter-reset">Resetta</a>
        </form>

        <div class="admin-table-panel">
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>Num Ordine</th>
                        <th>Data/Ora Transazione</th>
                        <th>Cliente (Account)</th>
                        <th>Destinazione Consegna</th>
                        <th class="text-right">Totale</th>
                        <th class="text-center">Stato</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ord" items="${ordini}">
                        <tr>
                            <td class="text-bold">#WDLY-${ord.id}</td>
                            <td><fmt:formatDate value="${ord.dataOrdine}" pattern="dd/MM/yyyy HH:mm" /></td>
                            <td class="text-muted">${ord.cap} (ID: ${ord.idUtente})</td>
                            <td class="text-small">${ord.indirizzo}</td>
                            <td class="text-right text-bold">${ord.totale} €</td>
                            <td class="text-center">
                                <span class="admin-status-badge">
                                    ${ord.stato}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ordini}">
                        <tr>
                            <td colspan="6" class="admin-table-empty">Nessun ordine trovato per i parametri di ricerca inseriti.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>