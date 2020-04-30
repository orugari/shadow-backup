# shadow-backup
Backup your Disk with a simple and customizable batch script.

<h2>Prerequisities</h2>
Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

<h2>Usage</h2>
Very simple, put the file anywhere and configure variables, for example in C:\ and double click on it, or start it from a terminal.

<h2>Configuration</h2>
<b>VSV</b>: Disk of folder to backup.<br>
<ul><li>"Set VSV=D:" To choose the Hard drive D</li></ul>
<b>DIRSOURCE[n]</b>: Folders to backup from VSV Disk.<br>
 <ul>
 <li>Set "DIRSOURCE[0]=\important_data\"</li>
 <li>Set "DIRSOURCE[1]=\cat_pictures\"</li>
 <li>Set "DIRSOURCE[2]=\other_important_stuff\"</li>
 <li>...</li>
 </ul>
 <b>EXT</b>: Let you choose file extension to backup.
 <ul><li>"Set ECT=*.jpg" To bakup only jpg files.</li><li>"Set ECT=*.*" To bakup all filess.</li></ul>

 <b>Shortc</b>: Shortcut name to access the Shadow copy.
 <ul><li>Set "Shortc=shadowcopy" In this example, access to the Shadow Copy will be C:\Shadowcopy</li></ul>
 
 <b>DELBCK</b>: Say if the Shadow Ccopy and the shortcut must be deleted at the end. TRUE or FALSE.
 <ul><li>Set "DELBCK=TRUE" Will delete Shadow Copy and shortcut</li></ul>
 
 <b>NBRBACKUP</b>: Numbers of backup to keep. It will create folders 1, 2, 3, 4,.. in the target directories where 1 is the newest.
 <ul><li>Set "NBRBACKUP=3" It will keep 3 folders of backup</li></ul>
 
 
 <b>MTNB</b>: Numbers of robocopy's multithread.
 <ul><li>Set "MTNB=8" Will copy 8 files at once. (Robocopy only shows total % for all files being copied.</li></ul>
 
 <h2>Author</h2>
 Orugari (<a href="http://orugari.fr">homepage</a>)
  
 <h2>Support</h2>
 Give a star if you liked it!
