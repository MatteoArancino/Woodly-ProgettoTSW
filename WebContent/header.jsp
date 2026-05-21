<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                <span class="cart-badge">0</span>
            </a>
        </li>
    </ul>
</nav>