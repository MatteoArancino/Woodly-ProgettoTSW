<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %> <%-- Pronto per JSTL qualora volessi renderla dinamica in futuro --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Arredamento Artigianale in Vero Legno</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <header class="hero">
        <div class="hero-content">
            <h1>Arredamento in Vero Legno Massello</h1>
            <p>Design senza tempo e sostenibilità. Creato artigianalmente in Italia per durare generazioni.</p>
            <a href="${pageContext.request.contextPath}/catalogo" class="btn-hero">Scopri la Collezione</a>
        </div>
    </header>

    <section class="trust-bar">
        <div class="trust-item"><span>📦</span> <p><strong>Spedizione Gratuita</strong> sopra i 150€</p></div>
        <div class="trust-item"><span>🇮🇹</span> <p><strong>100% Made in Italy</strong> Legno certificato</p></div>
        <div class="trust-item"><span>🔒</span> <p><strong>Pagamento Sicuro</strong> PayPal & Carte</p></div>
        <div class="trust-item"><span>🛠️</span> <p><strong>Garanzia 5 Anni</strong> Qualità artigiana</p></div>
    </section>

    <section class="section-home">
        <h2 class="section-title">Esplora le Categorie</h2>
        <div class="categories-grid">
            <a href="${pageContext.request.contextPath}/catalogo?categoria=tavoli" class="category-card">
                <div class="category-info"><h3>Tavoli e Scrivanie</h3></div>
            </a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=sedie" class="category-card">
                <div class="category-info"><h3>Sedie e Sgabelli</h3></div>
            </a>
            <a href="${pageContext.request.contextPath}/catalogo?categoria=librerie" class="category-card">
                <div class="category-info"><h3>Librerie e Pareti</h3></div>
            </a>
        </div>
    </section>

    <section class="section-home background-soft">
        <h2 class="section-title">I Nostri Pezzi Più Venduti</h2>
        <div class="products-grid-home">
    
	    <c:forEach var="prodotto" items="${prodottiPiuVenduti}">
	        <div class="product-card-home">	        
	            <div class="badge-promo">In evidenza</div>	            
	            <img src="${pageContext.request.contextPath}/${not empty p.immagineUrl ? p.immagineUrl : 'images/default.png'}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/images/default.png';" alt="${p.nome}" style="width: 100%; height: 200px; object-fit: cover; border-radius: 8px; margin-bottom: 10px;"><h3>${p.nome}</h3>
                               
	            <h3>${prodotto.nome}</h3>	            
	            <p class="price">${prodotto.prezzo} €</p>	            
	            <a href="${pageContext.request.contextPath}/AggiungiAlCarrello?id=${prodotto.id}" class="btn-add-cart">Aggiungi al carrello</a>	            
	        </div>
	        
	    </c:forEach>
	    
	</div>
    </section>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>