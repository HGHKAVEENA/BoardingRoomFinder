package servlet;

import dao.RoomDAO;
import dao.UniversityDAO;
import model.Room;
import model.University;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer universityId = parseInt(req.getParameter("universityId"));
        Double  maxPrice     = parseDouble(req.getParameter("maxPrice"));
        String  gender       = req.getParameter("gender");
        try {
            List<Room> rooms = new RoomDAO().search(universityId, maxPrice, gender);
            List<University> unis = new UniversityDAO().getAll();
            req.setAttribute("rooms", rooms);
            req.setAttribute("universities", unis);
            req.getRequestDispatcher("search.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private Integer parseInt(String s) {
        try { return s == null || s.isEmpty() ? null : Integer.parseInt(s); }
        catch (NumberFormatException e) { return null; }
    }
    private Double parseDouble(String s) {
        try { return s == null || s.isEmpty() ? null : Double.parseDouble(s); }
        catch (NumberFormatException e) { return null; }
    }
}
