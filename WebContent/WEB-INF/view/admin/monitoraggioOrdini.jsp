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
<body style="background: #f4f5f7;">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main style="max-width: 1000px; margin: 40px auto; padding: 0 20px;">
        <h2 style="font-family: 'Playfair Display', serif;">📜 Registro Vendite Complessivo</h2>
        
        <form action="${pageContext.request.contextPath}/admin/ordini" method="GET" style="background: white; padding: 20px; border-radius: 6px; border:1px solid #ddd; display: flex; gap:15px; align-items: flex-end; flex-wrap: wrap; margin-bottom: 25px;">
            <div>
                <label style="font-size:12px; font-weight:bold; display:block; margin-bottom:5px;">Da Data (X):</label>
                <input type="date" name="dataInizio" value="${param.dataInizio}" style="padding:6px; border:1px solid #ccc; border-radius:4px;">
            </div>
            <div>
                <label style="font-size:12px; font-weight:bold; display:block; margin-bottom:5px;">A Data (Y):</label>
                <input type="date" name="dataFine" value="${param.dataFine}" style="padding:6px; border:1px solid #ccc; border-radius:4px;">
            </div>
            <div>
                <label style="font-size:12px; font-weight:bold; display:block; margin-bottom:5px;">ID Cliente (Numerico):</label>
                <input type="number" name="idCliente" value="${param.idCliente}" placeholder="Es: 1" style="padding:6px; border:1px solid #ccc; border-radius:4px; width:120px;">
            </div>
            <button type="submit" style="background:#333; color:white; padding:8px 15px; border:none; border-radius:4px; font-weight:600; cursor:pointer;">Filtra Ordini</button>
            <a href="${pageContext.request.contextPath}/admin/ordini" style="font-size:13px; color:#007bff; text-decoration:none; padding-bottom:8px;">Resetta</a>
        </form>

        <div style="background: white; padding: 25px; border-radius: 8px; border: 1px solid #ddd;">
            <table style="width:100%; border-collapse:collapse; text-align:left; font-size:14px;">
                <thead>
                    <tr style="background:#f8f9fa; border-bottom:2px solid #dee2e6; color:#555;">
                        <th style="padding:10px;">Num Ordine</th>
                        <th style="padding:10px;">Data/Ora Transazione</th>
                        <th style="padding:10px;">Cliente (Account)</th>
                        <th style="padding:10px;">Destinazione Consegna</th>
                        <th style="padding:10px; text-align:right;">Totale</th>
                        <th style="padding:10px; text-align:center;">Stato</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ord" items="${ordini}">
                        <tr style="border-bottom:1px solid #eee;">
                            <td style="padding:10px; font-weight:bold;">#WDLY-${ord.id}</td>
                            <td style="padding:10px;"><fmt:formatDate value="${ord.dataOrdine}" pattern="dd/MM/yyyy HH:mm" /></td>
                            <td style="padding:10px; color:#555;">${ord.cap} (ID: ${ord.idUtente})</td>
                            <td style="padding:10px; font-size:13px;">${ord.indirizzo}</td>
                            <td style="padding:10px; text-align:right; font-weight:bold;">${ord.totale} €</td>
                            <td style="padding:10px; text-align:center;">
                                <span style="padding:3px 8px; border-radius:12px; font-size:11px; font-weight:bold; background:#fff3cd; color:#856404;">
                                    ${ord.stato}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty ordini}">
                        <tr>
                            <td colspan="6" style="padding:20px; text-align:center; color:#999;">Nessun ordine trovato per i parametri di ricerca inseriti.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>