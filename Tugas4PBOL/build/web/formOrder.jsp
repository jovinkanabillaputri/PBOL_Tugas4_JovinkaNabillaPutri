<%@page import="java.sql.*"%>
<%@ include file="db/koneksi.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Form Order</title>
    <link rel="stylesheet" href="style.css">

<script>

    function setHarga(select){
    var harga = select.options[select.selectedIndex].getAttribute("data-harga");
    document.getElementById("harga").value = harga ? harga : "";
}
</script>

</head>
<body>

<div class="container">
<div class="card">

<h2>Form Order Produk</h2>

<form action="prosesOrder.jsp" method="post">

<label>Pelanggan:</label>
<select name="id_pelanggan" required>
    <option value="">-- Pilih Pelanggan --</option>
    <%
        Statement stPel = koneksi.createStatement();
        ResultSet rsPel = stPel.executeQuery("SELECT * FROM pelanggan");

        while(rsPel.next()){
    %>
        <option value="<%= rsPel.getInt("id_pelanggan") %>">
            <%= rsPel.getString("nama") %>
        </option>
    <%
        }
    %>
</select>

<label>Produk:</label>
<select name="noproduk" required onchange="setHarga(this)">
    <option value="">-- Pilih Produk --</option>
    <%
        Statement st = koneksi.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM produk");

        while(rs.next()){
    %>
        <option 
            value="<%= rs.getInt("noproduk") %>"
            data-harga="<%= rs.getInt("harga") %>">
            <%= rs.getString("nama_produk") %>
        </option>
    <%
        }
    %>
</select>

<label>Harga:</label>
<input type="number" id="harga" readonly>

<label>Jumlah:</label>
<input type="number" name="jumlah" min="1" required placeholder="Masukkan jumlah">

<label>Alamat Pengiriman:</label>
<textarea name="alamat" required placeholder="Masukkan alamat lengkap"></textarea>

<label>Jenis Pengiriman:</label>
<select name="pengiriman" required>
    <option value="">-- Pilih --</option>
    <option value="Reguler">Reguler</option>
    <option value="Express">Express</option>
</select>

<button type="submit">Pesan</button>

</form>

</div>
</div>

</body>
</html>