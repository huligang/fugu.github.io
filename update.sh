#!/bin/sh
dpkg-scanpackages --multiversion root > Packages
dpkg-scanpackages --multiversion rootless >> Packages

cat Packages | xz > Packages.xz
cat Packages | bzip2 > Packages.bz2
cat Packages | gzip > Packages.gz
cat Packages | lzma > Packages.lzma
cat Packages | zstd > Packages.zst

apt-ftparchive\
 -o APT::FTPArchive::Release::Origin="Coolwcat Repo"\
 -o APT::FTPArchive::Release::Label="Coolwcat Repo"\
 -o APT::FTPArchive::Release::Suite="stable"\
 -o APT::FTPArchive::Release::Version="1.0"\
 -o APT::FTPArchive::Release::Codename="ios"\
 -o APT::FTPArchive::Release::Architectures="iphoneos-arm iphoneos-arm64"\
 -o APT::FTPArchive::Release::Components="main"\
 -o APT::FTPArchive::Release::Description="Coolwcat tweak repository"\
 release . > Release

git add .
git commit -m "update repo"
git push
