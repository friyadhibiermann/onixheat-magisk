 ui_print " "
 ui_print "*******************************"
 ui_print "*          ONIXHEAT           *"
 ui_print "*        Magisk Module        *"
 ui_print "*******************************"
 ui_print "*           v1.0.1            *"
 ui_print "*  created by ONIVERSAL       *"
 ui_print "*  revived by dnscrypt-proxy  *"
 ui_print "*******************************"
 ui_print " "
 ui_print "░█████╗░███╗░░██╗██╗"
 ui_print "██╔══██╗████╗░██║██║"
 ui_print "██║░░██║██╔██╗██║██║"
 ui_print "██║░░██║██║╚████║██║"
 ui_print "╚█████╔╝██║░╚███║██║"
 ui_print "░╚════╝░╚═╝░░╚══╝╚═╝"
 ui_print ""
 ui_print "██╗░░██╗██╗░░██╗███████╗░█████╗░████████╗"
 ui_print "╚██╗██╔╝██║░░██║██╔════╝██╔══██╗╚══██╔══╝"
 ui_print "░╚███╔╝░███████║█████╗░░███████║░░░██║░░░"
 ui_print "░██╔██╗░██╔══██║██╔══╝░░██╔══██║░░░██║░░░"
 ui_print "██╔╝╚██╗██║░░██║███████╗██║░░██║░░░██║░░░"
 ui_print "╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░"

  if [ "$ARCH" == "arm" ];then
    BINARY_PATH=$TMPDIR/binary/dnscrypt-proxy-android-arm
  elif [ "$ARCH" == "arm64" ];then
    BINARY_PATH=$TMPDIR/binary/dnscrypt-proxy-android-arm64
  elif [ "$ARCH" == "x86" ];then
    BINARY_PATH=$TMPDIR/binary/dnscrypt-proxy-android-i386
  elif [ "$ARCH" == "x64" ];then
    BINARY_PATH=$TMPDIR/binary/dnscrypt-proxy-android-x86_64
  fi

  CONFIG_PATH=$TMPDIR/config

  unzip -o "$ZIPFILE" 'config/*' 'binary/*' -d $TMPDIR

  ui_print "* Creating binary path"
  mkdir -pv $MODPATH/system/bin

  ui_print "* Creating config & docs path"
  mkdir -p /data/media/0/onixheat/
  mkdir -p /data/media/0/onixheat/log
  mkdir -p /data/media/0/onixheat/rules

  if [ -f "$BINARY_PATH" ]; then
    ui_print "* Copying binary for $ARCH"
    cp -afv $BINARY_PATH $MODPATH/system/bin/dnscrypt-proxy
    cp -rf $TMPDIR/binary/onixheat.sh $MODPATH/system/bin/onixheat.sh
    cp -rf $TMPDIR/binary/termux-onixheat $MODPATH/data/data/com.termux/files/usr/bin/termux-onixheat
  else
    abort "Binary file for $ARCH is missing!"
  fi

  if [ -d "$CONFIG_PATH" ]; then
    ui_print "* Copying example and license files"
    cp -arfv $CONFIG_PATH/* /data/media/0/onixheat/
  else
    abort "Config file is missing!"
  fi

CONFIG_FILE="/data/media/0/dnscrypt-proxy/dnscrypt-proxy.toml" 

  if  [ -f "$CONFIG_FILE" ]; then
    ui_print "* Backing up config file"
	cp -afv  $CONFIG_FILE ${CONFIG_FILE}-backup-`date +%Y%m%d%H%M%S`
  fi
cp -afv /data/media/0/onixheat/dnscrypt-proxy.toml $CONFIG_FILE
set_perm_recursive $MODPATH 0 0 0755 0755
set_perm $MODPATH/system/bin/dnscrypt-proxy 0 0 0755
set_perm $MODPATH/system/bin/onixheat.sh 0 0 0755
set_perm $MODPATH/data/data/com.termux/files/usr/bin/termux-onixheat 0 0 0755
