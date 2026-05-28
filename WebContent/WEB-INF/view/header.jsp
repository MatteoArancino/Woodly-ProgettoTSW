<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<nav class="navbar">
    <div class="nav-logo">
        <a href="${pageContext.request.contextPath}/home">Woodly</a>
    </div>
    
    <div class="search-container">
        <form action="${pageContext.request.contextPath}/CercaProdottiServlet" method="GET">
            <input type="text" name="query" placeholder="Cerca tavoli, sedie, librerie..." required>
            <button type="submit">🔍</button>
        </form>
    </div>

    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a href="${pageContext.request.contextPath}/catalogo">Catalogo</a></li>
        <li><a href="${pageContext.request.contextPath}/login">👤 Accedi</a></li>
        <li>
            <a href="${pageContext.request.contextPath}/carrello" class="cart-icon">
                🛒 Carrello 
                <span class="cart-badge">
                    ${not empty sessionScope.carrello ? sessionScope.carrello.quantitaTotale : 0}
                </span>
            </a>
        </li>
    </ul>
</nav>