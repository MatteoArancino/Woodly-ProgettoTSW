<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- Se usi Tomcat 9 cambia l'URI in http://java.sun.com/jsp/jstl/core --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Catalogo Mobili</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="catalogo-main">
        
        <section class="filtri-container">
            <h2 class="catalogo-titolo">Il Nostro Catalogo</h2>
            <div class="bottoni-filtro">
                <a href="${pageContext.request.contextPath}/catalogo" class="btn-filtro ${requestScope.categoriaAttiva == 'tutti' ? 'active' : ''}">Tutti i Prodotti</a>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=tavoli" class="btn-filtro ${requestScope.categoriaAttiva == 'tavoli' ? 'active' : ''}">Tavoli</a>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=sedie" class="btn-filtro ${requestScope.categoriaAttiva == 'sedie' ? 'active' : ''}">Sedie</a>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=librerie" class="btn-filtro ${requestScope.categoriaAttiva == 'librerie' ? 'active' : ''}">Librerie</a>
            </div>
        </section>

        <section class="griglia-catalogo-container">
            <div class="products-grid-home">
                <c:choose>
                    <%-- SCENARIO A: Il Database o il filtro non hanno restituito prodotti --%>
                    <c:when test="${empty requestScope.prodotti}">
                        <p class="no-prodotti">Nessun prodotto disponibile in questa categoria al momento.</p>
                    </c:when>
                    
                    <%-- SCENARIO B: Ci sono prodotti. Cicliamo su di essi con JSTL --%>
                    <c:otherwise>
                        <c:forEach var="p" items="${requestScope.prodotti}">
                            <div class="product-card-home">
                               
                               <img src="${pageContext.request.contextPath}/${not empty p.immagineUrl ? p.immagineUrl : 'images/default.png'}" 
                                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default.png';" 
                                    alt="${p.nome}" 
                                    class="img-catalogo">
                                    
                               <h3>${p.nome}</h3>
                               <p class="prod-descrizione">${p.description}</p>
                               <p class="price">${p.prezzo} €</p>
                                
                                <%-- Form per l'aggiunta sicura in POST alla Servlet dedicata del carrello --%>
                                <form action="${pageContext.request.contextPath}/AggiungiAlCarrello" method="POST">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <button type="submit" class="btn-add-cart btn-add-cart-full">
                                        Aggiungi al carrello
                                    </button>
                                </form>
                                
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>