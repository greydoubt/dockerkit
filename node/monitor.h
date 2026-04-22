/*
 * @(#)monitor.h	1.24 95/11/29
 *
 * Monitor interface
 */

#ifndef	_MONITOR_H_
#define	_MONITOR_H_

#include "sys_api.h"

/*
 * Used by the monitor caching machanism to mark monitors as being
 * in-use.
 */
#define MON_IN_USE			0x1

/* The monitor data structure */
typedef struct monitor_t {
    unsigned int	key;		/* monitor hash key */
    struct monitor_t   *next;
    short		flags;		/* flags used by the cache */
    short		uninit_count;	/* monitors created, not entered */
    char		mid[1];
} monitor_t, *MID;

/* A macro for accessing the sys_mon_t from the monitor_t */
#define sysmon(m)   (*(sys_mon_t *) m->mid)

typedef struct reg_mon_t {
    sys_mon_t *mid;
    char *name;
    struct reg_mon_t *next;
} reg_mon_t;

/*
 * Macros
 */
#define MID_NULL 	    ((MID) 0)
#define TIMEOUT_INFINITY    -1

/*
 * Support for the monitor registry
 */
extern sys_mon_t *_registry_lock;

#define REGISTRY_LOCK_INIT()    monitorRegister(_registry_lock, \
						"Monitor registry")
#define REGISTRY_LOCK()	  	sysMonitorEnter(_registry_lock)
#define REGISTRY_LOCKED()	sysMonitorEntered(_registry_lock)
#define REGISTRY_UNLOCK()	sysMonitorExit(_registry_lock)

/*
 * External routines.
 */

/*
 * Synchronization interface
 */
void monitorInit(monitor_t *mon);
void monitorCacheInit(void);
void monitorEnter(unsigned int);
void monitorExit(unsigned int);
void monitorWait(unsigned int, int);
void monitorNotify(unsigned int);
void monitorNotifyAll(unsigned int);

/* Registry of static monitors */
extern reg_mon_t *MonitorRegistry;

void monitorRegistryInit(void);
void monitorRegister(sys_mon_t *, char *);
void monitorUnregister(sys_mon_t *);
void registeredEnumerate(void (*)(reg_mon_t *, void *), void *); 

/*
 * Support for the async part of async GC
 */
#define INTERRUPTS_PENDING() sysInterruptsPending()

#endif	/* !_MONITOR_H_ */
