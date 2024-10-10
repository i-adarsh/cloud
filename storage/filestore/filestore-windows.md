# Access Filestore from Windows Machine: A Step-by-Step Guide

This guide provides step-by-step instructions for mounting a Filestore file share on a Compute Engine VM instance. To follow this guide, ensure your VM and Filestore instance reside in the same Google Cloud project and VPC network.

`Step 1:` Install NFS on the Windows VM

```sh filename="Powershell" copy
Install-WindowsFeature -Name NFS-Client
```

`Step 2:` Configure the user ID used by the NFS client

```sh filename="Powershell" copy
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" `
    -Name "AnonymousUid" -Value "0" -PropertyType DWORD

New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\ClientForNFS\CurrentVersion\Default" `
    -Name "AnonymousGid" -Value "0" -PropertyType DWORD
```

`Step 3:` Restart the NFS client service

```sh filename="Powershell" copy
nfsadmin client stop

nfsadmin client start
```

`Step 4:` Connect file share to the Windows VM

```sh filename="Powershell" copy
net use Z: \\10.254.33.194\filestore

net use Z: \\10.254.33.194\filestore /persistent:yes
```

The `/persistent:yes` flag ensures that the drive mapping is restored each time you log in to the Windows VM.