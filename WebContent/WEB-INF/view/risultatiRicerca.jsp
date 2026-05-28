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
                <div style="text-align: center; width: 100%; padding: 40px 0;">
                    <p style="font-size: 1.3em; color: #6d4a2a; margin-bottom: 20px;">
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
                        <div class="prod-img-placeholder">🪵</div>
                        <h3><%= p.getNome() %></h3>
                        <p style="font-size: 0.9em; color: #6d4a2a; margin-bottom: 12px; min-height: 40px;">
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