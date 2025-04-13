FROM kasmweb/ubuntu-jammy-desktop:1.16.1
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

ARG SIMPLEX_PACKAGE

COPY ${SIMPLEX_PACKAGE} /home/kasm-default-profile

# Install dependencies required by SimpleX Desktop
RUN apt-get update && apt-get install -y \
    libgmp10 \
    libgtk-3-0 \
    libwebkit2gtk-4.0-37 \
    libayatana-appindicator3-1 \
    libnotify4 \
    libnss3 \
    libxkbfile1 \
    libsecret-1-0 \
    libgbm1 \
    xdg-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install SimpleX Chat Desktop
RUN dpkg -i ${SIMPLEX_PACKAGE} || apt-get -f install -y \
    && cp /usr/share/applications/simplex-chat-desktop.desktop $HOME/Desktop/ \
    && chmod +x $HOME/Desktop/simplex-chat-desktop.desktop \
    && chown 1000:1000 $HOME/Desktop/simplex-chat-desktop.desktop

# Create startup script to launch SimpleX Chat Desktop
RUN echo "/usr/bin/desktop_ready && /opt/simplex-chat-desktop/simplex-chat-desktop" > $STARTUPDIR/custom_startup.sh \
    && chmod +x $STARTUPDIR/custom_startup.sh

# Clean up
RUN rm ${SIMPLEX_PACKAGE}

######### End Customizations ###########

RUN chown -R 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000