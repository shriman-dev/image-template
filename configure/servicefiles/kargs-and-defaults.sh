#!/bin/bash
KARGS=$(rpm-ostree kargs)
NEEDED_KARGS=()

if [[ ! $KARGS =~ "nowatchdog" ]]; then
  echo "Adding needed default kargs"
  NEEDED_KARGS+=("--append-if-missing=rd.luks=discard --append-if-missing=rd.udev.log_priority=3 --append-if-missing=loglevel=3 --append-if-missing=nowatchdog --append-if-missing=sysrq_always_enabled=1 --append-if-missing=amdgpu.ppfeaturemask=0xffffffff --append-if-missing=processor.ignore_ppc=1 --append-if-missing=preempt=full --append-if-missing=split_lock_detect=off --append-if-missing=pci=noats")
fi


if [[ -n "$NEEDED_KARGS" ]]; then
  echo "Found needed karg changes, applying the following: ${NEEDED_KARGS[*]}"
  plymouth display-message --text="Updating kargs - Please wait, this may take a while" || true
  rpm-ostree kargs ${NEEDED_KARGS[*]} --reboot || exit 1
else
  echo "No karg changes needed"
fi

creation_date=$(tune2fs -l $(grep "/boot " /proc/mounts | cut -d" " -f1) | grep -oP '(?<=created: ).*' | xargs)
creation_timestamp=$(date -d "$creation_date" +%s)
current_timestamp=$(date +%s)
time_diff=$(( (current_timestamp - creation_timestamp) / 60 ))

if [ $time_diff -le 90 ]; then
hostnamectl set-hostname --static "sanganak"
fi

# Set default target to graphical, fixes rebase from base image
if grep -qv "graphical.target" <<< "$(systemctl get-default)"; then
  systemctl set-default graphical.target
fi
