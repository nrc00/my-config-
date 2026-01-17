---

## 🚀 Your 5-Step Game Plan

### Step 1: Diagnose the NVMe
Run these in Arch Live USB:
1. `sudo smartctl -a /dev/nvme0n1` -> Check if "Critical Warning" is 0x00.
2. `lsblk -f` -> Check if "FSTYPE" is `bitlocker`.

### Step 2: Wipe/Decrypt (The Nuclear Option)
If encrypted or "stuck":
```bash
sudo nvme format /dev/nvme0n1 --ses=1
```

### Step 3: Install Windows 10
- Put it on the **NVMe** for speed (give it 150GB).
- Use the **1TB HDD** as your large storage (Games/Movies).

### Step 4: Debloat
Run the Chris Titus tool immediately after Windows setup.

### Step 5: Install Arch
In the remaining empty space on the NVMe.

---

## ❓ FAQ: Do I need TPM 2.0 or Secure Boot?
- **Short Answer**: No, not for Windows 10 or Arch.
- **Detailed Answer**: Windows 10 + Valorant does **not** strictly require TPM or Secure Boot. However, since your hardware supports it, **I recommend keeping them ON**. It makes Vanguard more stable and keeps the option open to upgrade to Windows 11 later without a headache.

---

## ⭐️ The "Simplicity First" Strategy
For your setup, we are recommending **Windows 10** over Windows 11 because:
1.  **Vanguard Simplicity**: No strict TPM/Secure Boot enforcement means fewer boot errors.
2.  **Less Bloat**: Naturally lighter than Windows 11.
3.  **Fits 4GB USB**: Easier to shrink down for your specific drive.

---

## ⚠️ The Golden Rule: Windows FIRST
Always install **Windows before Arch**.
- **The Reason**: Windows is "selfish." Its installer will often overwrite your boot settings. If you install Arch first, the Windows install might make Arch "disappear" from the boot menu.
- **The Plan**:
  1. Wipe NVMe.
  2. Install Windows 10.
  3. Shrink Windows inside its own "Disk Management" tool.
  4. Install Arch in the new empty space.

---

## 0. Creating a 4GB-Friendly Windows USB (from Arch Linux)
A standard Windows ISO is ~5.5GB. To fit it on your 4GB USB:
1.  **Install wimlib**: `sudo pacman -S wimlib`.
2.  **Mount your ISO**: `sudo mount -o loop Win10_English_x64.iso ~/win_iso`.
3.  **Export & Compress**:
    ```bash
    wimlib-imagex export ~/win_iso/sources/install.wim 6 ~/win_files/sources/install.esd --compress=solid
    ```
    *This creates a highly compressed `.esd` file that fits on 4GB.*

---

## 1. The "Clean Slate" - Unlocking your NVMe
**This is your current priority.** If the drive is from your aunt and encrypted, you must wipe it.
1.  **BIOS Check**: Disable **Intel VMD Technology** in Gigabyte BIOS.
2.  **Nuclear Format**: 
    ```bash
    sudo nvme format /dev/nvme0n1 --ses=1
    ```
*See [nvme_recovery.md](file:///home/kola/Documents/arch_win_dualboot/nvme_recovery.md) for full diagnostics.*

---

## 2. Windows 10 Setup (Valorant Ready)
1.  **BIOS Settings**: Enable **Intel PTT** (TPM) and **Secure Boot** anyway (Gigabyte `Del` key). Even if Windows 10 doesn't force it, it's safer for anti-cheat.
2.  **Debloat**: Run the **Chris Titus Tech Utility** post-install:
    ```powershell
    irm christitus.com/win | iex
    ```

---

## 3. Storage Strategy (NVMe + HDD)
- **NVMe (256GB)**: Split 150GB (Windows/Valorant) and 100GB (Arch).
- **HDD (1TB)**: Format as **NTFS** for shared games, movies, and bulk storage.

---

## 4. Arch Linux Installation (Key Steps)
- Mount windows EFI to `/boot`: `mount --mkdir /dev/nvme0n1p1 /mnt/boot`
- Install `os-prober` and enable it in `/etc/default/grub`.
- Sync the clock: `timedatectl set-local-rtc 1 --adjust-system-clock`.

---
> [!IMPORTANT]
> Always keep your Arch USB and your BIOS settings (VMD Disabled) in mind if the drive "disappears."
