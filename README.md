# rova-kernel-ci

CI untuk membangun kernel crDroid `rova` (Redmi 4A/5A, msm8937, Linux 4.19)
dengan BakaSU (root), opsi kernel Droidspaces (termasuk macvlan dan IPv6 NAT),
dan backport kernel agar systemd 258-262 bisa jalan di dalam container.

Repo ini tidak berisi kode kernel. Workflow mengambil kernel dari repo lain
(upstream atau fork kamu), menerapkan patch, lalu membangun zip AnyKernel3.

## Pakai
1. Tab **Actions** -> pilih *Build kernel* -> **Run workflow**.
2. Isi `kernel_repo` (default: upstream crDroid) dan `kernel_branch` (`15.0`).
3. `systemd_backports` dibiarkan tercentang. Hilangkan centangnya kalau build
   gagal dan kamu ingin memisahkan penyebabnya.
4. Unduh artifact `rova-kernel-zip`, backup boot, lalu flash lewat recovery.

## Isi
- `patches/` : patch hook BakaSU dan patch cgroup Droidspaces (selalu dipakai)
- `patches/systemd/` : backport kernel untuk systemd 258-262 (opsional, lihat di bawah)
- `configs/droidspaces.config` : opsi Droidspaces, macvlan, IPv6 / NAT66
- `configs/systemd.config` : opsi tambahan untuk systemd modern
- `configs/bakasu.config` : mode hook manual BakaSU
- `anykernel/anykernel.sh` : skrip pembuat zip flashable

## Backport systemd
Diambil dari `droidspaces-backports` (seri 4.19). Delapan dari sepuluh patch dipakai:
- 0002 (`SO_BINDTOIFINDEX`) dilewati karena kernel ini sudah memilikinya.
- 0010 dilewati karena hanya untuk x86.

Patch yang sudah ada di kernel (misalnya setelah fork disinkronkan dengan upstream)
otomatis dilewati dan tidak membuat build gagal.

Syarat di sisi runtime: Droidspaces harus lebih baru dari 7.1.0 (perbaikan new mount API
ada di runtime, bukan kernel). Cek dengan `su -c "droidspaces check"`.
Alternatif tanpa menyentuh kernel: pasang systemd 257 di container.

## Verifikasi di perangkat
```
su -c "droidspaces check"
su -c "zcat /proc/config.gz | grep -E 'MACVLAN|IP6_NF_NAT|FHANDLE'"
```
Macvlan hanya berguna pada jaringan kabel (misalnya adaptor Ethernet USB OTG), bukan Wi-Fi.

Kernel fork privat: tambahkan secret `KERNEL_REPO_TOKEN` (PAT dengan akses baca).
