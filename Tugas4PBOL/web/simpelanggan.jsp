<%@page import="java.sql.*"%>
<%@ include file="db/koneksi.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <title>Data Pelanggan</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
<div class="card">

<h2>Form Data Pelanggan</h2>

<form method="post">

<label>No Identitas:</label>
<input type="text" name="no_identitas" required>

<label>Nama:</label>
<input type="text" name="nama" required>

<label>Alamat:</label>
<textarea name="alamat" required></textarea>

<label>Jenis Kelamin:</label>
<select name="jenis_kelamin" required>
    <option value="">-- Pilih --</option>
    <option value="Laki-laki">Laki-laki</option>
    <option value="Perempuan">Perempuan</option>
</select>

<label>No HP:</label>
<input type="text" name="no_hp" required>

<label>Email:</label>
<input type="email" name="email" required>

<label>Tanggal Lahir:</label>
<input type="date" name="tanggal_lahir" required>

<button type="submit" name="simpan">Simpan</button>

</form>

</div>
</div>

</body>
</html>

<%
if(request.getParameter("simpan") != null){

    String no_identitas = request.getParameter("no_identitas");
    String nama = request.getParameter("nama");
    String alamat = request.getParameter("alamat");
    String jk = request.getParameter("jenis_kelamin");
    String no_hp = request.getParameter("no_hp");
    String email = request.getParameter("email");
    String tgl_lahir = request.getParameter("tanggal_lahir");

    // VALIDASI SEDERHANA
    if(no_identitas.equals("") || nama.equals("") || alamat.equals("")){
        out.println("<script>alert('Data tidak boleh kosong!')</script>");
    } else {

        try{
            String sql = "INSERT INTO pelanggan (no_identitas, nama, alamat, jenis_kelamin, no_hp, email, tanggal_lahir) VALUES (?, ?, ?, ?, ?, ?, ?)";
            
            PreparedStatement pst = koneksi.prepareStatement(sql);
            pst.setString(1, no_identitas);
            pst.setString(2, nama);
            pst.setString(3, alamat);
            pst.setString(4, jk);
            pst.setString(5, no_hp);
            pst.setString(6, email);
            pst.setString(7, tgl_lahir);

            int hasil = pst.executeUpdate();

            if(hasil > 0){
                out.println("<script>alert('Data berhasil disimpan!')</script>");
                out.println("<script>window.location='formOrder.jsp'</script>");
            } else {
                out.println("<script>alert('Gagal menyimpan data!')</script>");
            }

        } catch(Exception e){
            out.println("Error: " + e.getMessage());
        }
    }
}
%>