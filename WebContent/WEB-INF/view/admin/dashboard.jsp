<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Pannello Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body class="admin-body">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main class="admin-container">
        <h1 class="admin-title">Pannello di Controllo Amministratore</h1>
        <p class="admin-subtitle">Benvenuto nel back-office di Woodly. Scegli una delle sezioni per gestire l'e-commerce:</p>

        <div class="admin-dashboard-grid">
            
            <div class="admin-card">
                <h3 class="admin-card-title">📦 Gestione Catalogo</h3>
                <p class="admin-card-text">Inserisci nuovi elementi d'arredo, modifica i dettagli dei mobili esistenti o cancella articoli fuori produzione.</p>
                <a href="${pageContext.request.contextPath}/admin/catalogo" class="btn-admin-action">Gestisci Prodotti</a>
            </div>

            <div class="admin-card">
                <h3 class="admin-card-title">📜 Monitoraggio Ordini</h3>
                <p class="admin-card-text">Visualizza l'elenco globale delle vendite effettuate. Filtra per intervallo di date o per singolo cliente.</p>
                <a href="${pageContext.request.contextPath}/admin/ordini" class="btn-admin-action">Vedi Ordini Totali</a>
            </div>

            <div class="admin-card">
                <h3 class="admin-card-title">📐 Preventivi Su Misura</h3>
                <p class="admin-card-text">Controlla le richieste di progetti personalizzati inviate dagli utenti commerciali o privati per mobili su misura.</p>
                <a href="${pageContext.request.contextPath}/admin/richieste" class="btn-admin-action">Gestisci Richieste</a>
            </div>

        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>