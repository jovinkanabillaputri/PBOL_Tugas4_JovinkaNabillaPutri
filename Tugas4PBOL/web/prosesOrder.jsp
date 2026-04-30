<%@page import="java.sql.*"%>
<%@ include file="db/koneksi.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Hasil Order</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
<div class="card">

<%
try {
    String idPelStr = request.getParameter("id_pelanggan");
    String noProdStr = request.getParameter("noproduk");
    String jumlahStr = request.getParameter("jumlah");
    String alamat = request.getParameter("alamat");
    String pengiriman = request.getParameter("pengiriman");

    if(idPelStr == null || noProdStr == null || jumlahStr == null ||
       idPelStr.equals("") || noProdStr.equals("") || jumlahStr.equals("") ||
       alamat == null || alamat.equals("") || pengiriman == null || pengiriman.equals("")) {

        out.println("<h3>Semua data wajib diisi!</h3>");
%>
        <br>
        <a href="simpelanggan.jsp"><button>Kembali</button></a>
<%
    } else {

        int id_pelanggan = Integer.parseInt(idPelStr);
        int noproduk = Integer.parseInt(noProdStr);
        int jumlah = Integer.parseInt(jumlahStr);

        if(jumlah <= 0){
            out.println("<h3>Jumlah tidak boleh nol atau minus!</h3>");
%>
            <br>
            <a href="simpelanggan.jsp"><button>Kembali</button></a>
<%
        } else {

            String namaPelanggan = "";
            String sqlPel = "SELECT * FROM pelanggan WHERE id_pelanggan=?";
            PreparedStatement pstPel = koneksi.prepareStatement(sqlPel);
            pstPel.setInt(1, id_pelanggan);
            ResultSet rsPel = pstPel.executeQuery();

            if(rsPel.next()){
                namaPelanggan = rsPel.getString("nama");
            }

            String namaProduk = "";
            int harga = 0;

            String sqlProduk = "SELECT * FROM produk WHERE noproduk=?";
            PreparedStatement pstProduk = koneksi.prepareStatement(sqlProduk);
            pstProduk.setInt(1, noproduk);
            ResultSet rs = pstProduk.executeQuery();

            if(rs.next()){
                namaProduk = rs.getString("nama_produk");
                harga = rs.getInt("harga");
            }

            int total = jumlah * harga;

            java.sql.Date tanggal = new java.sql.Date(new java.util.Date().getTime());

            String sql = "INSERT INTO pesanan (id_pelanggan, noproduk, jumlah, tanggal, alamat, pengiriman, total) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = koneksi.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pst.setInt(1, id_pelanggan);
            pst.setInt(2, noproduk);
            pst.setInt(3, jumlah);
            pst.setDate(4, tanggal);
            pst.setString(5, alamat);
            pst.setString(6, pengiriman);
            pst.setInt(7, total);

            pst.executeUpdate();

            ResultSet key = pst.getGeneratedKeys();
            int nopesanan = 0;
            if(key.next()){
                nopesanan = key.getInt(1);
            }
%>

<h2>Pesanan Berhasil</h2>

<p><b>No Pesanan:</b> <%= nopesanan %></p>
<p><b>Tanggal:</b> <%= tanggal %></p>
<p><b>Nama Pelanggan:</b> <%= namaPelanggan %></p>
<p><b>Produk:</b> <%= namaProduk %></p>
<p><b>Jumlah:</b> <%= jumlah %></p>
<p><b>Pengiriman:</b> <%= pengiriman %></p>
<p><b>Alamat:</b> <%= alamat %></p>
<p><b>Harga:</b> Rp <%= harga %></p>
<p><b>Total Bayar:</b> Rp <%= total %></p>

<br>
<a href="simpelanggan.jsp">
    <button>Kembali</button>
</a>

<%
        }
    }

} catch(NumberFormatException e){
%>
    <h3>Input angka tidak valid!</h3>
    <br>
    <a href="simpelanggan.jsp"><button>Kembali</button></a>
<%
} catch(Exception e){
%>
    <h3>Error:</h3>
    <p><%= e.getMessage() %></p>
<%
}
%>

</div>
</div>

</body>
</html>