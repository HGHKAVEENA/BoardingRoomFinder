package servlet;

import dao.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;

import model.Room;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateRoom")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class UpdateRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO dao = new RoomDAO();

        try {

            Room room = dao.getRoomById(
                    Integer.parseInt(request.getParameter("roomId"))
            );

            room.setTitle(request.getParameter("title"));
            room.setDescription(request.getParameter("description"));
            room.setLocation(request.getParameter("location"));
            room.setPrice(
                    Double.parseDouble(request.getParameter("price"))
            );

            room.setRoomType(request.getParameter("roomType"));
            room.setGender(request.getParameter("gender"));
           Part imgPart = request.getPart("image");

if (imgPart != null && imgPart.getSize() > 0) {

    String fileName = System.currentTimeMillis()
            + "_"
            + new File(imgPart.getSubmittedFileName()).getName();

    String uploadPath = "C:\\BoardingFinderUploads";

    File uploadDir = new File(uploadPath);

    if (!uploadDir.exists()) {
        uploadDir.mkdirs();
    }

    imgPart.write(uploadPath + File.separator + fileName);

    room.setImage(fileName);
}

            dao.updateRoom(room);

            response.sendRedirect("owner-dashboard.jsp");

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}