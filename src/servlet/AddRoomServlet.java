package servlet;

import dao.RoomDAO;
import model.Owner;
import model.Room;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


import java.io.File;
import java.io.IOException;

@WebServlet("/addRoom")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024) // 5 MB
public class AddRoomServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        System.out.println("HELLO FROM ADD ROOM SERVLET");

        HttpSession session = req.getSession(false);

        User user = (session == null)
                ? null
                : (User) session.getAttribute("user");

        if (!(user instanceof Owner)) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {

            Room r = new Room();

            r.setOwnerId(user.getId());
            r.setUniversityId(Integer.parseInt(req.getParameter("universityId")));

// Read form values
            String title = req.getParameter("title");
            String description = req.getParameter("description");
            String location = req.getParameter("location");
            String roomType = req.getParameter("roomType");
            String gender = req.getParameter("gender");
            double price = Double.parseDouble(req.getParameter("price"));

// ---------- VALIDATION ----------
// Title
            if (title == null || title.trim().isEmpty()) {
                req.setAttribute("error", "Room title is required.");
                req.getRequestDispatcher("add-room.jsp").forward(req, resp);
                return;
            }

// Description
            if (description == null || description.trim().length() < 10) {
                req.setAttribute("error", "Description must be at least 10 characters.");
                req.getRequestDispatcher("add-room.jsp").forward(req, resp);
                return;
            }

// Location
            if (location == null || location.trim().isEmpty()) {
                req.setAttribute("error", "Location is required.");
                req.getRequestDispatcher("add-room.jsp").forward(req, resp);
                return;
            }

// Price
            if (price <= 0) {
                req.setAttribute("error", "Price must be greater than zero.");
                req.getRequestDispatcher("/add-room.jsp").forward(req, resp);
                return;
            }

// ---------- SAVE DATA ----------
            r.setTitle(title);
            r.setDescription(description);
            r.setLocation(location);
            r.setRoomType(roomType);
            r.setCapacity(
                    Integer.parseInt(req.getParameter("capacity"))
            );
            r.setOccupied(0);
            r.setGender(gender);
            r.setPrice(price);

            r.setBathroom("on".equals(req.getParameter("bathroom")));

            r.setStatus("Available");
            // ---------- Image upload ----------
            Part imgPart = req.getPart("image");

            System.out.println("Image part: " + imgPart);

            if (imgPart != null) {

                System.out.println(
                        "File name: "
                        + imgPart.getSubmittedFileName()
                );

                System.out.println(
                        "File size: "
                        + imgPart.getSize()
                );
            }

            if (imgPart != null && imgPart.getSize() > 0) {

                String fileName
                        = System.currentTimeMillis()
                        + "_"
                        + new File(
                                imgPart.getSubmittedFileName()
                        ).getName();

                String uploadPath = "C:\\BoardingFinderUploads";

                System.out.println(
                        "Upload path: " + uploadPath
                );

                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imgPart.write(
                        uploadPath
                        + File.separator
                        + fileName
                );

                System.out.println(
                        "Saved image: " + fileName
                );

                r.setImage(fileName);
            }

            // ---------- Save room ----------
            int roomId = new RoomDAO().addRoom(r);

            if (roomId > 0) {
               resp.sendRedirect("owner-dashboard.jsp?msg=roomAdded");
            } else {
                resp.sendRedirect(
                        "add-room.jsp?error=true"
                );
            }

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
