GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore

# --32 | --x32 | --64
#           Select the word size, either 32 bits or 64 bits.  --32 implies
#           Intel i386 architecture, while --x32 and --64 imply AMD x86-64
#           architecture with 32-bit or 64-bit word-size respectively.
#
#           These options are only available with the ELF object file format,
#           and require that the necessary BFD support has been included (on a
#           32-bit platform you have to add --enable-64-bit-bfd to configure
#           enable 64-bit usage and use x86-64 as target platform).


ASPARAMS = --32
LDPARAMS = -melf_i386

objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<


# -T scriptfile
# --script=scriptfile
# Use scriptfile as the linker script.  This script replaces ld's
# default linker script (rather than adding to it), so commandfile
# must specify everything necessary to describe the output file.
# If scriptfile does not exist in the current directory, "ld" looks
# for it in the directories specified by any preceding -L options.
# Multiple -T options accumulate.


mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)


install: mykernel.bin
	sudo cp $< /boot/mykernel.bin

clean:
	rm *.o *.bin
