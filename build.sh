# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/NusantaraProject-ROM/android_manifest -b 10 --git-lfs -g default,-mips,-darwin,-notdefault
git clone https://github.com/thedoctorsz/local_manifest --depth 1 -b nad-10-lavender .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source $CIRRUS_WORKING_DIR/config
timeStart

source build/envsetup.sh
export BUILD_USERNAME="$USERNAME"
export BUILD_HOSTNAME="$HOSTNAME"
lunch nad_lavender-userdebug
mkfifo reading # Jangan di Hapus
tee "${BUILDLOG}" < reading & # Jangan di Hapus
build_message "Building Started" # Jangan di Hapus
progress & # Jangan di Hapus
mka nad -j8 > reading #& sleep 95m # Jangan di hapus text line (> reading)

retVal=$?
timeEnd
statusBuild
