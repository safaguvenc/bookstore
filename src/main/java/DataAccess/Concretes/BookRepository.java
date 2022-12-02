package DataAccess.Concretes;

import DataAccess.Abstractions.IBookRepository;
import DataAccess.Entities.Book;
import java.sql.*;
import java.util.ArrayList;

public class BookRepository extends Repository implements IBookRepository{
    
    public ArrayList<Book> books;
    public Book book;
    Statement st;
    ResultSet rs;
    PreparedStatement pst;
    int ID;
    String authors = "";
    String translators = "";
    String categories = "";

    @Override
    public ArrayList<Book> getList() {
        String query = "SELECT B.ID,B.Name,B.Stock,B.Enable,P.Name as Publisher,B.PublishDate,B.PageNumber,B.PrintCount,B.ImageUrl FROM Book B " +
                        "inner join Publisher P on B.PublisherID = P.ID";
        books = new ArrayList<Book>();

        try {
            st = con.createStatement();
            rs = st.executeQuery(query);
            
            while (rs.next()) {
                book = new Book();
                ID = rs.getInt("ID");
                book.setID(rs.getInt("ID"));
                book.setName(rs.getString("Name"));
                book.setPageNumber(rs.getString("PageNumber"));
                book.setEnable(rs.getBoolean("Enable"));
                book.setPrintCount(rs.getString("PrintCount"));
                book.setStock(rs.getInt("Stock"));
                book.setPublishDate(rs.getDate("PublishDate"));
                book.setPublisherName(rs.getString("Publisher"));
                book.setImageUrl(rs.getString("ImageUrl"));
                
                String query2 = "SELECT CONCAT(A.FirstName,\" \",A.LastName) As AuthorName FROM Book B " +
                        "inner join BookAuthor BA on B.ID = BA.BookID " +
                        "inner join Author A on A.ID = BA.AuthorID " +
                        "where B.ID = '"+ ID +"'";
                Statement st2 = con.createStatement();
                ResultSet rs2 = st2.executeQuery(query2);
                while (rs2.next()){
                    authors += rs2.getString("AuthorName") + " / ";
                }
                book.setAuthors(authors);
                authors = "";
                
                String query3 = "SELECT CONCAT(T.FirstName,\" \",T.LastName) As TranslatorName FROM Book B " +
                                "inner join BookTranslator BT on B.ID = BT.BookID " +
                                "inner join Translator T on T.ID = BT.TranslatorID " +
                                "where B.ID = '"+ ID +"'";         
                Statement st3 = con.createStatement();
                ResultSet rs3 = st3.executeQuery(query3);
                while (rs3.next()){
                    translators += rs3.getString("TranslatorName") + " / ";
                }
                book.setTranslators(translators);
                translators = "";
                
                String query4 = "SELECT C.Name As CategoryName FROM Book B " +
                                "inner join BookCategory BC on B.ID = BC.BookID " +
                                "inner join Category C on C.ID = BC.CategoryID " +
                                "where B.ID = '"+ ID +"'";
                Statement st4 = con.createStatement();
                ResultSet rs4 = st4.executeQuery(query4);
                while (rs4.next()){
                    categories += rs4.getString("CategoryName") + " / ";
                }
                book.setCategories(categories);
                categories = "";
                
                books.add(book);   
            }
            return books;

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        return null;
    }

    @Override
    public void Add(Book entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void Update(Book entity) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void Delete(int ID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Book getById(int ID) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}