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
    && DESKTOP_FILE=$(find /usr/share/applications -name "*simplex*.desktop" | head -n 1) \
    && if [ -n "$DESKTOP_FILE" ]; then \
         cp "$DESKTOP_FILE" $HOME/Desktop/ \
         && chmod +x $HOME/Desktop/$(basename "$DESKTOP_FILE") \
         && chown 1000:1000 $HOME/Desktop/$(basename "$DESKTOP_FILE"); \
       else \
         echo "No SimpleX desktop file found. Creating a custom one." \
         && echo "[Desktop Entry]\nName=SimpleX Chat\nExec=/opt/simplex/simplex\nIcon=/opt/simplex/icon.png\nType=Application\nCategories=Network;" > $HOME/Desktop/simplex.desktop \
         && chmod +x $HOME/Desktop/simplex.desktop \
         && chown 1000:1000 $HOME/Desktop/simplex.desktop; \
       fi

# Create startup script to launch SimpleX Chat Desktop
RUN echo "#!/bin/bash\n/usr/bin/desktop_ready\n\n# Find the SimpleX executable\nSIMPLEX_EXEC=\$(find /opt -name \"simplex\" -type f -executable | head -n 1)\n\nif [ -n \"\$SIMPLEX_EXEC\" ]; then\n  \$SIMPLEX_EXEC\nelse\n  echo \"SimpleX executable not found\"\n  exit 1\nfi" > $STARTUPDIR/custom_startup.sh \
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