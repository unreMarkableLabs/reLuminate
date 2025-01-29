#!/usr/bin/env bash
# Created with inspiration from https://github.com/rM-self-serve/webinterface-onboot/blob/master/install-webint-ob.sh

# --- Values replaced in github actions ---
version='VERSION'
# -----------------------------------------

installfile='./install-reLuminate.sh'
pkgname='reLuminate'
servicefile="/lib/systemd/system/${pkgname}.service"

main() {
  case "$@" in
	'install' | '')
	  install
		;;
	'remove')
		remove
		;;
	*)
		echo 'input not recognized'
		cli_info
		exit 0
		;;
	esac
}

cli_info() {
	echo "${pkgname} installer ${version}"
	echo -e "${CYAN}COMMANDS:${NC}"
	echo '  install'
	echo '  remove'
	echo ''
}

install() {
	echo "Install ${pkgname} ${version}"
	echo ''

	# Make file system writeable
	umount -l /etc
	mount -o remount,rw /

	# Create reLuminate systemd service file
	cat > $servicefile <<EOF
	[Unit]
	Description=Enable linear_mapping for reading light
	After=multi-user.target

	[Service]
	Type=oneshot
	RemainAfterExit=yes
	ExecStart=/bin/sh -c 'echo yes > /sys/class/backlight/rm_frontlight/linear_mapping'
	ExecStartPost=/bin/sh -c 'cat /sys/class/backlight/rm_frontlight/max_brightness > /sys/class/backlight/rm_frontlight/brightness'
	ExecStop=/bin/sh -c 'echo no > /sys/class/backlight/rm_frontlight/linear_mapping'
	ExecStopPost=/bin/sh -c 'echo 260 > /sys/class/backlight/rm_frontlight/brightness'

	[Install]
	WantedBy=multi-user.target
EOF

	# Start service
 	systemctl daemon-reload
 	systemctl enable ${pkgname} --now

	echo ''
	echo "Finished installing $pkgname"
	echo ''

	[[ -f $installfile ]] && rm $installfile
}

remove() {
	echo "Remove ${pkgname}"
	echo ''

	if systemctl --quiet is-active "$pkgname" 2>/dev/null; then
		echo "Stopping $pkgname"
		systemctl stop "$pkgname"
	fi
	if systemctl --quiet is-enabled "$pkgname" 2>/dev/null; then
		echo "Disabling $pkgname"
		systemctl disable "$pkgname"
	fi

	[[ -f $servicefile ]] && rm $servicefile
	[[ -f $installfile ]] && rm $installfile

	echo "Successfully removed ${pkgname}"
}

main "$@"
