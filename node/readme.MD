savevm/loadvm to an external state file (using pseudo-migration an environment as a packaged VM)

Other migration protocols may vary but mostly follow this pattern:
    
Save VM state into a compressed file
```
stop                                                               
migrate_set_speed 4095m                                            
migrate "exec:gzip -c > STATEFILE.gz"                              
```

Load
```
gzip -c -d STATEFILE.gz | <qemu-command-line> -incoming "exec: cat"   or
<qemu-command-line> -incoming "exec: gzip -c -d STATEFILE.gz"
```

Save VM State into an encrypted file (assumes KEY already exists, otherwise generate one yourself)
```
stop                                                                          
migrate_set_speed 4095m
migrate "exec:gpg -q -e -r KEY -o STATFILE.gpg"
```

Load VM state from an encrypted file
```
gpg -q -d -r KEY STATFILE.gpg | <qemu-command-line> -incoming "exec:cat"
```
