; Functions named *_iterate, *_foreach, or *_walk traverse linked lists of kernel objects. They reveal:

;     The global head pointer of the list (a kernel global variable)
;     The list entry offset within the struct. It is often +0x00 for the primary list, but a struct can have multiple list entries at different offsets (e.g. proc.p_list at +0x00 vs proc.p_hash at +0xA0)
;     The count variable (for instance nprocs, in proc_iterate)
;     Various field accesses used for filtering



allproc global	First data reference loaded as list head	= 0xfffffff0078b7728
zombproc global	Second list head (conditional on flags)	= 0xfffffff0078b7730
nprocs global	Loop bound variable	= 0xfffffff0078b7d00
p_list.le_next	i = *i (following the list)	= +0x00
p_pid	Stored into pidlist array	= +0x60
p_stat	Compared against 1 (zombie filter)	= +0x64
p_listflag	Reference count manipulation	= +0x464
