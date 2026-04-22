
#ifndef _MONITOR_CACHE_H_
#define _MONITOR_CACHE_H_

#include "monitor.h"		/* For SYS_TIMEOUT_INFINITY */

extern sys_mon_t *_moncache_lock;
#define CACHE_LOCK_INIT() monitorRegister(_moncache_lock, "Monitor cache lock");
#define CACHE_LOCK()	  sysMonitorEnter(_moncache_lock)
#define CACHE_NOTIFY()	  sysMonitorNotify(_moncache_lock)
#define CACHE_WAIT()	  sysMonitorWait(_moncache_lock, TIMEOUT_INFINITY)
#define CACHE_LOCKED()	  sysMonitorEntered(_moncache_lock)
#define CACHE_UNLOCK()	  sysMonitorExit(_moncache_lock)

/*
 * External routines.
 */
monitor_t *lookupMonitor(unsigned int);
monitor_t *createMonitor(unsigned int);
void monitorDestroy(monitor_t *, unsigned int);
void monitorEnumerate(void (*)(monitor_t *, void *), void *);

#endif /* !_MONITOR_CACHE_H_ */
