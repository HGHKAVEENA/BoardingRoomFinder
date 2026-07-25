# Boarding Room Finder & Reservation System

Full-stack Java web application for helping Sri Lankan university students find and reserve boarding rooms.

## Tech Stack
- **Frontend:** HTML5, CSS3, Bootstrap 5, JavaScript, Bootstrap Icons
- **Backend:** Java (JSP + Servlets, MVC architecture)
- **Database:** MySQL 8+
- **Server:** Apache Tomcat 9 or 10
- **JDBC:** `mysql-connector-j`

## Project Structure
```
BoardingRoomFinder/
├── nbproject/      (NetBeans project metadata — opens directly in NetBeans)
├── build.xml       (NetBeans Ant build file)
├── src/
│   ├── model/     (User, Student, Owner, Room, Booking, University)
│   ├── dao/       (DBConnection, UserDAO, RoomDAO, BookingDAO, UniversityDAO)
│   └── servlet/   (LoginServlet, RegisterServlet, SearchServlet, AddRoomServlet,
│                    BookingServlet, LogoutServlet)
├── web/
│   ├── *.jsp      (index, login, register, search, room-details,
│                    student-dashboard, owner-dashboard, add-room, booking)
│   ├── css/style.css
│   ├── js/script.js
│   └── WEB-INF/web.xml
├── database/boarding_system.sql
└── docs/          (ER, use case, class, sequence, activity diagrams + documentation)
```

## Setup

### 1. Database
```bash
mysql -u root -p < database/boarding_system.sql
```
This creates the `boarding_system` database, all tables, seeds the 13 Sri Lankan universities, and inserts sample owner/student accounts.

### 2. Configure JDBC
Open `src/dao/DBConnection.java` and set your MySQL user + password:
```java
private static final String USER     = "root";
private static final String PASSWORD = "yourpassword";
```

### 3. Deploy in NetBeans
1. **Open the project directly:** File → Open Project → select the extracted `BoardingRoomFinder` folder. NetBeans will recognize the `nbproject/` metadata.
2. In `nbproject/private/private.properties`, update `j2ee.server.home` and `j2ee.server.instance` to point to your Apache Tomcat installation.
3. Add **`mysql-connector-j-*.jar`** to `web/WEB-INF/lib` (create `lib` if it doesn't exist).
4. Right-click the project → **Run** — the app opens at `http://localhost:8080/BoardingRoomFinder/`.

### 3b. Deploy in Eclipse
1. File → Import → Existing Project into Workspace.
2. Add `mysql-connector-j-*.jar` to `WEB-INF/lib`.
3. Set the target server to **Apache Tomcat 9/10**.
4. Run.

### Sample Accounts
| Role    | Email             | Password |
|---------|-------------------|----------|
| Owner   | owner@test.com    | 1234     |
| Student | student@test.com  | 1234     |

## OOP Concepts Demonstrated
- **Encapsulation** — every model class uses private fields with getters/setters.
- **Inheritance** — `Student` and `Owner` extend the abstract `User` class.
- **Polymorphism** — `getDashboardPage()` and `getFullName()` overridden per role; `UserDAO.login()` returns the correct subclass.
- **Abstraction** — `User` is abstract and forces subclasses to implement dashboard routing.

## Features
**Student:** Register, login, search rooms, filter by university/price/gender, view details, book, view history, cancel, logout.
**Owner:** Register, login, add/edit/delete rooms, upload images, view booking requests, accept/reject, logout.

## Security Notes (production)
- Passwords are stored as plain text for coursework simplicity — hash with BCrypt in production.
- Use prepared statements everywhere (already done) to prevent SQL injection.
- Add CSRF tokens and HTTPS in production.

## Diagrams
See `docs/` folder for ER, Use Case, Class, Sequence, and Activity diagrams (Mermaid `.mmd` files, viewable at https://mermaid.live).
