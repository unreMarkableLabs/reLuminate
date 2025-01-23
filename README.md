<img src="https://github.com/stephenpapierski/reLuminate/blob/main/images/reLuminate-header-min.png?raw=true">

---

# reLuminate
<!--![Static Badge](https://img.shields.io/badge/reMarkable-v3.13-green)-->
[![rmPP](https://img.shields.io/badge/rMPP-supported-green)](https://remarkable.com/store/remarkable-paper/pro)
[![Discord](https://img.shields.io/discord/385916768696139794.svg?label=reMarkable&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/ATqQGfu)

reLuminate is a service to enable enhanced screen brightness levels beyond the factory limits on the reMarkable Paper Pro. This change persists across system boots.
> [!CAUTION]
> This hack is provided 'as-is' and without warranty. We assume no liability for any damage resulting from hardware modifications.
> This project is neither affiliated with nor endorsed by reMarkable AS. Modifying your device may void your warranty and official
> support may refuse to help you. **Proceed at your own risk!**

## reMarkable Software Version Compatibility
Unknown (for now). All?
<!-- - ✅ <= v2.14
- ✅ >= v2.15 - Requires simple binary hack
--- -->

## Installation
To start, enable [developer mode](https://developer.remarkable.com/documentation/developer-mode) and `ssh` to your tablet.
> [!WARNING]
> Enabling developer mode will wipe your tablet.

### Install
This will install and enable the service.

`$ wget -q https://github.com/stephenpapierski/reLuminate/releases/latest/download/install-reLuminate.sh && bash install-reLuminate.sh`

### Remove
This will disable and remove the service.

`$ wget -q https://github.com/stephenpapierski/reLuminate/releases/latest/download/install-reLuminate.sh && bash install-reLuminate.sh remove`

## Usage
### To enable reLuminate service (done automatically on install), run:
`$ systemctl enable reLuminate --now`

### To disable reLuminate service, run:
`$ systemctl disable reLuminate --now`

## How Does It Work?
During boot, the service will enable the linear_mapping mode on the front light.

`echo yes > /sys/class/backlight/rm_frontlight/linear_mapping`

# Reference Articles/Posts
Brightness hack

https://www.reddit.com/r/RemarkableTablet/comments/1g0x5tm/about_5_times_brighter_front_light_available_in/

https://raqami.io/tips-tricks/remarkable-paper-pro-hack-for-brighter-frontlight-tutorial/

https://www.reddit.com/r/RemarkableTablet/comments/1g09l0p/comment/lr7ximy/?share_id=aQgCCoBfX9XT25axEWlbw&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=1

Remounting file system

https://www.reddit.com/r/RemarkableTablet/comments/1fiztzv/nonobvious_tips_for_loading_your_custom_templates/

wget https support

https://github.com/toltec-dev/bootstrap/tree/main

https://github.com/rM-self-serve/webinterface-onboot/issues/6

remarkable-toolchain

https://remarkable.guide/devel/toolchains.html#docker

rMPP kernel

https://github.com/reMarkable/linux-imx-rm

cross-compile wget for arm

https://www.matteomattei.com/cross-compile-wget-statically-for-arm/
