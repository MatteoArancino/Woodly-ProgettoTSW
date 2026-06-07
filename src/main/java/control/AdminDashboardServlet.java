package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    	HttpSession session = request.getSession(false);
	
	    	if (session == null || session.getAttribute("sessionToken") == null || !"admin".equals(session.getAttribute("ruolo"))) {
	    	    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Accesso negato: Area riservata agli amministratori.");
	    	    return;
	    	}

        request.getRequestDispatcher("/WEB-INF/view/admin/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}