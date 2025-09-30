FROM php:8.2-fpm

ARG user=myuser
ARG uid=1000

# Install neccessary packages, GD, Imagick, FFmpeg, etc.
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    libjpeg-dev \
    libpng-dev \
    libwebp-dev \
    libonig-dev \
    libxml2-dev \
    libfreetype6-dev \
    libmagickwand-dev \
    ffmpeg \
    imagemagick \
    jpegoptim \
    optipng \
    pngquant \
    gifsicle \
    libavif-bin \
    zsh \
    locales && \
    docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp && \
    docker-php-ext-install gd && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Copy composer from the latest composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Add non-root user
RUN echo "UID: $uid, USER: $user" && useradd -G www-data,root -u $uid -d /home/$user -s /bin/zsh $user

# Set up composer directory and permissions
RUN mkdir -p /home/$user/.composer && chown -R $user:$user /home/$user

# Set the working directory
WORKDIR /var/www
RUN chown -R 33:33 /var/www

# Install Oh My Zsh for both root and the non-root user
RUN curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash || true

# Ensure Oh My Zsh is properly set up for non-root user
RUN mkdir -p /home/$user/.oh-my-zsh && chown -R $user:$user /home/$user/.oh-my-zsh

# Copy aliases for both root and myuser
COPY ./aliases.sh /home/$user/aliases.sh
COPY ./aliases.sh /root/aliases.sh

# Ensure the aliases file is executable
RUN chmod +x /home/$user/aliases.sh && chmod +x /root/aliases.sh

# Configure zsh to load aliases and prevent interactive prompt
RUN echo "source /home/$user/aliases.sh" >> /home/$user/.zshrc && \
    echo "source /root/aliases.sh" >> /root/.zshrc && \
    chown $user:$user /home/$user/.zshrc

# Install additional zsh plugins
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.5/zsh-in-docker.sh)" -- \
    -p git \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-completions

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set debconf to non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Set locales and ensure UTF-8 encoding
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Ensure .zshrc is sourced when logging in
RUN echo "source ~/.zshrc" >> /home/$user/.bashrc

# Switch to non-root user
USER $user
