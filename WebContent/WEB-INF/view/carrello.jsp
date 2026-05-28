<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Il tuo Carrello</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="carrello-premium-container">
        
        <c:choose>
            <%-- SCENARIO A: Il carrello è vuoto o non ci sono elementi --%>
            <c:when test="${empty sessionScope.carrello || empty sessionScope.carrello.items}">
                <div class="vuoto-premium-box">
                    <div class="vuoto-art">🛒</div>
                    <h3>Il tuo carrello è vuoto.</h3>
                    <p>Sembra che tu non abbia ancora scelto il pezzo perfetto per la tua casa.</p>
                    <a href="${pageContext.request.contextPath}/catalogo" class="btn-hero">Torna al Catalogo</a>
                </div>
            </c:when>

            <%-- SCENARIO B: Ci sono prodotti nel carrello --%>
            <c:otherwise>
                <div class="carrello-header-flex">
                    <h2 class="titolo-premium">Il tuo Ordine</h2>
                    <span class="conteggio-articoli">(${sessionScope.carrello.quantitaTotale} articoli)</span>
                </div>
                
                <div class="layout-split-moderno">
                    
                    <div class="elenco-prodotti-moderno">
                        <c:forEach var="item" items="${sessionScope.carrello.items}">
                            <div class="cart-item-card-horizontal">
                                
                                <div class="item-img-container">
                                    <div class="img-placeholder-elegante">🪵</div>
                                </div>

                                <div class="item-dettagli">
                                    <div class="dettagli-sopra">
                                        <small class="item-categoria">${item.prodotto.categoria}</small>
                                        <h4>${item.prodotto.nome}</h4>
                                    </div>
                                    <div class="dettagli-sotto">
                                        <a href="${pageContext.request.contextPath}/RimuoviDalCarrello?id=${item.prodotto.id}" class="btn-icon-rimuovi">✕ Rimuovi</a>
                                    </div>
                                </div>

                                <div class="item-prezzi-quantita">
                                    <div class="item-quantita-display">
                                        <label>Qta:</label>
                                        <span class="qta-valore">${item.quantita}</span>
                                    </div>
                                    <div class="subtotale-display">
                                        <small>subtotale:</small>
                                        <span class="prezzo-finale">${item.prodotto.prezzo * item.quantita} €</span>
                                    </div>
                                </div>
                                
                            </div>
                        </c:forEach>
                    </div>

                    <aside class="sidebar-riepilogo-moderna">
                        <div class="riepilogo-card-premium">
                            <h3>Riepilogo</h3>
                            
                            <c:set var="totaleEuro" value="0" />
                            <c:forEach var="item" items="${sessionScope.carrello.items}">
                                <c:set var="totaleEuro" value="${totaleEuro + (item.prodotto.prezzo * item.quantita)}" />
                            </c:forEach>
                            
                            <div class="riga-info">
                                <span>Spedizione stimata</span>
                                <span class="spedizione-gratis">Gratuita</span>
                            </div>
                            
                            <hr class="divider-elegante">
                            
                            <div class="riga-totale-premium">
                                <span>Totale Finale</span>
                                <span class="prezzo-totale-bello">${totaleEuro} €</span>
                            </div>
                            
                            <a href="${pageContext.request.contextPath}/checkout" class="btn-procedi-checkout-bello">Procedi all'Acquisto</a>
                        </div>
                    </aside>
                    
                </div>
            </c:otherwise>
        </c:choose>
        
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>