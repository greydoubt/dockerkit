#ifndef INCLUDE_FILE_INTERNAL_H
#define INCLUDE_FILE_INTERNAL_H
/* everything in header goes here 
proc	bsd/sys/proc_internal.h
vnode	bsd/sys/vnode_internal.h
socket	bsd/sys/socketvar.h
ucred	bsd/sys/ucred.h
task	osfmk/kern/task.h
thread	osfmk/kern/thread.h
filedesc	bsd/sys/filedesc.h
fileproc	bsd/sys/file_internal.h
fileglob	bsd/sys/file_internal.h
mount	bsd/sys/mount_internal.h

*/
#include "bsd/sys/file_internal.h" //The source tells you what fields exist; the binary tells you where they are.


#endif
