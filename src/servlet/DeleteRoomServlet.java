package servlet;

import dao.RoomDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/deleteRoom")
public class DeleteRoomServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int roomId = Integer.parseInt(request.getParameter("id"));

        RoomDAO dao = new RoomDAO();

        try {
            dao.deleteRoom(roomId);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("owner-dashboard.jsp");
    }
}