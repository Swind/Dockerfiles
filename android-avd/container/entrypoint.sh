#!/bin/sh -x

echo n | $ANDROID_HOME/tools/bin/avdmanager create avd \
    -k "system-images;${TARGET};${TAG};${ABI}" \
    -n ${NAME} -b ${ABI} -g ${TAG} ${ANDROID_AVD_EXTRA_ARGS}

(
  # Enable keyboard support in QEMU (for VNC)
  echo 'hw.keyboard = true';
) >> $HOME/.android/avd/Docker.avd/config.ini

adb start-server
pulseaudio -D --exit-idle-time=-1
pacmd load-module module-pipe-sink file=$HOME/audio format=s16 rate=44100 channels=2

mkdir -p $HOME/supervisor/log

sudo chown user:user /dev/kvm

exec $*
