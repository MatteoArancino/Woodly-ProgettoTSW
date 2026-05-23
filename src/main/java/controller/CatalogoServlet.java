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
        // Recuperiamo il parametro della categoria dall'URL (es: ?categoria=tavoli)
        String categoriaScelta = request.getParameter("categoria");
        
        // Se non è specificata, di default mostriamo "tutti"
        if (categoriaScelta == null || categoriaScelta.trim().isEmpty()) {
            categoriaScelta = "tutti";
        }
        
        // Interroghiamo il DB filtrando per la categoria richiesta
        ProdottoDAO dao = new ProdottoDAO();
        List<Prodotto> prodottiFiltrati = dao.getProdottiPerCategoria(categoriaScelta);
        
        // Salviamo la lista e la categoria attiva nella richiesta per la JSP
        request.setAttribute("prodotti", prodottiFiltrati);
        request.setAttribute("categoriaAttiva", categoriaScelta.toLowerCase());
        
        // Inoltriamo il controllo alla pagina grafica catalogo.jsp
        request.getRequestDispatcher("catalogo.jsp").forward(request, response);
    }
}