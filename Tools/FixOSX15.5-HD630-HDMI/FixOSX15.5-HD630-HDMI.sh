#!/bin/sh

echo '修复 HD630 核显在 OSX 10.15.5 下 HDMI 接口黑屏问题
https://github.com/twotreeszf/DeskMiniH310EFI \n
开始修复...'

echo '打开系统权限，请输入管理员密码：'
sudo spctl --master-disable
sudo mount -uw /
sudo killall Finder

echo '备份原版核显驱动'
sudo mv /System/Library/Extensions/AppleIntelCFLGraphicsFramebuffer.kext /System/Library/Extensions/AppleIntelCFLGraphicsFramebuffer.kext.bak
sudo mv /System/Library/Extensions/AppleIntelKBLGraphics.kext /System/Library/Extensions/AppleIntelKBLGraphics.kext.bak

echo '回退核显驱动到 10.15.4'
sudo cp -r ./AppleIntelCFLGraphicsFramebuffer.kext /System/Library/Extensions/
sudo cp -r ./AppleIntelKBLGraphics.kext /System/Library/Extensions/

echo '修复权限 && 刷新缓存'
sudo chown -v -R root:wheel /System/Library/Extensions
sudo touch /System/Library/Extensions
sudo chmod -v -R 755 /Library/Extensions
sudo chown -v -R root:wheel /Library/Extensions
sudo touch /Library/Extensions
sudo kextcache -i /

echo '修复完成，可以重启并连接 HDMI 了！'