allproc global	First data reference loaded as list head	= 0xfffffff0078b7728
zombproc global	Second list head (conditional on flags)	= 0xfffffff0078b7730
nprocs global	Loop bound variable	= 0xfffffff0078b7d00
p_list.le_next	i = *i (following the list)	= +0x00
p_pid	Stored into pidlist array	= +0x60
p_stat	Compared against 1 (zombie filter)	= +0x64
p_listflag	Reference count manipulation	= +0x464
