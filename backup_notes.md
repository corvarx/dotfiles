
# Partition


```
cd ~/wd4t/mycloud_ex2_backup/tryusb/Main/unsorted/oldefs
fpart -o oldefs -s 22G .
mv oldefs.* ~/work/discwork
cd ~/work/discwork
for f in ./oldefs.*; do dnum=$(basename "$f" | cut -d. -f2); mkdir -p ~/wd4t/discwork/disc$dnum; rsync -av --files-from="$f" ~/wd4t/mycloud_ex2_backup/tryusb/Main/unsorted/oldefs ~/wd4t/discwork/disc$dnum; done
```

# Compare source and dest file by file

```
find disc7 -print0 |xargs -0 shasum -a 256 > ~/disc7_src.sha256
find /Volumes/oldefs_7_9/disc7 -print0 |xargs -0 shasum -a 256 > ~/disc7_dst.sha256
vimdiff disc7_src.sha256 disc7_dst.sha256
```
