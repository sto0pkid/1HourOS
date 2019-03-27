Learning how to write an operating system, following: https://www.youtube.com/watch?v=1rnA6wpF0o4

To build, simply run:

> make


To install the kernel as a bootable GRUB menu entry, first:

> cp mykernel.bin /boot

Then add the following to the file /boot/grub/grub.cfg :

```
### BEGIN MYKERNEL ###
menuentry 'My Operating System' {
        multiboot /boot/mykernel.bin
        boot
}
### END MYKERNEL ###
```
