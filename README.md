## Set of scripts to create customized Live Ubuntu on USB keys.

These scripts allow to create bootable (BIOS+EFI) USB key with customized Ubuntu install
and persistent `/home` directory.
Take a look at `arduino/customize.sh` to see how customization is done.

You'll need a Linux machine with `rsync`, `grub`, and `squashfs` tools installed<br>
If using Debian/Ubuntu, do
```
sudo apt-get install rsync squashfs-tools grub-pc-bin grub-efi-amd64-bin
```

## Usage:
```
sudo ./ubuntu-live-remaster/bin/remaster -i ISO -w DIR -c CUSTOMIZE -l LABEL -d DEVICE
```
* ISO - Ubuntu ISO image, eg ubuntu-16.04.3-desktop-amd64.iso
* DIR - Work directory where ISO is unpacked/customized.  Needs to have at least 1Gig of free space.
* CUSTOMIZE - Customization script, eg `arduino/customize.sh`.
              Script will be invoked with first argument being the root of customized build
* LABEL - Disk/boot label, eg "Ubuntu/Arduino"
* DEVICE - USB device to install to, eg /dev/sdb.  The data on the device will be overwritten!

The remaster scripts calls following:
```
./ubuntu-live-remaster/bin/remaster.extract $ISO $WORK
./ubuntu-live-remaster/bin/remaster.customize $WORK/squashfs-root $CUSTOMIZE
./ubuntu-live-remaster/bin/remaster.casper $WORK
bytes="$(expr $(du -bxs $WORK/iso | cut -f1) / 1024 + 1024 \* 100)K"
./ubuntu-live-remaster/bin/remaster.partition $DEVICE $LABEL $bytes
./ubuntu-live-remaster/bin/remaster.install $WORK $DEVICE $LABEL
```
You can invoke the above scripts manually

## Example:

To build Ubuntu+Arduino, I do the following:
```
sudo ./ubuntu-live-remaster/bin/remaster -i ubuntu-16.04.3-desktop-amd64.iso -w ubuntu+arduino/ -c ubuntu-live-remaster/arduino/customize.sh -l "Ubuntu/Arduino" -d /dev/sdb
```
Careful, the `ubuntu-live-remaster/arduino/customize.sh` will set my ssh pub key as authorized key for each new user.
To avoid that, remove `ubuntu-live-remaster/arduino/root/etc/skel/.ssh/authorized_keys` or use at your own risk.
