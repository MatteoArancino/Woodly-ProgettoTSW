<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Prodotto" %>
<%
    // Recuperiamo i dati passati dalla CatalogoServlet
    List<Prodotto> listaProdotti = (List<Prodotto>) request.getAttribute("prodotti");
    String categoriaAttiva = (String) request.getAttribute("categoriaAttiva");
    if (categoriaAttiva == null) categoriaAttiva = "tutti";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Catalogo Mobili</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

    <jsp:include page="header.jsp" />

    <main class="catalogo-main">
        
        <section class="filtri-container">
            <h2 class="catalogo-titolo">Il Nostro Catalogo</h2>
            <div class="bottoni-filtro">
                <a href="catalogo" class="btn-filtro <%= categoriaAttiva.equals("tutti") ? "active" : "" %>">Tutti i Prodotti</a>
                <a href="catalogo?categoria=tavoli" class="btn-filtro <%= categoriaAttiva.equals("tavoli") ? "active" : "" %>">Tavoli</a>
                <a href="catalogo?categoria=sedie" class="btn-filtro <%= categoriaAttiva.equals("sedie") ? "active" : "" %>">Sedie</a>
                <a href="catalogo?categoria=librerie" class="btn-filtro <%= categoriaAttiva.equals("librerie") ? "active" : "" %>">Librerie</a>
            </div>
        </section>

        <section class="griglia-catalogo-container">
            <div class="products-grid-home">
                <% 
                    if (listaProdotti == null || listaProdotti.isEmpty()) {
                %>
                    <p class="no-prodotti">Nessun prodotto disponibile in questa categoria al momento.</p>
                <% 
                    } else {
                        for (Prodotto p : listaProdotti) {
                %>
                        <div class="product-card-home">
                            <div class="prod-img-placeholder">🪵</div>
                            <h3><%= p.getNome() %></h3>
                            <p class="prod-descrizione"><%= p.getDescription() %></p>
                            <p class="price"><%= String.format("%.2f", p.getPrezzo()) %> €</p>
                            
                            <a href="AggiungiAlCarrello?id=<%= p.getId() %>" class="btn-add-cart">Aggiungi al carrello</a>
                        </div>
                <% 
                        }
                    }
                %>
            </div>
        </section>

    </main>

    <jsp:include page="footer.jsp" />

</body>
</html>