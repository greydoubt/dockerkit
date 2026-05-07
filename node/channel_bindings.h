typedef struct gss_channel_bindings_struct {
            OM_uint32       initiator_addrtype;
            gss_buffer_desc initiator_address;
            OM_uint32       acceptor_addrtype;
            gss_buffer_desc acceptor_address;
            gss_buffer_desc application_data;
         } *gss_channel_bindings_t;
