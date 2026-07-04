# Stamps Coding Test Solutions

Repository ini berisi solusi untuk tes pemrograman dari Stamps yang diimplementasikan menggunakan bahasa pemrograman Ruby.

## Prasyarat (Requirements)
*   **Ruby:** Versi `3.4.1` (bisa menggunakan `rbenv` atau `rvm` untuk mengelola versi Ruby).
*   **API Key OpenWeatherMap:** Diperlukan untuk menjalankan skrip prakiraan cuaca (Task 2). Kunci API dapat diperoleh secara gratis dengan mendaftar di [openweathermap.org](https://openweathermap.org).

---

## Task 1: Number Filtering Script (`foobar.rb`)

### Deskripsi
Skrip ini menghasilkan deret angka dari 1 sampai 100 dengan aturan sebagai berikut:
1.  Mengabaikan (tidak menampilkan) angka prima.
2.  Mengganti kelipatan 3 dengan kata `"Foo"`.
3.  Mengganti kelipatan 5 dengan kata `"Bar"`.
4.  Mengganti kelipatan 3 dan 5 sekaligus dengan kata `"FooBar"`.
5.  Mencetak deret angka tersebut secara horizontal dalam urutan terbalik (*reverse order*), dipisahkan dengan koma.

### Cara Menjalankan
```bash
ruby foobar.rb
```

### Hasil Eksekusi (Test Results)
```text
Bar, Foo, 98, Foo, Bar, 94, Foo, 92, 91, FooBar, 88, Foo, 86, Bar, Foo, 82, Foo, Bar, Foo, 77, 76, FooBar, 74, Foo, Bar, Foo, 68, Foo, Bar, 64, Foo, 62, FooBar, 58, Foo, 56, Bar, Foo, 52, Foo, Bar, 49, Foo, 46, FooBar, 44, Foo, Bar, Foo, 38, Foo, Bar, 34, Foo, 32, FooBar, 28, Foo, 26, Bar, Foo, 22, Foo, Bar, Foo, 16, FooBar, 14, Foo, Bar, Foo, 8, Foo, 4, 1
```

---

## Task 2: Weather Forecast Script (`weather.rb`)

### Deskripsi
Skrip ini menampilkan prakiraan cuaca kota Jakarta untuk 5 hari ke depan menggunakan OpenWeatherMap API dengan aturan sebagai berikut:
1.  Menggunakan endpoint API gratis (`api.openweathermap.org/data/2.5/forecast`).
2.  Menyaring data agar hanya menampilkan **satu suhu** representatif per hari (menggunakan data cuaca terdekat dari waktu tengah hari / 12:00 PM waktu setempat).
3.  Menerjemahkan waktu UTC dari API menjadi waktu lokal Jakarta (menggunakan data offset zona waktu dari API).
4.  Format keluaran menggunakan bahasa Inggris untuk nama hari dan bulan dengan format `Day, DD Mon YYYY: XX.XX°C`.
5.  Kunci API tidak disimpan secara langsung dalam kode sumber untuk keamanan.

### Cara Menjalankan
Set variabel lingkungan `OPENWEATHERMAP_API_KEY` terlebih dahulu saat menjalankan skrip:
```bash
OPENWEATHERMAP_API_KEY="kunci_api_anda" ruby weather.rb
```

*Catatan: Jika dijalankan di terminal interaktif tanpa mendefinisikan variabel lingkungan tersebut, skrip akan meminta input kunci API secara interaktif.*

### Hasil Eksekusi (Test Results)
```text
Weather Forecast:
Sun, 05 Jul 2026: 36.71°C
Mon, 06 Jul 2026: 36.15°C
Tue, 07 Jul 2026: 32.25°C
Wed, 08 Jul 2026: 32.09°C
Thu, 09 Jul 2026: 32.38°C
```
