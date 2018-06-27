FROM ubuntu:16.04 

MAINTAINER Swind Ou <swind@cloudmosa.com>

# Install Git and dependencies
RUN dpkg --add-architecture i386 \
 && apt-get update -y\
 && apt-get install -y file git curl wget zip libncurses5:i386 libstdc++6:i386 zlib1g:i386 default-jdk sudo\
 && apt-get clean \
 && rm -rf /var/lib/apt/lists /var/cache/apt

RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Create a non-root user
RUN useradd -m user
USER user
WORKDIR /home/user

# Set up environment variables
ENV ANDROID_HOME="/home/user/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-4.5.1-all.zip"

# Download Android SDK
RUN mkdir "$ANDROID_HOME" .android \
 && cd "$ANDROID_HOME" \
 && curl -o sdk.zip $SDK_URL \
 && unzip sdk.zip \
 && rm sdk.zip \
 && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

# Install Gradle
RUN wget $GRADLE_URL -O gradle.zip \
 && unzip gradle.zip \
 && mv gradle-4.5.1 gradle \
 && rm gradle.zip \
 && mkdir .gradle

ENV PATH="/home/user/gradle/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"
