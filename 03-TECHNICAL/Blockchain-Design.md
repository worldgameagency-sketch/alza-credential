# Blockchain Design - Alza Credential V1

Dokumen ini menjelaskan rancangan integrasi blockchain untuk memastikan keaslian kredensial secara kriptografis.

## 1. Peran Blockchain
- **Tamper-evident Anchor**: Blockchain bertindak sebagai catatan waktu dan bukti integritas yang tidak dapat diubah (*immutable*).
- **Privacy First**: Data pribadi sensitif (seperti nama lengkap, nilai, atau dokumen mentah) **tidak** disimpan di blockchain. Hanya **SHA-256 Hash** dan ID referensi yang dicatat.

## 2. Data yang Dicatat (On-Chain Data)
Setiap transaksi *anchoring* akan mencakup:
- **Credential ID**: Pengenal unik kredensial.
- **Document Hash**: Sidik jari digital dari data ijazah.
- **Issuer Address**: Alamat wallet institusi pendidikan yang menerbitkan.
- **Timestamp**: Waktu pencatatan di blockchain.

## 3. Pemilihan Jaringan
- Menggunakan jaringan EVM-compatible yang cepat dan memiliki biaya transaksi (*gas fee*) rendah (contoh: Polygon / testnet untuk tahap pengembangan awal).
