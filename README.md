# rova-kernel-ci

CI untuk membangun kernel crDroid `rova` (Redmi 4A/5A, msm8937, Linux 4.19)
dengan BakaSU (root) dan opsi kernel Droidspaces.

Repo ini tidak berisi kode kernel. Workflow mengambil kernel dari repo lain
(upstream atau fork kamu), menerapkan patch, lalu membangun zip AnyKernel3.

## Pakai
1. Tab **Actions** -> pilih *Build kernel* -> **Run workflow**.
2. Isi `kernel_repo` (default: upstream crDroid) dan `kernel_branch` (`15.0`).
3. Unduh artifact `rova-kernel-zip`, backup boot, lalu flash lewat recovery.

## Isi
- `patches/` : patch hook BakaSU dan patch cgroup Droidspaces
- `configs/` : fragment config (`bakasu.config`, `droidspaces.config`)
- `anykernel/anykernel.sh` : skrip pembuat zip flashable

Kernel fork privat: tambahkan secret `KERNEL_REPO_TOKEN` (PAT dengan akses baca).
