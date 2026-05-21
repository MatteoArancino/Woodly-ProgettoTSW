<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Registrati</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

    <nav class="navbar">
        <div class="nav-logo">Woodly</div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="catalogo">Catalogo Mobili</a></li>
            <li><a href="#">Preventivo su Misura</a></li>
            <li><a href="registrazione.jsp" class="active">Accedi / Registrati</a></li>
        </ul>
    </nav>

    <div class="form-container">
        <h2>Crea il tuo Account Woodly</h2>
        
        <% if("true".equals(request.getParameter("errore"))) { %>
            <p style="color: red; text-align: center; font-weight: bold;">Errore durante la registrazione. Riprova.</p>
        <% } %>

        <form action="RegistrazioneServlet" method="POST">
            <div class="form-group">
                <label for="nome">Nome:</label>
                <input type="text" id="nome" name="nome" required>
            </div>
            
            <div class="form-group">
                <label for="cognome">Cognome:</label>
                <input type="text" id="cognome" name="cognome" required>
            </div>
            
            <div class="form-group">
                <label for="email">Indirizzo Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-hero" style="width: 100%; border: none; cursor: pointer; margin-top: 10px;">Registrati</button>
        </form>
        
        <p style="text-align: center; margin-top: 20px;">
            Hai già un account? <a href="login.jsp" class="btn-link">Accedi qui</a>
        </p>
    </div>

</body>
</html>