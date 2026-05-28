<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Il tuo Carrello</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="carrello-main-container">
        
        <c:choose>
            <%-- SCENARIO A: Il carrello non esiste in sessione oppure è vuoto --%>
            <c:when test="${empty sessionScope.carrello || empty sessionScope.carrello.items}">
                <div class="carrello-vuoto-box">
                    <div class="icona-vuoto">🛒</div>
                    <h3>Il tuo carrello è vuoto</h3>
                    <p>Non hai ancora aggiunto nessun mobile della nostra collezione al tuo ordine.</p>
                    <a href="catalogo" class="btn-hero">Esplora il Catalogo</a>
                </div>
            </c:when>

            <%-- SCENARIO B: Il carrello contiene prodotti --%>
            <c:otherwise>
                <h2 class="section-title">Il tuo Carrello</h2>
                
                <div class="carrello-layout-split">
                    
                    <div class="carrello-tabella-wrapper">
                        <table class="tabella-carrello">
                            <thead>
                                <tr>
                                    <th>Prodotto</th>
                                    <th>Prezzo</th>
                                    <th>Quantità</th>
                                    <th>Subtotale</th>
                                    <th>Azione</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.carrello.items}">
                                    <tr>
                                        <td class="td-prodotto">
                                            <div class="carrello-prod-info">
                                                <div class="mini-placeholder">🪵</div>
                                                <div>
                                                    <h4>${item.prodotto.nome}</h4>
                                                    <small class="categoria-tag">${item.prodotto.categoria}</small>
                                                </div>
                                            </div>
                                        </td>
                                        
                                        <td class="testo-scuro">${item.prodotto.prezzo} €</td>
                                        
                                        <td>
                                            <div class="selettore-quantita">
                                                <span class="valore-quantita">${item.quantita}</span>
                                            </div>
                                        </td>
                                        
                                        <td class="testo-rame f-bold">${item.prodotto.prezzo * item.quantita} €</td>
                                        
                                        <td>
                                            <a href="RimuoviDalCarrello?id=${item.prodotto.id}" class="link-elimina">Elimina</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="carrello-sidebar-riepilogo">
                        <h3>Riepilogo Ordine</h3>
                        
                        <c:set var="totaleEuro" value="0" />
                        <c:forEach var="item" items="${sessionScope.carrello.items}">
                            <c:set var="totaleEuro" value="${totaleEuro + (item.prodotto.prezzo * item.quantita)}" />
                        </c:forEach>
                        
                        <div class="riepilogo-riga">
                            <span>Articoli totali:</span>
                            <span>${sessionScope.carrello.quantitaTotale}</span>
                        </div>
                        
                        <div class="riepilogo-riga">
                            <span>Spedizione:</span>
                            <span class="testo-verde">Gratuita</span>
                        </div>
                        
                        <div class="spazio-divider"></div>
                        
                        <div class="riepilogo-riga riga-totale">
                            <span>Totale Finale:</span>
                            <span>${totaleEuro} €</span>
                        </div>
                        
                        <a href="checkout" class="btn-checkout-procedi">Procedi all'Acquisto</a>
                        <a href="catalogo" class="btn-continua-shopping">Continua lo Shopping</a>
                    </div>
                    
                </div>
            </c:otherwise>
        </c:choose>
        
    </main>

    <jsp:include page="footer.jsp" />

</body>
</html>