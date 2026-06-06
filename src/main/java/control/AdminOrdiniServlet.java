package control;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.OrdineDAO;
import model.Ordine;

@WebServlet("/admin/ordini")
public class AdminOrdiniServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"admin".equals(session.getAttribute("ruolo"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String dataInizio = request.getParameter("dataInizio");
        String dataFine = request.getParameter("dataFine");
        String idCliente = request.getParameter("idCliente");

        OrdineDAO dao = new OrdineDAO();
        List<Ordine> tuttiGliOrdini = dao.getOrdiniPerAdminFiltri(dataInizio, dataFine, idCliente);

        request.setAttribute("ordini", tuttiGliOrdini);
        request.getRequestDispatcher("/WEB-INF/view/admin/monitoraggioOrdini.jsp").forward(request, response);
    }
}