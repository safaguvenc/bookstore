<%
    Cookie cookie;
    Cookie[] cookies;
    cookies = request.getCookies();
    if (cookies != null){
        for(int i = 0; i < cookies.length; i++) {
            cookie = cookies[i];
            if (cookie.getName().equals("email") || cookie.getName().equals("password")) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
    }

    //session.invalidate();
    session.removeAttribute("authorization");
    response.sendRedirect("login.jsp");
%>
