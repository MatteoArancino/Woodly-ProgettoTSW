<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Woodly - Accedi</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
	<jsp:include page="header.jsp" />
    
    <div class="form-container">
        <h2>Accedi a Woodly</h2>
        
        <% if("true".equals(request.getParameter("errore"))) { %>
            <p style="color: red; text-align: center; font-weight: bold; margin-bottom: 15px;">
                Email o Password errate. Riprova.
            </p>
        <% } %>

        <form action="LoginServlet" method="POST">
            <div class="form-group">
                <label for="email">Indirizzo Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <button type="submit" class="btn-hero" style="width: 100%; border: none; cursor: pointer; margin-top: 10px;">
                Accedi
            </button>
        </form>
        
        <p style="text-align: center; margin-top: 20px;">
            Non hai ancora un account? <a href="registrazione.jsp" class="btn-link">Registrati qui</a>
        </p>
    </div>

	<jsp:include page="footer.jsp" />
</body>
</html>