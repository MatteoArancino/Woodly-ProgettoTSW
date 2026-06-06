package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ProdottoDAO;
import model.Prodotto;

@WebServlet("/catalogo") // URL pulito visualizzato nel browser
public class CatalogoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProdottoDAO dao = new ProdottoDAO();
        
        // 1. Leggiamo il parametro della categoria dall'URL (es: /catalogo?categoria=tavoli)
        String categoria = request.getParameter("categoria");
        List<Prodotto> listaProdotti;
        
        // 2. Logica di filtraggio: se la categoria è nulla o vuota, prendiamo tutto il catalogo
        if (categoria != null && !categoria.trim().isEmpty()) {
            listaProdotti = dao.getProdottiPerCategoria(categoria); // Assicurati di avere questo metodo nel DAO
        } else {
            listaProdotti = dao.getAllProdotti();
            categoria = "tutti"; // Impostiamo un valore di default per gestire lo stato del bottone attivo
        }
        
        System.out.println("=== DEBUG WOODLY ===");
        System.out.println("Categoria richiesta: " + categoria);
        System.out.println("Numero prodotti recuperati dal DAO: " + (listaProdotti != null ? listaProdotti.size() : "NULL"));
        System.out.println("=====================");

        request.setAttribute("prodotti", listaProdotti);
        
        // 3. Salviamo la lista e la categoria corrente nella request (saranno lette dalla JSP)
        request.setAttribute("prodotti", listaProdotti);
        request.setAttribute("categoriaAttiva", categoria);
        
        // 4. Inoltriamo internamente alla vista protetta in WEB-INF
        request.getRequestDispatcher("/WEB-INF/view/catalogo.jsp").forward(request, response);
    }
}