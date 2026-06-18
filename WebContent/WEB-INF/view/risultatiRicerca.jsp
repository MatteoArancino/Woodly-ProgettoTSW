<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Risultati Ricerca</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="section-home">
        <h2 class="section-title">Risultati per: "<%= request.getAttribute("chiaveCercata") %>"</h2>
        
        <div class="products-grid-home">
            <% 
                // Recuperiamo la lista passata dalla Servlet
                List<Prodotto> risultati = (List<Prodotto>) request.getAttribute("prodottiCercati");
                
                // Scenario A: Nessun elemento trovato nel DB
                if (risultati == null || risultati.isEmpty()) {
            %>
                <div class="ricerca-vuota-box">
                    <p class="ricerca-vuota-messaggio">
                        Spiacenti, nessun mobile corrisponde ai criteri cercati.
                    </p>
                    <a href="catalogo" class="btn-hero">Esplora l'intero Catalogo</a>
                </div>
            <% 
                // Scenario B: Ci sono dei prodotti da mostrare
                } else {
                    for (Prodotto p : risultati) {
            %>
                    <div class="product-card-home">
                        <img src="${pageContext.request.contextPath}/<%= (p.getImmagineUrl() != null && !p.getImmagineUrl().isEmpty()) ? p.getImmagineUrl() : "images/default.png" %>" 
                             onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default.png';" 
                             alt="<%= p.getNome() %>">
                             
                        <h3><%= p.getNome() %></h3>
                        <p class="ricerca-prod-descrizione">
                            <%= p.getDescription() %>
                        </p>
                        <p class="price"><%= String.format("%.2f", p.getPrezzo()) %> €</p>
                        <a href="AggiungiAlCarrello?id=<%= p.getId() %>" class="btn-add-cart">Aggiungi al carrello</a>
                    </div>
            <% 
                    }
                }
            %>
        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>