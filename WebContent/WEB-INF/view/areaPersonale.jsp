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

    <main class="carrello-premium-container" style="max-width: 900px; margin: 40px auto; padding: 0 20px;">
        
        <div style="background: #fdfbf7; border: 1px solid #e6dfd3; padding: 25px; border-radius: 8px; margin-bottom: 40px; display: flex; justify-content: space-between; align-items: center;">
            <div>
                <h2 class="titolo-premium" style="margin: 0 0 10px 0; font-size: 28px;">Benvenuto, ${utenteLoggato.nome} ${utenteLoggato.cognome}</h2>
                <p style="margin: 0; color: #666; font-size: 14px;">Account collegato: <strong>${utenteLoggato.email}</strong></p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/logout" style="background: #a94442; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; font-weight: 600; font-size: 14px; transition: background 0.2s;">
                    Disconnetti (Logout)
                </a>
            </div>
        </div>

        <h3 class="titolo-premium" style="font-size: 22px; margin-bottom: 20px; border-bottom: 2px solid #333; padding-bottom: 10px;">Il tuo Storico Acquisti</h3>

        <c:if test="${empty storicoOrdini}">
            <div class="vuoto-premium-box" style="padding: 40px 20px; text-align: center; border: 1px dashed #ccc; border-radius: 6px;">
                <p style="color: #666; font-size: 16px;">Non hai ancora effettuato ordini su Woodly.</p>
                <a href="${pageContext.request.contextPath}/catalogo" class="btn-hero" style="display: inline-block; margin-top: 10px; padding: 10px 20px;">Esplora il Catalogo</a>
            </div>
        </c:if>

        <c:if test="${not empty storicoOrdini}">
            <div style="display: flex; flex-direction: column; gap: 25px; margin-bottom: 5px;">
                <c:forEach var="ordine" items="${storicoOrdini}">
                    
                    <div style="border: 1px solid #ddd; border-radius: 6px; overflow: hidden; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.02);">
                        
                        <div style="background: #f5f5f5; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #eee; flex-wrap: wrap; gap: 10px;">
                            <div>
                                <span style="font-size: 12px; color: #777; display: block; text-transform: uppercase;">Ordine effettuato il</span>
                                <strong style="color: #333;"><fmt:formatDate value="${ordine.dataOrdine}" pattern="dd MMMM yyyy - HH:mm" /></strong>
                            </div>
                            <div>
                                <span style="font-size: 12px; color: #777; display: block; text-transform: uppercase; text-align: right;">ID Spedizione</span>
                                <strong style="color: #333;">#WDLY-${ordine.id}</strong>
                            </div>
                            <div>
                                <span style="font-size: 12px; color: #777; display: block; text-transform: uppercase; text-align: right;">Stato</span>
                                <span style="display: inline-block; padding: 4px 10px; border-radius: 20px; font-size: 12px; font-weight: bold; 
                                             background: ${ordine.stato == 'Consegnato' ? '#d4edda' : (ordine.stato == 'Annullato' ? '#f8d7da' : '#fff3cd')}; 
                                             color: ${ordine.stato == 'Consegnato' ? '#155724' : (ordine.stato == 'Annullato' ? '#721c24' : '#856404')};">
                                    ${ordine.stato}
                                </span>
                            </div>
                        </div>

                        <div style="padding: 20px;">
                            <table style="width: 100%; border-collapse: collapse; text-align: left; font-size: 14px;">
                                <thead>
                                    <tr style="border-bottom: 2px solid #eee; color: #555;">
                                        <th style="padding: 8px 0; font-weight: 600;">Elemento Artigianale</th>
                                        <th style="padding: 8px 0; font-weight: 600; text-align: center; width: 80px;">Qta</th>
                                        <th style="padding: 8px 0; font-weight: 600; text-align: right; width: 120px;">Prezzo Unitario</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="dettaglio" items="${ordine.dettagli}">
                                        <tr style="border-bottom: 1px solid #f9f9f9; color: #333;">
                                            <td style="padding: 12px 0; font-weight: 500;">${dettaglio.nomeProdotto}</td>
                                            <td style="padding: 12px 0; text-align: center; color: #666;">x${dettaglio.quantita}</td>
                                            <td style="padding: 12px 0; text-align: right;">
                                                <fmt:formatNumber value="${dettaglio.prezzoAcquisto}" pattern="#,##0.00" /> €
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            
                            <div style="margin-top: 20px; padding-top: 15px; border-top: 1px dashed #eee; display: flex; justify-content: space-between; align-items: flex-end; flex-wrap: wrap; gap: 15px;">
                                <div style="font-size: 13px; color: #666;">
                                    <span style="display:block; font-size: 11px; text-transform: uppercase; color: #999;">Destinazione:</span>
                                    ${ordine.indirizzo}, ${ordine.citta} (${ordine.cap})<br>
                                    Pagato con: <em>${ordine.metodoPagamento}</em>
                                </div>
                                <div style="text-align: right;">
                                    <span style="font-size: 12px; color: #777; text-transform: uppercase; display: block;">Totale Transazione</span>
                                    <span style="font-size: 20px; font-weight: bold; color: #333;"><fmt:formatNumber value="${ordine.totale}" pattern="#,##0.00" /> €</span>
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