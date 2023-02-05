#!/bin/sh
export vm_id='9000'
export storage='POOL1'
export cloud_img_url=https://cloud-images.ubuntu.com/kinetic/current/kinetic-server-cloudimg-amd64.img
export image_name=${cloud_img_url##*/} # kinetic-server-cloudimg-amd64.img

wget ${cloud_img_url}

# virt-edit -a ${image_name} /etc/cloud/cloud.cfg
# virt-customize --install atop,htop,vim,qemu-guest-agent,curl,wget,net-tools,ncdu -a ${image_name} --truncate /etc/machine-id

qm create ${vm_id} --memory 4048 --core 4 --name ubuntu2210-cloud --net0 virtio,bridge=vmbr0
qm importdisk ${vm_id} ${image_name}  ${storage}
qm set ${vm_id} --scsihw virtio-scsi-pci --scsi0 ${storage}:vm-${vm_id}-disk-0
qm set ${vm_id} --ide0 local-lvm:cloudinit
qm set ${vm_id} --boot c --bootdisk scsi0
qm set ${vm_id} --serial0 socket --vga serial0

exit 0

## DO NOT START YOUR VM yet!
## Now, configure hardware and cloud init, then create a template and clone. 
##      user, ssh-key, dhcp, OS type, Enable QUEMU agentlinux

vm_id='9000'
qm template ${vm_id}

vm_id='9000'
qm clone ${vm_id} 101 --name streamrvm --full

# qm resize ${vm_id} scsi0 +20G

## Troubleshooting
#sudo rm -f /etc/machine-id
#sudo rm -f /var/lib/dbus/machine-id
#sudo systemd-machine-id-setup
