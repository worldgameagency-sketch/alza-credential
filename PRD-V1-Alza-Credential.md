# Product Requirements Document (PRD) V1
## Digital Credential & Ijazah Verification Platform

**Founder:** Alza Wahyudi  
**Status:** Independent Project  
**Target Market:** Sekolah swasta dan perguruan tinggi swasta di Indonesia  
**Market Entry:** Indonesia  
**Product Version:** V1 — MVP  
**Technology Concept:** Digital Credential + Cryptographic Verification + Blockchain Anchor

---

# 1. Product Vision

## 1.1 Visi

Membangun platform penerbitan dan verifikasi ijazah digital yang memungkinkan keaslian sebuah credential pendidikan diverifikasi secara online dengan cepat dan dapat dipercaya.

Platform dirancang untuk membantu institusi pendidikan menerbitkan credential digital yang memiliki:
- identitas unik;
- QR verification;
- cryptographic proof;
- status aktif atau dicabut;
- riwayat penerbitan;
- bukti integritas yang di-anchor ke blockchain.

Blockchain bukan produk utama yang dijual kepada institusi. Blockchain merupakan infrastructure layer yang digunakan untuk membantu membuktikan integritas data credential.

## 1.2 Masalah

Proses verifikasi ijazah secara tradisional dapat bergantung pada dokumen fisik, arsip institusi, dan komunikasi manual dengan pihak penerbit.

Platform ini bertujuan menyediakan mekanisme verifikasi digital sehingga pihak yang menerima credential dapat memeriksa informasi credential melalui satu halaman verifikasi.

## 1.3 Solusi

Institusi menggunakan dashboard platform untuk:
1. memasukkan data lulusan;
2. menerbitkan credential;
3. menghasilkan QR Code;
4. menghasilkan cryptographic proof;
5. mencatat proof pada blockchain;
6. menyediakan halaman verifikasi publik.

Verifier cukup membuka atau memindai QR Code untuk melihat status credential.

## 1.4 Prinsip Produk

1. Institution-first
2. Verification-first
3. Privacy-by-design
4. Security-by-design
5. Blockchain sebagai infrastructure, bukan gimmick
6. Simple user experience
7. API-ready architecture
8. Tidak membuat blockchain sendiri

---

# 2. User Roles

## 2.1 Institution Admin

Pengguna resmi dari sekolah atau kampus.

Kemampuan:
- login;
- mengelola profil institusi;
- memasukkan data lulusan;
- menerbitkan credential;
- melihat credential yang diterbitkan;
- mengunduh credential;
- melakukan revocation;
- melihat riwayat aktivitas.

## 2.2 Graduate

Pemilik credential.

Kemampuan:
- melihat credential;
- mengakses halaman credential;
- mendapatkan QR Code;
- membagikan verification link;
- mengunduh dokumen digital apabila institusi mengizinkannya.

Graduate tidak mempunyai kewenangan menerbitkan atau mengubah credential.

## 2.3 Verifier

Pihak eksternal seperti perusahaan, HR, lembaga pendidikan, atau pihak lain yang ingin memeriksa credential.

Tidak wajib memiliki akun.

Kemampuan:
- scan QR;
- membuka verification URL;
- melihat informasi publik credential;
- melihat status credential;
- memeriksa cryptographic verification status.

## 2.4 Platform Super Admin

Pengelola platform.

Kemampuan:
- mendaftarkan institusi;
- memverifikasi identitas institusi;
- mengelola akun institution admin;
- melihat system logs;
- menangani abuse;
- mengelola konfigurasi platform.

Super Admin tidak boleh sembarangan mengubah data credential yang telah diterbitkan.

---

# 3. User Journeys

## 3.1 Institution Onboarding

Institusi tertarik  
→ Registrasi / kontak platform  
→ Institution verification  
→ Account dibuat  
→ Institution Admin menerima akses  
→ Dashboard aktif

Pada V1, proses verifikasi institusi dapat dilakukan secara manual oleh Super Admin.

## 3.2 Issuing Credential

Admin Login  
→ Dashboard  
→ Create Credential  
→ Input Data  
→ Review  
→ Confirm  
→ Generate Credential ID  
→ Generate Canonical Data  
→ Generate Hash  
→ Blockchain Anchor  
→ Generate QR  
→ Credential ACTIVE

## 3.3 Graduate

Credential diterbitkan  
→ Graduate menerima link  
→ Graduate membuka credential  
→ Melihat credential  
→ Membagikan QR / URL

## 3.4 Verification

Verifier  
→ Scan QR  
→ Verification URL  
→ Platform mencari Credential ID  
→ Credential ditemukan?  
→ Hash / proof diperiksa  
→ Status diperiksa  
→ VALID / REVOKED / NOT FOUND

## 3.5 Revocation

Institution Admin  
→ Pilih Credential  
→ Revoke  
→ Masukkan alasan  
→ Confirm  
→ Status = REVOKED  
→ Verification page diperbarui

Record penerbitan tidak dihapus.

---

# 4. Feature List

## 4.1 MVP — Wajib

### Authentication
- Institution Admin login
- Super Admin login
- password hashing
- session management
- role-based access control

### Institution Management
- institution profile
- institution verification status
- institution admin management

### Credential Issuance
- create credential
- credential ID generation
- data validation
- credential status
- issuance timestamp
- QR generation

### Verification
- public verification page
- credential lookup
- status display
- cryptographic proof verification
- institution information

### Revocation
- revoke credential
- revocation reason
- revocation timestamp
- public revoked status

### Blockchain
- hash generation
- blockchain anchor
- transaction reference
- blockchain verification status

### Audit
- issuance log
- revocation log
- administrative activity log

## 4.2 Tidak Masuk MVP

Fitur berikut ditunda:
- mobile application;
- AI fraud detection;
- facial recognition;
- national identity integration;
- automatic integration dengan seluruh SIAKAD;
- token/cryptocurrency;
- NFT marketplace;
- custom blockchain;
- international credential interoperability;
- payment gateway kompleks;
- multi-country support.

MVP harus membuktikan satu hal terlebih dahulu:

> Institusi dapat menerbitkan credential dan pihak ketiga dapat memverifikasinya.

---

# 5. Database Schema

Database awal menggunakan PostgreSQL.

## 5.1 Institutions

```text
institutions
- id
- legal_name
- display_name
- institution_type
- address
- website
- verification_status
- created_at
- updated_at
```

## 5.2 Users

```text
users
- id
- institution_id
- email
- password_hash
- role
- status
- created_at
- updated_at
```

## 5.3 Credentials

```text
credentials
- id
- institution_id
- credential_id
- student_name
- student_number
- program_name
- degree_name
- graduation_date
- credential_number
- issue_date
- document_hash
- blockchain_network
- blockchain_tx_hash
- status
- created_at
- updated_at
```

## 5.4 Revocations

```text
revocations
- id
- credential_id
- reason
- revoked_by
- revoked_at
```

## 5.5 Audit Logs

```text
audit_logs
- id
- actor_id
- action
- target_type
- target_id
- metadata
- created_at
```

---

# 6. Verification Logic

Verification harus memiliki beberapa lapisan.

## Layer 1 — Credential Existence

Apakah Credential ID terdaftar?

FOUND atau NOT FOUND.

## Layer 2 — Issuer

Apakah credential diterbitkan oleh institusi yang telah diverifikasi platform?

VERIFIED ISSUER atau UNVERIFIED ISSUER.

## Layer 3 — Status

ACTIVE atau REVOKED.

## Layer 4 — Cryptographic Integrity

Data credential menghasilkan hash tertentu. Sistem membandingkan hash dengan proof yang tercatat.

MATCH atau NOT MATCH.

## Layer 5 — Blockchain Anchor

Sistem memeriksa transaction/reference yang menjadi anchor.

Hasil akhir dapat berupa:
- VERIFIED
- REVOKED
- NOT FOUND
- PROOF MISMATCH

---

# 7. Revocation Logic

Credential tidak boleh dihapus begitu saja.

Contoh:

```text
Credential:
CRD-2027-000001

Original Status:
ACTIVE

↓
Institution melakukan revocation

↓

Current Status:
REVOKED
```

Verification page menampilkan:

```text
CREDENTIAL REVOKED

Issued by:
Universitas XYZ

Issued:
12 July 2027

Revoked:
18 August 2030

Reason:
[reason sesuai kebijakan institusi]
```

Alasan revocation perlu memiliki kebijakan privasi yang jelas. Tidak semua informasi internal institusi harus ditampilkan kepada publik.

---

# 8. Blockchain Architecture

## 8.1 Prinsip

Blockchain tidak menyimpan seluruh ijazah.

Jangan memasukkan data pribadi atau dokumen penuh ke blockchain publik, termasuk:
- NIK;
- alamat;
- nomor telepon;
- email pribadi;
- dokumen PDF;
- data sensitif mahasiswa.

## 8.2 Data yang dapat di-anchor

Minimal:

```text
Credential ID
Credential Hash
Issuer Identifier
Timestamp
```

## 8.3 Flow

```text
Credential Data
      ↓
Canonicalization
      ↓
Cryptographic Hash
      ↓
Blockchain Anchor
      ↓
Transaction Hash
      ↓
Database
```

Database menyimpan reference terhadap transaksi blockchain.

## 8.4 Batch Anchoring

Untuk versi komersial, sistem sebaiknya tidak melakukan satu transaksi blockchain untuk setiap credential jika biaya menjadi masalah.

Arsitektur dapat dikembangkan menjadi:

```text
Credential A ─┐
Credential B ─┤
Credential C ─┤
Credential D ─┤
              ↓
        Batch / Merkle Structure
              ↓
          Blockchain
```

Fitur batch dapat menjadi bagian pengembangan setelah MVP.

## 8.5 Blockchain Selection

Blockchain final belum dikunci pada PRD V1.

Kriteria:
- biaya transaksi rendah;
- stabil;
- ecosystem matang;
- tooling developer baik;
- dapat diverifikasi publik;
- mendukung smart contract jika diperlukan;
- memiliki reputasi dan keberlangsungan yang memadai.

Pemilihan chain dilakukan sebelum development blockchain production.

---

# 9. Security Requirements

Security menjadi bagian inti karena produk menangani credential pendidikan.

## 9.1 Authentication

Password tidak boleh disimpan plaintext.

Gunakan mekanisme authentication yang telah teruji.

## 9.2 Authorization

Institution A tidak boleh membaca atau mengubah credential Institution B.

Setiap request harus diperiksa berdasarkan institution ownership.

## 9.3 Role-Based Access Control

```text
Super Admin
    ↓
Institution Management

Institution Admin
    ↓
Credential Management

Verifier
    ↓
Public Verification Only
```

## 9.4 Audit Log

Aktivitas penting dicatat:
- LOGIN
- CREATE_CREDENTIAL
- ISSUE_CREDENTIAL
- REVOKE_CREDENTIAL
- UPDATE_INSTITUTION

## 9.5 Immutable Record Principle

Credential yang telah diterbitkan tidak boleh diedit secara sembarangan.

Jika terdapat kesalahan serius:

```text
Old Credential
       ↓
REVOKED

New Credential
       ↓
ISSUED
```

## 9.6 Privacy

Halaman publik hanya menampilkan data yang memang diperlukan untuk verifikasi credential.

V1 harus menggunakan prinsip data minimization.

---

# 10. UI Pages

## Public

### `/`
Landing page.

### `/verify/[credentialId]`
Halaman verifikasi publik.

Menampilkan:
- Credential Status
- Institution
- Graduate Name
- Program
- Degree
- Graduation Date
- Issue Date
- Proof Status

## Institution

### `/institution/login`
Login.

### `/institution/dashboard`
Overview.

### `/institution/credentials`
Daftar credential.

### `/institution/credentials/create`
Create credential.

### `/institution/credentials/[id]`
Detail credential.

### `/institution/credentials/[id]/revoke`
Revocation.

### `/institution/settings`
Institution profile.

## Super Admin

### `/admin`
Dashboard.

### `/admin/institutions`
Institution management.

### `/admin/institutions/[id]`
Institution verification.

### `/admin/audit`
Audit logs.

---

# 11. API Endpoints

## Authentication

```text
POST /api/auth/login
POST /api/auth/logout
```

## Institutions

```text
GET   /api/institutions/me
PATCH /api/institutions/me
```

## Credentials

```text
POST /api/credentials
GET  /api/credentials
GET  /api/credentials/:id
```

## Revocation

```text
POST /api/credentials/:id/revoke
```

## Verification

```text
GET /api/verify/:credentialId
```

## Blockchain

Internal service:

```text
POST /api/blockchain/anchor
GET  /api/blockchain/:txHash
```

Endpoint blockchain harus memiliki authorization dan tidak boleh dapat dipanggil sembarang pengguna publik.

---

# 12. MVP Acceptance Criteria

MVP dianggap berhasil apabila skenario berikut dapat dilakukan end-to-end.

## Test 1 — Institution
Admin dapat login.

PASS.

## Test 2 — Create Credential
Admin dapat memasukkan data lulusan.

PASS.

## Test 3 — Issue
Sistem menghasilkan:
- Credential ID
- credential record
- hash
- QR
- verification URL

PASS.

## Test 4 — Blockchain
Proof credential berhasil di-anchor dan transaction/reference dapat ditemukan.

PASS.

## Test 5 — Public Verification
Orang tanpa akun dapat membuka QR.

PASS.

## Test 6 — Valid Credential
Verification page menunjukkan:

```text
ACTIVE
PROOF VERIFIED
```

PASS.

## Test 7 — Revocation
Admin mencabut credential.

PASS.

## Test 8 — Revoked Verification
QR yang sama ketika dibuka menunjukkan:

```text
REVOKED
```

PASS.

## Test 9 — Institution Isolation
Admin Institution A tidak dapat mengakses credential Institution B.

PASS.

## Test 10 — Tampering
Data credential yang dimodifikasi menghasilkan proof mismatch.

PASS.

---

# MVP Definition

Produk V1 selesai apabila:

> Satu institusi dapat menerbitkan credential digital, credential tersebut memiliki QR dan cryptographic proof, proof memiliki blockchain anchor, dan pihak eksternal dapat memverifikasi credential tanpa membuat akun.

Minimum product:

> **Issue → Prove → Verify.**

---

# Future Roadmap

## V1
Digital credential + verification.

## V2
Batch issuance.

## V3
Institution API.

## V4
SIAKAD integration.

## V5
Multiple credential types:
- ijazah;
- transkrip;
- sertifikat;
- sertifikasi kompetensi;
- micro-credential.

## V6
Credential wallet untuk lulusan.

## V7
National / institutional ecosystem partnerships.

---

# Product North Star

Produk ini bukan sekadar:

> "Ijazah pakai blockchain."

Melainkan:

> **A trusted digital credential infrastructure for education.**

Blockchain adalah salah satu teknologi yang membantu mewujudkan trust tersebut.
