package control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.RichiestaSuMisuraDAO;
import model.RichiestaSuMisura;

@WebServlet("/admin/richieste")
public class GestioneRichiesteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        RichiestaSuMisuraDAO richiestaDAO = new RichiestaSuMisuraDAO();

        List<RichiestaSuMisura> listaRichieste = richiestaDAO.recuperaTutte();
       
        request.setAttribute("richieste", listaRichieste);

        request.getRequestDispatcher("/WEB-INF/view/admin/gestioneRichieste.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}