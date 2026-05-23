<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Carrello" %>

<%
    //Recuperiamo il carrello dalla sessione corrente
    Carrello cart = (Carrello) session.getAttribute("carrello");
    
    //Se il carrello esiste, prendiamo la quantità totale, altrimenti partiamo da 0
    int conteggioArticoli = (cart != null) ? cart.getQuantitaTotale() : 0;
%>

<nav class="navbar">
    <div class="nav-logo"><a href="index.jsp">Woodly</a></div>
    
    <div class="search-container">
        <form action="CercaProdottiServlet" method="GET">
            <input type="text" name="query" placeholder="Cerca tavoli, sedie, librerie..." required>
            <button type="submit">🔍</button>
        </form>
    </div>

    <ul class="nav-links">
        <li><a href="index.jsp">Home</a></li>
        <li><a href="catalogo">Catalogo</a></li>
        <li><a href="login.jsp">👤 Accedi</a></li>
        <li>
            <a href="carrello.jsp" class="cart-icon">
                🛒 Carrello 
                <span class="cart-badge"><%= conteggioArticoli %></span>
            </a>
        </li>
    </ul>
</nav>