# 📡 Advanced Network Stats Monitor (ANSM)

![OS](https://img.shields.io/badge/OS-Windows_10%20%7C%2011-blue?style=flat-square&logo=windows)
![Language](https://img.shields.io/badge/Language-Batch_Script-orange?style=flat-square&logo=gnubash)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Maintained](https://img.shields.io/badge/Maintained%3F-Yes-success?style=flat-square)

**Advanced Network Stats Monitor (ANSM)** adalah utilitas berbasis antarmuka baris perintah (_Command-Line Interface_ / CLI) yang ringan dan efisien. Dirancang khusus untuk lingkungan Windows, skrip ini mengumpulkan telemetri jaringan lokal, metrik latensi, dan _throughput_ data transmisi ke dalam satu dasbor _real-time_.

<img width="444" height="485" alt="Screenshot 2026-03-30 174530" src="https://github.com/user-attachments/assets/b5635739-121a-4b82-8e8f-908722f90efa" />

---

## 📑 Daftar Isi

- [Fitur Utama](#-fitur-utama)
- [Prasyarat Sistem](#-prasyarat-sistem)
- [Instalasi & Penggunaan](#-instalasi--penggunaan)
- [Di Balik Layar (How it Works)](#-di-balik-layar-how-it-works)
- [Troubleshooting & FAQ](#-troubleshooting--faq)
- [Kontribusi](#-kontribusi)

---

## ✨ Fitur Utama

- **Automated Privilege Escalation:** Skrip dilengkapi dengan rutin pendeteksi hak akses (`net session`). Jika tidak dieksekusi sebagai Admin, program akan menggunakan panggilan PowerShell (`Start-Process -Verb RunAs`) untuk secara otomatis memicu _User Account Control_ (UAC).
- **Zero-Flicker Rendering:** Memanfaatkan teknik _delayed screen clearing_ di mana buffer layar hanya dibersihkan sesaat sebelum variabel lingkungan baru dirender, menghasilkan pembaruan antarmuka (UI) yang mulus tanpa efek layar berkedip.
- **Dynamic IP Resolution:** Melakukan ping ke layanan DNS eksternal untuk melakukan _resolve_ IP Publik pengguna saat ini menggunakan batas waktu eksekusi (`--max-time`) untuk mencegah _thread hang_.
- **Comprehensive Packet Analytics:** Menghitung tingkat _Packet Loss_ dan _Latency_ rata-rata berdasarkan ICMP echo requests.

---

## ⚙️ Prasyarat Sistem

Sebelum menjalankan utilitas ini, pastikan sistem Anda memenuhi persyaratan berikut:

1. **Sistem Operasi:** Windows 10 atau Windows 11.
2. **Konektivitas:** Adapter _Wireless LAN_ (Wi-Fi) aktif (Fitur deteksi SSID tidak mendukung antarmuka Ethernet/LAN).
3. **Privasi Sistem:** Layanan Lokasi (Location Services) **wajib diaktifkan** agar Windows Shell Command mengizinkan pembacaan parameter SSID.

---

## 📥 Cara Download / Install

Program ini tidak memerlukan proses instalasi yang rumit atau aplikasi tambahan. Anda hanya perlu mengunduh file utamanya:

**Cara 1: Download Langsung (Paling Mudah)**

1. Scroll ke bagian atas halaman GitHub ini.
2. Cari dan klik tombol hijau bertuliskan **`<> Code`**.
3. Pilih menu **`Download ZIP`**.
4. Setelah terunduh, klik kanan pada file ZIP tersebut dan pilih **`Extract All...`** (Ekstrak Semua).
5. Buka folder hasil ekstrak, Anda akan menemukan file program bernama `network.bat`.

**Cara 2: Menggunakan Git Clone (Untuk Developer)**
Buka Terminal atau Command Prompt, lalu ketikkan perintah ini:

```bash
git clone [https://github.com/HafistAfrizal/Network-stats.git](https://github.com/HafistAfrizal/Network-stats.git)
```
