<%-- 
    Document   : update-author
    Created on : 3 Ara 2022, 22:17:12
    Author     : Bahadır
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="DataAccess.Entities.*"%>
<%@page import="BusinessLayer.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<!-- header -->
<%@ include file="header.jsp" %>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <!-- Navbar -->
    <%@ include file="navbar.jsp" %>
  <!-- Sidebar -->
    <%@ include file="sidebar.jsp" %>
  <!-- Content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Şehir Menüsü</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="index.jsp">Ana Sayfa</a></li>
              <li class="breadcrumb-item active"><a href="cities.jsp">Şehirler</a></li>
              <li class="breadcrumb-item active">Şehir Güncelle</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <section class="content">
        
        
        <%
            int ID=Integer.parseInt(request.getParameter("ID"));
            
            AuthorService service=new AuthorService();
            Author author=new Author();
            
            author=service.getByID(ID);
            
        
        %>
        
        <form method="post" action="#">
            <div class="card">
                <div class="card-header">
                    <div class="card-tools">
                        <button type="button" class="btn btn-tool" data-card-widget="collapse" title="Collapse">
                          <i class="fas fa-minus"></i>
                        </button>
                        <button type="button" class="btn btn-tool" data-card-widget="remove" title="Remove">
                          <i class="fas fa-times"></i>
                        </button>
                  </div>
                </div>
                <div class="card-body">
                    <div class="form-group mb-2">
                        <label class="form-label">Yazar Adı:</label>
                        <input type="text" class="form-control" name="txtFirstName" value="<%=author.getFirstName()%>">
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group mb-2">
                        <label class="form-label">Yazar Soyadı:</label>
                        <input type="text" class="form-control" name="txtLastName" value="<%=author.getLastName()%>">
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group mb-2">
                        <label class="form-label">Yazar Doğum Tarihi:</label>
                        <input type="text" class="form-control" disabled name="txtLastName" value="<%=author.getBirthDate()%>">
                        <input type="date" class="form-control" name="txtBirthDate">
                    </div>
                </div>
                <div class="card-body">
                    <div class="form-group mb-2">
                        <label class="form-label">Yazar Biyografisi:</label>
                        <textarea class="form-control" name="txtBiography"><%=author.getBiography()%></textarea>
                    </div>
                </div>
                <div class="card-footer">
                    <div style="display:flex;justify-content: end;">
                        <button type="submit" name="save" class="btn btn-success"><i class="fas fa-check"></i> Kaydet</button>
                    </div>
                </div>
            </div>
        </form>
                    
                    
        <%
            if(request.getParameter("save")!=null){
                
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                
                java.util.Date BirthDate=sdf.parse(request.getParameter("txtBirthDate"));
                
                java.sql.Date sqlBirthDate = new java.sql.Date(BirthDate.getTime());
                
                author.setFirstName(request.getParameter("txtFirstName"));
                author.setLastName(request.getParameter("txtLastName"));
                author.setBiography(request.getParameter("txtBiography"));
                author.setBirthDate(sqlBirthDate);
                
                service.Update(author);
                
                response.sendRedirect("authors.jsp");
            }
        %>
                    
    </section>
    <!-- /.content -->
  
  
  
  </div>
  <!-- Footer -->
    <%@ include file="footer.jsp" %>
</div>
<!-- Scripts -->
<%@ include file="script.jsp" %>
</body>
</html>