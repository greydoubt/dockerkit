// x21 = newly allocated socket
*(x21 + 0x18)  = protosw;         // so_proto
*(x21 + 0x1e0) = kauth_cred;      // so_cred
*(x21 + 0x1e4) = proc_pid(p);     // so_last_pid
*(x21 + 0x1e8) = proc_uniqueid(p);// so_last_upid
*(x21 + 0x288) = tpidr_el1;       // so_background_thread
