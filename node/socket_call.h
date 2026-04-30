int sockfd = socket(AF_INET,      /* versus AF_LOCAL */
                    SOCK_STREAM,  /* reliable, bidirectional */
                    0);           /* system picks protocol (TCP) */
