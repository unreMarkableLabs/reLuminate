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
- ✅ All software versions

## Installation
To start, enable <a href="https://developer.remarkable.com/documentation/developer-mode" target="_blank">developer mode</a> and gain `ssh` access to your tablet. The install instructions assume you are sshing over USB where the tablet will show up at `10.11.99.1`. If you are sshing wirelessly, substitute the correct IP address.
> [!WARNING]
> Enabling developer mode will wipe your tablet.

### Install
1. Download <a href="https://github.com/unreMarkableLabs/reLuminate/releases/latest/download/install-reLuminate.sh" target="_blank">`install-reLuminate.sh`</a>
1. Copy `install-reLuminate.sh` to reMarkable tablet

   `scp install-reLuminate.sh root@10.11.99.1:~`
1. ssh to reMarkable tablet

   `ssh root@10.11.99.1`
1. Install reLuminate

   `bash install-reLuminate.sh install`

### Remove
1. Download <a href="https://github.com/unreMarkableLabs/reLuminate/releases/latest/download/install-reLuminate.sh" target="_blank">`install-reLuminate.sh`</a>
1. Copy `install-reLuminate.sh` to reMarkable tablet

   `scp ./install-reLuminate.sh root@10.11.99.1:~`
1. ssh to reMarkable tablet

   `ssh root@10.11.99.1`
1. Uninstall reLuminate

   `bash install-reLuminate.sh remove`

## Usage
### To enable reLuminate service (done automatically on install), run:
`$ systemctl enable reLuminate --now`

### To disable reLuminate service, run:
`$ systemctl disable reLuminate --now`

## How Does It Work?
During boot, the service will enable the linear_mapping mode on the front light. This enables increased brightness levels.

`echo yes > /sys/class/backlight/rm_frontlight/linear_mapping`

# Support
If this project made your life a little easier, consider supporting!

<a href="https://www.buymeacoffee.com/stephenpapierski" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="41"></a>


# Reference Articles/Posts

https://www.reddit.com/r/RemarkableTablet/comments/1g0x5tm/about_5_times_brighter_front_light_available_in/

https://raqami.io/tips-tricks/remarkable-paper-pro-hack-for-brighter-frontlight-tutorial/

https://www.reddit.com/r/RemarkableTablet/comments/1g09l0p/comment/lr7ximy/?share_id=aQgCCoBfX9XT25axEWlbw&utm_medium=android_app&utm_name=androidcss&utm_source=share&utm_term=1
