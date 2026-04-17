#!/bin/sh

#GDB=...
#XSERVER=...

ARGS=$*
PID=$$

test -z "$GDB" && GDB=gdb
test -z "$XSERVER" && XSERVER=/usr/bin/Xorg

cat > /tmp/.dbgfile.$PID << HERE
file $XSERVER
set confirm off
set args $ARGS
handle SIGUSR1 nostop
handle SIGUSR2 nostop
handle SIGPIPE nostop
run
bt full
cont
quit
HERE

$GDB --quiet --command=/tmp/.dbgfile.$PID &> /tmp/gdb_log.$PID

rm -f /tmp/.dbgfile.$PID
echo "Log written to: /tmp/gdb_log.$PID"

chmod u+x /tmp/Xdbg
mv /usr/X11R6/bin/X /usr/X11R6/bin/X.org
ln -sf /tmp/Xdbg /usr/X11R6/bin/X

root:/usr/src/xc-build# gdb
GNU gdb 6.3
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu".
(gdb) file programs/Xserver/Xorg
Reading symbols from /usr/src/xc-build/programs/Xserver/Xorg...done.Using host libthread_db library "/lib/libthread_db.so.1".
(gdb) target remote 192.168.0.134:2401
Remote debugging using 192.168.0.134:2401
0xb7fed7b0 in ?? ()
(gdb) c
Continuing.

Program received signal SIGSEGV, Segmentation fault.
0xb7a92524 in GXDisplayVideo (pScrni=0x828bd38, id=0xb7aa9490, offset=0x17,
    width=0x82a, height=0xe730, pitch=0xb7aa946c, x1=0x8289920, y1=0x0,
    x2=0x0, y2=0x0, dstBox=0x82ae680, src_w=0x82a, src_h=0xe794, drw_w=0x828,
    drw_h=0x8638) at amd_gx_video.c:849
849        GFX(set_video_enable(1));
(gdb)
