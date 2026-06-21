package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.RichiestaPreventivoDAO;
import model.RichiestaSuMisura; 

@WebServlet("/admin/dettaglio-richiesta")
public class DettaglioRichiestaAdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                
                RichiestaPreventivoDAO dao = new RichiestaPreventivoDAO();
                RichiestaSuMisura richiesta = dao.getRichiestaById(id);
                
                if (richiesta != null) {
                    request.setAttribute("richiesta", richiesta);
                    request.getRequestDispatcher("/WEB-INF/view/admin/DettaglioRichiesta.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/richieste?errore=RichiestaNonTrovata");
                }
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/richieste?errore=IdNonValido");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/richieste");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        String prezzoParam = request.getParameter("prezzo");
        
        if (idParam != null && prezzoParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                double prezzo = Double.parseDouble(prezzoParam.replace(",", "."));
                
                RichiestaPreventivoDAO dao = new RichiestaPreventivoDAO();
                boolean aggiornato = dao.aggiornaPreventivo(id, prezzo);
                
                if (aggiornato) {
                    response.sendRedirect(request.getContextPath() + "/admin/richieste?successo=PreventivoInviato");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dettaglio-richiesta?id=" + id + "&errore=AggiornamentoFallito");
                }
                
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/admin/dettaglio-richiesta?id=" + idParam + "&errore=PrezzoNonValido");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/richieste");
        }
    }
}