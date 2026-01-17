Below is a **single, copy-paste ready** markdown guide that

- puts **ALL of Arch** (`/`, `/home`, swap, EFI, snapshots) on the **NVMe**  
- adds the **730 GB HDD slice** as a **second LUKS+btrfs volume** mounted at `/data`  
- reserves **exactly 200 GB at the END of the HDD** for Windows 11  
- keeps the two LUKS containers independent (different pass-phrases possible)  
- uses **systemd-boot** (Windows-friendly) and **hibernation-capable swapfile**  
- installs **only CLI** (no desktop)

---

## 0.  Pre-flight
- Latest Arch ISO → USB → boot **UEFI**  
- Ethernet cable  
- `timedatectl set-ntp true` already done  
- **BACKUP EVERYTHING** – both disks will be wiped

---

## 1.  Identify drives
```bash
lsblk -o NAME,SIZE,TYPE,MODEL
```
We will use:
| Device        | Size   | Purpose                     |
|---------------|--------|-----------------------------|
| `/dev/nvme0n1` | 112 GB | **Arch root, EFI, swap**    |
| `/dev/sda`     | 931 GB | **730 GB /data** + 200 GB Win11 |

---

## 2.  Partition the HDD (200 GB Win11 at the END)
```bash
gdisk /dev/sda
o                       # new GPT
n ↵ ↵ +731G 8300       # 731 GB Linux data (Arch will use this)
n ↵ ↵ ↵    0700       # last 200 GB, type Microsoft
w
```
Result:
- `/dev/sda1`  731 GB  →  `/data` (LUKS+btrfs)  
- `/dev/sda2`  200 GB  →  Windows 11 later

---

## 3.  Partition the NVMe (Arch only)
```bash
gdisk /dev/nvme0n1
o
n ↵ ↵ +1G   EF00    # EFI
n ↵ ↵ ↵     8300    # Linux (rest)
w
```
Result:
- `/dev/nvme0n1p1`  1 GiB  EFI  
- `/dev/nvme0n1p2`  111 GB Arch root

---

## 4.  LUKS containers
```bash
# NVMe root
cryptsetup luksFormat --type luks2 /dev/nvme0n1p2
cryptsetup open /dev/nvme0n1p2 cryptroot

# HDD data
cryptsetup luksFormat --type luks2 /dev/sda1
cryptsetup open /dev/sda1 cryptdata
```

---

## 5.  Filesystems
```bash
# EFI
mkfs.fat -F 32 -n EFI /dev/nvme0n1p1

# NVMe root – btrfs + sub-volumes
mkfs.btrfs -L archroot /dev/mapper/cryptroot
mount /dev/mapper/cryptroot /mnt
btrfs sub create /mnt/@
btrfs sub create /mnt/@home
btrfs sub create /mnt/@snapshots
btrfs sub create /mnt/@log
btrfs sub create /mnt/@pkg
umount /mnt

# HDD data – single btrfs (you can add sub-volumes later)
mkfs.btrfs -L data /dev/mapper/cryptdata
```

---

## 6.  Mount tree
```bash
# Root
mount -o compress=zstd,ssd,space_cache=v2,subvol=@ \
      /dev/mapper/cryptroot /mnt

mkdir -p /mnt/{boot,home,var/log,var/cache/pacman/pkg,data}

mount -o compress=zstd,ssd,space_cache=v2,subvol=@home \
      /dev/mapper/cryptroot /mnt/home
mount -o compress=zstd,ssd,space_cache=v2,subvol=@log \
      /dev/mapper/cryptroot /mnt/var/log
mount -o compress=zstd,ssd,space_cache=v2,subvol=@pkg \
      /dev/mapper/cryptroot /mnt/var/cache/pacman/pkg

# EFI
mount /dev/nvme0n1p1 /mnt/boot

# HDD data
mount -o compress=zstd,space_cache=v2 \
      /dev/mapper/cryptdata /mnt/data
```

---

## 7.  Install base system
```bash
pacstrap -K /mnt base linux linux-firmware linux-headers \
               btrfs-progs vim nano intel-ucode amd-ucode \
               cryptsetup lvm2 device-mapper mdadm \
               networkmanager base-devel git
```

---

## 8.  fstab
```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

---

## 9.  chroot
```bash
arch-chroot /mnt
```

---

## 10.  Time & locale
```bash
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc

echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8'  > /etc/locale.conf
echo 'KEYMAP=us'         > /etc/vconsole.conf
```

---

## 11.  Hostname
```bash
echo 'archnv' > /etc/hostname
cat >> /etc/hosts <<EOF
127.0.0.1   localhost
::1         localhost
127.0.1.1   archnv.localdomain archnv
EOF
```

---

## 12.  Initramfs
Edit `/etc/mkinitcpio.conf`:
```
HOOKS=(base udev autodetect modconf kms keyboard keymap consolefont block encrypt filesystems fsck)
```
Rebuild:
```bash
mkinitcpio -P
```

---

## 13.  Boot loader (systemd-boot)
```bash
bootctl install
```
Entry:
```bash
cat > /boot/loader/entries/arch.conf <<EOF
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options cryptdevice=UUID=$(blkid -s UUID -o value /dev/nvme0n1p2):cryptroot root=/dev/mapper/cryptroot rootflags=subvol=@ rw quiet
EOF
```
> Remove unused micro-code line.

---

## 14.  Swapfile (hibernation, 8 GB)
```bash
mkdir -p /swap
truncate -s 0 /swap/swapfile
chattr +C /swap/swapfile
btrfs property set /swap/swapfile compression none
dd if=/dev/zero of=/swap/swapfile bs=1M count=8192
chmod 600 /swap/swapfile
mkswap /swap/swapfile
swapon /swap/swapfile

echo '/swap/swapfile none swap defaults 0 0' >> /etc/fstab
```
Resume support:
```bash
sed -i 's/^HOOKS=(/&resume /' /etc/mkinitcpio.conf
mkinitcpio -P

sed -i 's/^options.*/& resume=UUID='"$(findmnt -no UUID /)"' resume_offset='"$(btrfs inspect-internal map-swapfile -r /swap/swapfile)"'/' \
    /boot/loader/entries/arch.conf
```

---

## 15.  Network & user
```bash
systemctl enable NetworkManager

useradd -m -G wheel,uucp,video,audio,storage,optical,lp,scanner -s /bin/bash sam
passwd sam
EDITOR=nano visudo   # uncomment %wheel ALL=(ALL:ALL) ALL
```

---

## 16.  Exit & reboot
```bash
exit
umount -R /mnt
cryptsetup close cryptroot
cryptsetup close cryptdata
reboot
```

---

## 17.  First boot
Update system:
```bash
sudo pacman -Syu
```
Install AUR helper if wanted:
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/paru.git
cd paru && makepkg -si
```

---

## 18.  Later – install Windows 11 (only 200 GB)
1. Boot Windows 11 USB → **Custom install**.  
2. Pick the **200 GB partition** at the **end** of the disk → install.  
3. Windows overwrites EFI boot order → Linux unreachable.  
4. Boot Arch ISO →  
   ```bash
   mount /dev/nvme0n1p1 /efi
   arch-chroot /mnt
   bootctl install
   ```  
5. Reboot – systemd-boot menu shows **Arch Linux** **and** **Windows Boot Manager**.

---

## 19.  Optional (inside Windows)
Use **Disk Management** to create a **D:** drive in the **731 GB unallocated** space if you wish.

---

## 20.  Post-install extras
| Task | Command |
|------|---------|
| Mirror ranking | `reflector -c US -a 6 --sort rate --save /etc/pacman.d/mirrorlist` |
| Snapshots | `sudo pacman -S snapper snap-pac` |
| Firewall | `sudo pacman -S ufw && sudo ufw enable` |
| Printer | `sudo pacman -S cups && sudo systemctl enable cups` |

---

Done!  
**Arch Linux** = **NVMe (root) + 730 GB HDD (`/data`)**, both encrypted.  
**Windows 11** = **200 GB at the very end of the HDD**, nothing else touched.
```
