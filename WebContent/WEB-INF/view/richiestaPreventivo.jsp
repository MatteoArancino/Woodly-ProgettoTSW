<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Richiedi un Preventivo su Misura | Woodly</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/styles/style.css?v=7">
</head>
<body>

    <jsp:include page="/WEB-INF/view/header.jsp" />
	
    <div class="preventivo-container">
        <h2>🪚 Progetta la tua creazione su misura</h2>
        <p class="form-description">Condividi le tue idee e le dimensioni di cui hai bisogno. I nostri maestri ebanisti elaboreranno un disegno e un preventivo personalizzato per il tuo spazio.</p>

        <form action="${pageContext.request.contextPath}/invia-richiesta" method="POST">
            
            <div class="form-grid-top">
                <div class="form-group">
                    <label for="tipoMobile">Tipologia di Mobile</label>
                    <input type="text" id="tipoMobile" name="tipoMobile" class="form-control" placeholder="Es. Tavolo da pranzo, Libreria..." required>
                </div>

                <div class="form-group">
                    <label for="materiale">Essenza del Legno</label>
                    <select id="materiale" name="materiale" class="form-control" required>
                        <option value="">Scegli il legno...</option>
                        <option value="Rovere Massello">Rovere Massello (Robusto e venato)</option>
                        <option value="Noce Nazionale">Noce Nazionale (Scuro e pregiato)</option>
                        <option value="Pino Svedese">Pino Svedese (Chiaro e nodoso)</option>
                        <option value="MDF Laccato">MDF Laccato (Finitura Moderna)</option>
                        <option value="Altro">Altra essenza (Specifica nelle note)</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Dimensioni Richieste</label>
                <div class="misure-grid">
                    <div class="misure-input-wrapper">
                        <input type="number" name="larghezzaCm" class="form-control" placeholder="Larghezza" required min="1">
                    </div>
                    <div class="misure-input-wrapper">
                        <input type="number" name="altezzaCm" class="form-control" placeholder="Altezza" required min="1">
                    </div>
                    <div class="misure-input-wrapper">
                        <input type="number" name="profonditaCm" class="form-control" placeholder="Profondità" required min="1">
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="noteCliente">Note di Progettazione e Finiture</label>
                <textarea id="noteCliente" name="noteCliente" class="form-control" rows="5" placeholder="Descrivi qui particolari esigenze..."></textarea>
            </div>

            <button type="submit" class="btn-submit">Invia le specifiche al laboratorio</button>
        </form>
    </div>

    <jsp:include page="/WEB-INF/view/footer.jsp" />
    
</body>
</html>