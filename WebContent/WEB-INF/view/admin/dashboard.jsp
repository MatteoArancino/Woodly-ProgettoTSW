<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Pannello Admin</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css">
</head>
<body style="background: #f4f5f7;">

    <jsp:include page="/WEB-INF/view/header.jsp" />

    <main style="max-width: 1000px; margin: 40px auto; padding: 0 20px;">
        <h1 style="font-family: 'Playfair Display', serif; border-bottom: 2px solid #333; padding-bottom: 10px;">Pannello di Controllo Amministratore</h1>
        <p style="color: #666;">Benvenuto nel back-office di Woodly. Scegli una delle sezioni per gestire l'e-commerce:</p>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 20px; margin-top: 30px;">
            
            <div style="background: white; border: 1px solid #ddd; border-radius: 8px; padding: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                <h3 style="margin-top: 0; color: #333;">📦 Gestione Catalogo</h3>
                <p style="color: #777; font-size: 14px; min-height: 60px;">Inserisci nuovi elementi d'arredo, modifica i dettagli dei mobili esistenti o cancella articoli fuori produzione.</p>
                <a href="${pageContext.request.contextPath}/admin/catalogo" style="display: inline-block; background: #333; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: 600; font-size: 14px;">Gestisci Prodotti</a>
            </div>

            <div style="background: white; border: 1px solid #ddd; border-radius: 8px; padding: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                <h3 style="margin-top: 0; color: #333;">📜 Monitoraggio Ordini</h3>
                <p style="color: #777; font-size: 14px; min-height: 60px;">Visualizza l'elenco globale delle vendite effettuate. Filtra per intervallo di date o per singolo cliente.</p>
                <a href="${pageContext.request.contextPath}/admin/ordini" style="display: inline-block; background: #333; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: 600; font-size: 14px;">Vedi Ordini Totali</a>
            </div>

            <div style="background: white; border: 1px solid #ddd; border-radius: 8px; padding: 25px; box-shadow: 0 2px 4px rgba(0,0,0,0.05);">
                <h3 style="margin-top: 0; color: #333;">📐 Preventivi Su Misura</h3>
                <p style="color: #777; font-size: 14px; min-height: 60px;">Controlla le richieste di progetti personalizzati inviate dagli utenti commerciali o privati per mobili su misura.</p>
                <a href="${pageContext.request.contextPath}/admin/richieste" style="display: inline-block; background: #333; color: white; padding: 10px 15px; text-decoration: none; border-radius: 4px; font-weight: 600; font-size: 14px;">Gestisci Richieste</a>
            </div>

        </div>
    </main>

    <jsp:include page="/WEB-INF/view/footer.jsp" />

</body>
</html>