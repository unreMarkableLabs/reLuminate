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

	# Make file system writeable
	echo "Remounting file system"
	umount -l /etc
	mount -o remount,rw /

	# Create reLuminate systemd service file
 	echo "Creating systemd service file"
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
 	echo "Enabling $pkgname"
 	systemctl daemon-reload
 	systemctl enable ${pkgname} --now

 	echo "Finished installing $pkgname"
}

remove() {
	echo "Remove ${pkgname}"

	echo "Disabling $pkgname"
	systemctl disable "$pkgname" --now

	# Remove service file and install file
	[[ -f $servicefile ]] && rm $servicefile
	[[ -f $installfile ]] && rm $installfile

	echo "Finished removing ${pkgname}"
}

main "$@"
