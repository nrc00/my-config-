# Windows Debloating Guide: Tiny11 vs. MicroWin vs. NTLite

If you are looking for a lightweight Windows for **Valorant** that fits on a **4GB USB**, here is how the popular options compare.

---

## 1. Tiny11 / Tiny10
A pre-made "stripped down" version of Windows.
- **Pros**: Very small (ISO can be 2GB-3GB); fits easily on a 4GB USB.
- **Cons**: **Dangerous for Valorant.** Many versions of Tiny11 remove the core security components (TPM/Secure Boot checks or Windows Defender) that **Vanguard** needs to verify your system.
- **Verdict**: ❌ **Not Recommended** for Valorant. High risk of a "Vanguard not initialized" error or a ban.

## 2. MicroWin (Chris Titus Tech)
A script that takes a standard Windows ISO and makes it smaller and faster.
- **Pros**: Very stable; uses official Microsoft methods to remove bloat. 
- **Cons**: A standard "MicroWin" ISO is still around 5GB-6GB, which **will not fit** your 4GB USB without extra compression.
- **Verdict**: ⚠️ **Good, but requires extra steps** for your 4GB USB.

## 3. NTLite (Professional Choice)
A powerful tool where you manually pick what to remove.
- **Pros**: Total control. You can make an ISO exactly 3.5GB while keeping Vanguard security files.
- **Cons**: Extremely complex. One wrong click and Windows will crash or fail to install.
- **Verdict**: ⚠️ **Best for experts**, but overkill for most.

---

## ⭐️ The "Ultimate Stack" (Recommended for You)
Since you have a **4GB USB** and need to play **Valorant**, here is the best combination:

### 1. The "Base" (Stock ISO + wimlib)
Don't use a "Lite" ISO. Use the **Official Windows ISO** and use the `wimlib-imagex export` trick I put in your [win11_arch.md](file:///home/kola/Documents/win11_arch.md). 
- This keeps 100% of the system files that Valorant needs.
- It discards useless editions (like Home/Education) to fit on your 4GB USB.

### 2. The "Post-Install" Debloat (WinUtil)
Once Windows is installed, run the **Chris Titus Tech Utility**:
```powershell
irm christitus.com/win | iex
```
- Select **Desktop Tweaks**.
- This removes the "bloat" (TikTok, Candy Crush, Telemetry) **after** the system is safely installed.
- **Vanguard safe**: Because it doesn't remove the kernel-level components Riot checks for.

### 3. "AtlasOS" (Optional)
If you want an even faster experience, you can look into **AtlasOS**. It's a post-install playbook that optimizes Windows for gaming. Like WinUtil, it is much safer than using a pre-modified ISO.

---
> [!IMPORTANT]
> For Valorant on Windows 11, **Secure Boot** and **TPM 2.0** must be functional in the OS. Avoid any tool that claims to "remove TPM requirements."
