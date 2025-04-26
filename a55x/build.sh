echo "  _____ _          _  ____   _____ "
echo " |  __ (_)        | |/ __ \ / ____|"
echo " | |__) |__  _____| | |  | | (___  "
echo " |  ___/ \ \/ / _ \ | |  | |\___ \ "
echo " | |   | |>  <  __/ | |__| |____) |"
echo " |_|   |_/_/\_\___|_|\____/|_____/ "
echo "                                   "

ROOT_DIR="$(pwd)"
cd $ROOT_DIR

ANDROID_SOURCE_VERSION="15.0"
ANDROID_QPR="QPR2"
ANDROID_BUILD_VERSION="bp1a"

echo "Building PixelOS version $ANDROID_SOURCE_VERSION ($ANDROID_BUILD_VERSION)"
echo "---------------------------"

source build/envsetup.sh
ccache -M 50G -F 0

START_TIME=$(date +%s)
RELEASE_DATE=$(date +%Y%m%d)
RELEASE_DATE_FMT=$(date +%Y-%m-%d)

cd ~/pixelos

compress() {
    echo "----- Compressing the variant -----"
    cd $ROOT_DIR/out/target/product/a55x
    xz -9 -T0 -v -z system.img
    mv system.img.xz $HOME/Downloads/pixelos_a55x-$ANDROID_SOURCE_VERSION-unofficial-$RELEASE_DATE.img.xz
}

build() {
    cd $ROOT_DIR
    lunch pixelos_a55x-$ANDROID_BUILD_VERSION-userdebug
    make systemimage -j$(nproc --all) || exit
    compress
}

echo "----- Building EROFS variant -----"
variant="erofs"
build

END_TIME=$(date +%s)
DELTA_TIME=$((END_TIME - START_TIME))
DELTA_MINUTES=$((DELTA_TIME / 60))

echo "----- Done! -----"
echo "Start time: $START_TIME"
echo "End time: $END_TIME"
echo "Delta time (minutes): $DELTA_MINUTES"
erofs_size=$(wc -c < $HOME/Downloads/pixelos_a55x-$ANDROID_SOURCE_VERSION-unofficial-$RELEASE_DATE.img.xz)
echo "EROFS size: $erofs_size"
