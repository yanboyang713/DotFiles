#!/bin/bash

# Must run on Proxmox VE 7 server
# Not sure how to handle a cluster - either run on each node or copy template after creating on one?
# e.g. $ ssh root@proxmox.server < proxmox-create-cloud-template.sh

SRC_IMG="https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img"
IMG_NAME="focal-server-cloudimg-amd64-disk-kvm.qcow2"

TEMPL_NAME="ubuntu2004-cloud"
VMID="9000"
MEM="512"
DISK_SIZE="32G"
DISK_STOR="zfs-mirror-pool"
NET_BRIDGE="vmbr0"

# Install libguesetfs-tools to modify cloud image
apt update
apt install -y libguestfs-tools

# Download kvm image and rename
# Ubuntu img is actually qcow2 format and Proxmox doesn't like wrong extensions
wget -O $IMG_NAME $SRC_IMG

# Ubuntu cloud img doesn't include qemu-guest-agent required for packer to get IP details from proxmox
# Add any additional packages you want installed in the template
virt-customize --install qemu-guest-agent -a $IMG_NAME

# Create cloud-init enabled Proxmox VM with DHCP addressing
qm create $VMID --name $TEMPL_NAME --memory $MEM --net0 virtio,bridge=$NET_BRIDGE
qm importdisk $VMID $IMG_NAME $DISK_STOR
qm set $VMID --scsihw virtio-scsi-pci --scsi0 $DISK_STOR:vm-$VMID-disk-0
qm set $VMID --ide2 $DISK_STOR:cloudinit
qm set $VMID --boot c --bootdisk scsi0
qm set $VMID --serial0 socket --vga serial0
qm set $VMID --ipconfig0 ip=dhcp
qm resize $VMID scsi0 $DISK_SIZE

# Convert to template
qm template $VMID

# Remove downloaded image
rm $IMG_NAME

# Next, use packer to clone this template and customize it!

# References
# https://gist.github.com/chriswayg/43fbea910e024cbe608d7dcb12cb8466
# https://whattheserver.com/proxmox-cloud-init-os-template-creation/
# https://norocketscience.at/deploy-proxmox-virtual-machines-using-cloud-init/
# https://pve.proxmox.com/wiki/Cloud-Init_Support
# https://blog.dustinrue.com/2020/05/going-deeper-with-proxmox-cloud-init/

