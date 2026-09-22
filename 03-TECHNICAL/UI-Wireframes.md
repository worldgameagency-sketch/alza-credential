# UI/UX Wireframes & Pages - Alza Credential V1

Dokumen ini memetakan struktur halaman (*routes*) dan komponen antarmuka yang akan dibangun pada aplikasi Next.js.

## 1. Public Pages (Tanpa Login)
- **Landing Page (`/`)**
  - **Fungsi**: Halaman utama pengenalan platform untuk sekolah/institusi dan HR perusahaan.
  - **Komponen**: Hero section, Value Proposition, Tombol CTA ("Daftarkan Institusi" & "Cek Validasi Ijazah").
- **Public Verification Page (`/verify/{credential_id}`)**
  - **Fungsi**: Halaman publik untuk memvalidasi ijazah saat QR code dipindai oleh HR.
  - **Komponen**: 
    - Banner status utama: **VALID / ACTIVE** (warna hijau) atau **REVOKED / INVALID** (warna merah).
    - Detail data lulusan (Nama, Program Studi, Institusi, Tanggal Lulus).
    - Informasi bukti kriptografi (*Document Hash* & *Blockchain Transaction Hash*).

## 2. Authentication Pages
- **Login Page (`/auth/login`)**
  - **Fungsi**: Tempat masuk bagi Admin Institusi dan Super Admin.
  - **Komponen**: Form email, password, tombol submit, dan penanganan error.

## 3. Institution Admin Dashboard (Protected Route)
- **Dashboard Overview (`/admin/dashboard`)**
  - **Fungsi**: Ringkasan data (Total ijazah diterbitkan, status langganan, aktivitas terbaru).
- **Issuance Management (`/admin/credentials/new`)**
  - **Fungsi**: Form input data kelulusan baru untuk menerbitkan ijazah dan men-generate *hash* + QR Code.
- **Credentials List (`/admin/credentials`)**
  - **Fungsi**: Tabel daftar seluruh ijazah yang pernah diterbitkan oleh institusi tersebut beserta opsi untuk melihat detail atau mencabut (*revoke*) ijazah jika ada kesalahan.
