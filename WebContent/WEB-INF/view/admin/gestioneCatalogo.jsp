<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Gestione Catalogo</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body style="background: #f4f5f7;">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main style="max-width: 1100px; margin: 40px auto; padding: 0 20px; display: flex; gap: 30px; flex-wrap: wrap;">
        
        <div style="flex: 1; min-width: 300px; background: white; padding: 25px; border-radius: 8px; border: 1px solid #ddd; height: fit-content;">
            
            <c:if test="${not empty sessionScope.messaggioSuccesso}">
                <div style="background-color: #d4edda; color: #155724; padding: 12px; border-radius: 5px; margin-bottom: 15px; text-align: center; border: 1px solid #c3e6cb; font-weight: bold;">
                    ✔ ${sessionScope.messaggioSuccesso}
                </div>
                <%-- Pulizia del messaggio dalla sessione dopo averlo mostrato --%>
                <c:remove var="messaggioSuccesso" scope="session" />
            </c:if>

            <h3 style="margin-top:0;">
                <c:choose>
                    <c:when test="${not empty prodottoSelezionato}">✏️ Modifica Mobile ID #${prodottoSelezionato.id}</c:when>
                    <c:otherwise>➕ Aggiungi Nuovo Mobile</c:otherwise>
                </c:choose>
            </h3>
            
            <form action="${pageContext.request.contextPath}/admin/catalogo" method="POST" enctype="multipart/form-data" style="display: flex; flex-direction: column; gap: 12px;">
                <input type="hidden" name="id" value="${prodottoSelezionato.id}">
                
                <label style="font-size:13px; font-weight:600;">Nome Prodotto:</label>
                <input type="text" name="nome" value="${prodottoSelezionato.nome}" required style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                
                <label style="font-size:13px; font-weight:600;">Categoria:</label>
                <select name="categoria" style="padding:8px; border:1px solid #ccc; border-radius:4px;">
                    <option value="Tavoli" ${prodottoSelezionato.categoria == 'Tavoli' ? 'selected' : ''}>Tavoli</option>
                    <option value="Sedie" ${prodottoSelezionato.categoria == 'Sedie' ? 'selected' : ''}>Sedie</option>
                    <option value="Librerie" ${prodottoSelezionato.categoria == 'Librerie' ? 'selected' : ''}>Librerie</option>
                    <option value="Armadi" ${prodottoSelezionato.categoria == 'Armadi' ? 'selected' : ''}>Armadi</option>
                </select>

                <label style="font-size:13px; font-weight:600;">Prezzo (€):</label>
                <input type="number" step="0.01" name="prezzo" value="${prodottoSelezionato.prezzo}" required style="padding:8px; border:1px solid #ccc; border-radius:4px;">

                <label style="font-size:13px; font-weight:600;">Quantità Magazzino:</label>
                <input type="number" name="quantita" value="${prodottoSelezionato.quantitaMagazzino}" required style="padding:8px; border:1px solid #ccc; border-radius:4px;">

                <label style="font-size:13px; font-weight:600;">Immagine del Prodotto:</label>
                <c:if test="${not empty prodottoSelezionato.immagineUrl}">
                    <span style="font-size: 11px; color: #666;">Immagine attuale: ${prodottoSelezionato.immagineUrl}</span>
                    <input type="hidden" name="vecchiaImmagine" value="${prodottoSelezionato.immagineUrl}">
                </c:if>
                <input type="file" name="immagine" accept="image/*" style="padding:8px; border:1px solid #ccc; border-radius:4px;" ${empty prodottoSelezionato ? 'required' : ''}>

                <label style="font-size:13px; font-weight:600;">Descrizione:</label>
                <textarea name="descrizione" rows="4" required style="padding:8px; border:1px solid #ccc; border-radius:4px; resize:none;">${prodottoSelezionato.description}</textarea>

                <button type="submit" style="background:#28a745; color:white; border:none; padding:12px; font-weight:600; border-radius:4px; cursor:pointer; margin-top:10px;">
                    Salva Prodotto
                </button>
                <c:if test="${not empty prodottoSelezionato}">
                    <a href="${pageContext.request.contextPath}/admin/catalogo" style="text-align:center; color:#666; font-size:13px; margin-top:5px;">Annulla Modifica</a>
                </c:if>
            </form>
        </div>

        <div style="flex: 2; min-width: 500px; background: white; padding: 25px; border-radius: 8px; border: 1px solid #ddd;">
            <h3 style="margin-top:0;">📦 Lista Articoli in Pronta Consegna</h3>
            
            <table style="width:100%; border-collapse:collapse; font-size:14px; margin-top:15px; text-align:left;">
                <thead>
                    <tr style="background:#f8f9fa; border-bottom:2px solid #dee2e6;">
                        <th style="padding:10px;">ID</th>
                        <th style="padding:10px;">Nome</th>
                        <th style="padding:10px;">Categoria</th>
                        <th style="padding:10px;">Prezzo</th>
                        <th style="padding:10px; text-align:center;">Qta</th>
                        <th style="padding:10px; text-align:center;">Azioni</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="prod" items="${prodotti}">
                        <tr style="border-bottom:1px solid #eee;">
                            <td style="padding:10px;">#${prod.id}</td>
                            <td style="padding:10px; font-weight:500;">${prod.nome}</td>
                            <td style="padding:10px; color:#666;">${prod.categoria}</td>
                            <td style="padding:10px;">${prod.prezzo} €</td>
                            <td style="padding:10px; text-align:center; font-weight:bold; color:${prod.quantitaMagazzino <= 2 ? '#dc3545' : '#28a745'}">${prod.quantitaMagazzino}</td>
                            <td style="padding:10px; text-align:center; display:flex; gap:8px; justify-content:center;">
                                <a href="${pageContext.request.contextPath}/admin/catalogo?idModifica=${prod.id}" style="background:#007bff; color:white; padding:5px 10px; text-decoration:none; border-radius:3px; font-size:12px;">Modifica</a>
                                
                                <a href="${pageContext.request.contextPath}/admin/catalogo?action=delete&id=${prod.id}" style="background:#dc3545; color:white; padding:5px 10px; text-decoration:none; border-radius:3px; font-size:12px;">Elimina</a>
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