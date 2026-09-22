# Technical Architecture - Alza Credential V1

Dokumen ini merinci arsitektur teknis untuk MVP Alza Credential.

## 1. High-Level Architecture
Sistem menggunakan pendekatan monolitik berbasis Next.js untuk mempercepat pengembangan MVP oleh independent founder dengan bantuan AI.

- **Frontend & Backend**: Next.js (Unified App)
- **Database**: PostgreSQL (via Supabase / Managed DB)
- **Authentication**: Role-based Access Control (Institution Admin, Super Admin, Verifier)
- **Storage**: Object Storage (untuk dokumen digital / aset pendukung)
- **Blockchain Layer**: EVM-Compatible Chain (untuk hashing & anchoring proof)

## 2. Core Data Flow

### A. Issuance Flow (Penerbitan Ijazah)
1. **Admin Login**: Admin sekolah masuk ke *Institution Dashboard*.
2. **Data Input**: Admin memasukkan data lulusan (Nama, NIM, Program, Tanggal Lulus, dll).
3. **Hashing**: Backend memproses data menjadi representasi kanonik dan menghasilkan **SHA-256 Hash**.
4. **Blockchain Anchor**: Hash dan ID kredensial dicatat (*anchor*) ke blockchain untuk memastikan integritas data.
5. **QR & Record**: Sistem menghasilkan QR Code dan menyimpan status aktif ke PostgreSQL.

### B. Verification Flow (Verifikasi Publik)
1. **Scan QR**: HR atau pihak ketiga memindai QR Code pada ijazah digital.
2. **Public Lookup**: Sistem membuka halaman verifikasi publik berdasarkan *Credential ID*.
3. **Integrity Check**: Sistem mencocokkan hash dokumen saat ini dengan *cryptographic proof* yang tercatat.
4. **Status Result**: Sistem menampilkan status akhir (**ACTIVE**, **REVOKED**, atau **PROOF MISMATCH**).

## 3. Security & Privacy Principles
- **Data Minimization**: Data pribadi sensitif (seperti NIK atau alamat lengkap) **tidak** disimpan di blockchain publik.
- **Isolation**: Admin dari institusi A tidak memiliki akses untuk membaca atau memodifikasi data milik institusi B.
- **Immutability**: Kredensial yang sudah diterbitkan tidak bisa diedit sembarangan; jika ada kesalahan, harus melalui mekanisme *Revocation* lalu menerbitkan ulang.
