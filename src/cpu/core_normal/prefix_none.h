CASE_B(0xfe)               /* GRP4 Eb */
    {
	    GetRM;Bitu which=(rm>>3)&7;
	    switch (which) {
			case 0x00:     /* INC Eb */
			    RMEb(INCB);
			    break;
			case 0x01:     /* DEC Eb */
			    RMEb(DECB);
			    break;
			case 0x07:     /* CallBack */
			    {
			        Bitu cb=Fetchw();
			        FillFlags();SAVEIP;
			        return cb;
			    }
			default:
				E_Exit("Illegal GRP4 Call %d",(rm>>3) & 7);
				break;
	    }
	    break;
    }


/*

$ ndisasm MOUNT.COM
00000000  BC0004            mov sp,0x400
00000003  BB4000            mov bx,0x40
00000006  B44A              mov ah,0x4a
00000008  CD21              int byte 0x21
0000000A  FE                db 0xfe
0000000B  3805              cmp [di],al
0000000D  00B8004C          add [bx+si+0x4c00],bh
00000011  CD21              int byte 0x21
00000013  02                db 0x02

*/
