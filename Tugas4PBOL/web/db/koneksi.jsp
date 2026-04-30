<%@page import="java.sql.*"%>

<%
Connection koneksi = null;

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/praktikum4";
    koneksi = DriverManager.getConnection(url,"root","");
} catch(Exception e){
    out.println("Koneksi gagal: " + e.getMessage());
}
%>