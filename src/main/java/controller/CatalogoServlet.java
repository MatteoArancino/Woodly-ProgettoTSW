package controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/catalogo")
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recuperiamo il parametro dall'URL
        String categoriaScelta = request.getParameter("categoria");
        
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodottiFiltrati = dao.getProdottiPerCategoria(categoriaScelta);
        
        // Passiamo i prodotti alla JSP
        request.setAttribute("prodotti", prodottiFiltrati);
        
        // Se la categoria è specificata, la passiamo convertita in minuscolo, altrimenti passiamo stringa vuota
        if (categoriaScelta != null && !categoriaScelta.trim().isEmpty()) {
            request.setAttribute("categoriaAttiva", categoriaScelta.trim().toLowerCase());
        } else {
            request.setAttribute("categoriaAttiva", ""); // Stringa vuota = nessun filtro, mostra tutto
        }
        
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}