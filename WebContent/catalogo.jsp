<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Catalogo Mobili</title>
    
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h1>Il nostro Catalogo Mobili</h1>
    
    <div class="container">
        <c:forEach var="p" items="${prodotti}">
            <div class="card">
                <img src="${not empty p.immagineUrl ? p.immagineUrl : 'images/default_mobile.jpg'}" alt="${p.nome}">
                <span class="categoria">${p.categoria}</span>
                <h3>${p.nome}</h3>
                <p>${p.description}</p>
                <div class="prezzo">${p.prezzo} €</div>
                <a href="AggiungiAlCarrello?id=${prodotto.id}" class="btn-carrello">Aggiungi al carrello</a>
                
            </div>
        </c:forEach>
    </div>
</body>
</html>