<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Gestione Catalogo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body class="admin-body">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="admin-layout-split">
        
        <div class="admin-form-panel">
            
            <c:if test="${not empty sessionScope.messaggioSuccesso}">
                <div class="admin-alert-success">
                    ✔ ${sessionScope.messaggioSuccesso}
                </div>
                <%-- Pulizia del messaggio dalla sessione dopo averlo mostrato --%>
                <c:remove var="messaggioSuccesso" scope="session" />
            </c:if>

            <h3 class="admin-panel-title">
                <c:choose>
                    <c:when test="${not empty prodottoSelezionato}">✏️ Modifica Mobile ID #${prodottoSelezionato.id}</c:when>
                    <c:otherwise>➕ Aggiungi Nuovo Mobile</c:otherwise>
                </c:choose>
            </h3>
            
            <form action="${pageContext.request.contextPath}/admin/catalogo" method="POST" enctype="multipart/form-data" class="admin-form">
                <input type="hidden" name="id" value="${prodottoSelezionato.id}">
                
                <label class="admin-form-label">Nome Prodotto:</label>
                <input type="text" name="nome" value="${prodottoSelezionato.nome}" required class="admin-form-input">
                
                <label class="admin-form-label">Categoria:</label>
                <select name="categoria" class="admin-form-input">
                    <option value="Tavoli" ${prodottoSelezionato.categoria == 'Tavoli' ? 'selected' : ''}>Tavoli</option>
                    <option value="Sedie" ${prodottoSelezionato.categoria == 'Sedie' ? 'selected' : ''}>Sedie</option>
                    <option value="Librerie" ${prodottoSelezionato.categoria == 'Librerie' ? 'selected' : ''}>Librerie</option>
                    <option value="Armadi" ${prodottoSelezionato.categoria == 'Armadi' ? 'selected' : ''}>Armadi</option>
                </select>

                <label class="admin-form-label">Prezzo (€):</label>
                <input type="number" step="0.01" name="prezzo" value="${prodottoSelezionato.prezzo}" required class="admin-form-input">

                <label class="admin-form-label">Quantità Magazzino:</label>
                <input type="number" name="quantita" value="${prodottoSelezionato.quantitaMagazzino}" required class="admin-form-input">

                <label class="admin-form-label">Immagine del Prodotto:</label>
                <c:if test="${not empty prodottoSelezionato.immagineUrl}">
                    <span class="admin-form-hint">Immagine attuale: ${prodottoSelezionato.immagineUrl}</span>
                    <input type="hidden" name="vecchiaImmagine" value="${prodottoSelezionato.immagineUrl}">
                </c:if>
                <input type="file" name="immagine" accept="image/*" class="admin-form-input" ${empty prodottoSelezionato ? 'required' : ''}>

                <label class="admin-form-label">Descrizione:</label>
                <textarea name="descrizione" rows="4" required class="admin-form-input">${prodottoSelezionato.description}</textarea>

                <button type="submit" class="btn-admin-submit">
                    Salva Prodotto
                </button>
                <c:if test="${not empty prodottoSelezionato}">
                    <a href="${pageContext.request.contextPath}/admin/catalogo" class="btn-admin-cancel">Annulla Modifica</a>
                </c:if>
            </form>
        </div>

        <div class="admin-table-panel">
            <h3 class="admin-panel-title">📦 Lista Articoli in Pronta Consegna</h3>
            
            <table class="admin-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nome</th>
                        <th>Categoria</th>
                        <th>Prezzo</th>
                        <th class="text-center">Qta</th>
                        <th class="text-center">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prod" items="${prodotti}">
                        <tr>
                            <td>#${prod.id}</td>
                            <td style="font-weight:500;">${prod.nome}</td>
                            <td style="color:#666;">${prod.categoria}</td>
                            <td>${prod.prezzo} €</td>
                            <td class="text-center ${prod.quantitaMagazzino <= 2 ? 'qta-low' : 'qta-ok'}">
                                ${prod.quantitaMagazzino}
                            </td>
                            <td class="admin-table-actions">
                                <a href="${pageContext.request.contextPath}/admin/catalogo?idModifica=${prod.id}" class="btn-admin-edit">Modifica</a>
                                <a href="${pageContext.request.contextPath}/admin/catalogo?action=delete&id=${prod.id}" class="btn-admin-delete">Elimina</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>