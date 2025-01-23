#!/usr/bin/env bash
# Created with inspiration from https://github.com/rM-self-serve/webinterface-onboot/blob/master/install-webint-ob.sh

# --- Values replaced in github actions ---
version='VERSION'
#webinterface_onboot_sha256sum='WEBINTERFACE_ONBOOT_SHA256SUM'
service_file_sha256sum='SERVICE_FILE_SHA256SUM'
# -----------------------------------------

installfile='./install-remarkable-brightness.sh'
pkgname='remarkable-brightness'
servicefile="/lib/systemd/system/${pkgname}.service"

# TODO this needs updated to an arm64 version of wget (https://github.com/rM-self-serve/webinterface-onboot/issues/6)
# OR...it looks like the reMarkable Paper Pro might already have a wget version that works without this (to be verified)
wget_path=/home/root/.local/share/remarkable-brightness/wget
wget_remote=http://toltec-dev.org/thirdparty/bin/wget-v1.21.1-1
wget_checksum=c258140f059d16d24503c62c1fdf747ca843fe4ba8fcd464a6e6bda8c3bbb6b5

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

srvc_sha_check() {
	sha256sum -c <(echo "$service_file_sha256sum  $servicefile") >/dev/null 2>&1
}

sha_fail() {
	echo "sha256sum did not pass, error downloading ${pkgname}"
	echo "Exiting installer and removing installed files"
	[[ -f $servicefile ]] && rm $servicefile
	exit 1
}

install() {
	echo "Install ${pkgname} ${version}"
	echo ''

  if [ -f "$wget_path" ] && ! sha256sum -c <(echo "$wget_checksum  $wget_path") >/dev/null 2>&1; then
		rm "$wget_path"
  fi
  if ! [ -f "$wget_path" ]; then
		echo "Fetching secure wget"
		# Download and compare to hash
		mkdir -p "$(dirname "$wget_path")"
		if ! wget -q "$wget_remote" --output-document "$wget_path"; then
			echo "Error: Could not fetch wget, make sure you have a stable Wi-Fi connection"
			exit 1
		fi
	fi
	if ! sha256sum -c <(echo "$wget_checksum  $wget_path") >/dev/null 2>&1; then
		echo "Error: Invalid checksum for the local wget binary"
		exit 1
	fi
	chmod 755 "$wget_path"

	need_service=true
	if [ -f $servicefile ]; then
		if srvc_sha_check; then
			need_service=false
			echo "Already have the right version of ${pkgname}.service"
		else
			rm $servicefile
		fi
	fi
	if [ "$need_service" = true ]; then
    "$wget_path" -q "https://github.com/stephenpapierski/${pkgname}/releases/download/${version}/${pkgname}.service" \
			-O "$servicefile"

		if ! srvc_sha_check; then
			sha_fail
		fi

		echo "Fetched ${pkgname}.service"
	fi

	systemctl daemon-reload

	echo ''
	echo "Finished installing $pkgname"
	echo ''
	echo "Run the following command to use ${pkgname}"
	echo "$ systemctl enable ${pkgname} --now"
	echo ''

	[[ -f $installfile ]] && rm $installfile
}
